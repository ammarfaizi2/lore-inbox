Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWDRUgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWDRUgf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 16:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWDRUgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 16:36:35 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:59785 "EHLO
	victor.provo.novell.com") by vger.kernel.org with ESMTP
	id S932321AbWDRUge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 16:36:34 -0400
Message-ID: <44454DA4.90902@novell.com>
Date: Tue, 18 Apr 2006 13:35:48 -0700
From: Crispin Cowan <crispin@novell.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com>	 <1145381250.19997.23.camel@jackjack.columbia.tresys.com>	 <44453E7B.1090009@novell.com> <1145391252.16632.231.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1145391252.16632.231.camel@moss-spartans.epoch.ncsc.mil>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley wrote:
> On Tue, 2006-04-18 at 12:31 -0700, Crispin Cowan wrote:
>   
>> AppArmor (then called "SubDomain") showed how this worked in practice
>> years before the Targeted Policy came along. The Targeted Policy
>> implements an approximation to the AppArmor security model, but does it
>> with domains and types instead of path names, imposing a substantial
>> cost in ease-of-use on the user.
>>     
> Just to clarify a few points:
> - It is true that both AppArmor and SELinux with targeted policy only
> (effectively) restrict a subset of processes, but SELinux with targeted
> policy provides complete mediation of all objects and operations for
> those processes, not just capabilities and files like AppArmor.
>   
Agreed, with the caveat that mediating all those things comes with
expense, and AppArmor doesn't mediate them by design, because our goal
is to keep the host from being compromised by a hacked application, not
to control all information flow. Different goals produce different designs.

> - Targeted policy demonstrates that a general purpose mechanism that is
> capable of complete mediation of all processes, objects, and operations
> (SELinux) can be applied to selective control if that is your goal.  The
> reverse is not true; AppArmor is limited by its design.
>   
Also agreed, and also caveated that the general purpose system emulating
the simple system is much more complex than the simple system itself,
and simplicity is a critical part of secure design. In this case, the
most expensive impact on simplicity is the complexity of the policy that
users have to manage.

> - Ease of use should be addressed in the user interface, not by using a
> broken kernel mechanism.   There is ongoing work to address the
> useability of SELinux in userspace; it doesn't require changing the
> kernel mechanism to rely on pathnames (which is broken).
>   
Mediating by file names rather than inodes is the fundamental place
where we disagree. I am delighted with LSM, because it allows us to
disagree without having to fight about it.

Crispin
-- 
Crispin Cowan, Ph.D.                      http://crispincowan.com/~crispin/
Director of Software Engineering, Novell  http://novell.com

