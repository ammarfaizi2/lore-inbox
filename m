Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWDSPWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWDSPWz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWDSPWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:22:55 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:19376 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750886AbWDSPWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:22:54 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Safford <safford@watson.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, James Morris <jmorris@namei.org>,
       casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1145458322.2377.12.camel@localhost.localdomain>
References: <20060417180231.71328.qmail@web36606.mail.mud.yahoo.com>
	 <1145297742.8542.206.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417192634.GB18990@sergelap.austin.ibm.com>
	 <Pine.LNX.4.64.0604171528340.17923@d.namei>
	 <20060417194759.GD18990@sergelap.austin.ibm.com>
	 <1145304146.8542.251.camel@moss-spartans.epoch.ncsc.mil>
	 <1145458322.2377.12.camel@localhost.localdomain>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 19 Apr 2006 11:26:57 -0400
Message-Id: <1145460417.24289.116.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 10:52 -0400, David Safford wrote:
> It was certainly agreed that integrity needed to be a separate service
> available to any access control module, with nothing specific to SLIM, 
> and that a number of design and implementation problems had to be fixed. 
> During testing we also found a number of other bugs which weren't raised 
> on the list, which had to be fixed. (That's what has taken us so long to 
> post a new version.) As to whether it should be tightly coupled to an
> LSM module, or should be a separate service with its own kernel hooks,
> I think was not settled. 

Ok, either way removal of LSM isn't an issue in that case.

> I seem to recall a number of people arguing for the low water-mark 
> integrity policy as one which provides a simple, user friendly 
> policy, one which has been demonstrated and tested not only by
> SLIM, but also with predecessors, such as LOMAC. 
> 
> I do understand and respect the selinux position against dynamic 
> labels, since they require revocation, and particularly since at 
> that time, we had not implemented revocation of mmap access. We 
> have been quietly studying, fixing, and testing the design and
> implementation errors pointed out earlier, and still feel strongly 
> that low water-mark policies have a place, particularly in client
> systems. 

My concerns with low water mark were noted in
http://marc.theaimsgroup.com/?l=linux-security-module&m=113232319627338&w=2
http://marc.theaimsgroup.com/?l=linux-security-module&m=113319033229209&w=2
http://marc.theaimsgroup.com/?l=linux-security-module&m=113327082228907&w=2

I also pointed out examples of how low water mark has
compatibility/useability problems of its own in that discussion.  And it
has only has the two options available to all such "simple" models when
reality conflicts with their model:  preserve the model and break the
functionality or make the process a trusted subject fully capable of
violating the model (at which point you are only pretending to enforce
the model).  Versus being able to configure the policy to match reality,
as in SELinux.

> Since selinux (by choice) cannot implement policies with dynamic labels,
> I believe LSM is important for work in alternative access control
> models, like low water-mark, to continue.

If such models can demonstrate their viability, then you can ultimately
submit a patch to extend SELinux/Flask to support them - I have no
problem with that (again, if they can be shown to be viable and
implementation is correct).  But first you have to show that.  In the
meantime, your work can be done via a kernel patch that you carry; it
doesn't justify keeping LSM in mainline.  Note too that LSM seems to me
to be harmful to such work, because many of the mistakes you made in the
first place might have been avoided if you had started by extending the
existing SELinux/Flask infrastructure (which had much more defined
semantics) than using LSM (which is just a skeletal framework with no
real semantics).  Plus it might have encouraged you to propose each
change as a small patch to SELinux along the way and gotten you valuable
feedback sooner.

-- 
Stephen Smalley
National Security Agency

