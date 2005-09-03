Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbVICWS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbVICWS6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 18:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVICWS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 18:18:58 -0400
Received: from smtp.istop.com ([66.11.167.126]:58561 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1751004AbVICWS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 18:18:57 -0400
From: Daniel Phillips <phillips@istop.com>
To: Wim Coekaerts <wim.coekaerts@oracle.com>
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Date: Sat, 3 Sep 2005 18:21:26 -0400
User-Agent: KMail/1.8
Cc: linux clustering <linux-cluster@redhat.com>,
       Mark Fasheh <mark.fasheh@oracle.com>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <200509030242.36506.phillips@istop.com> <20050903064633.GB4593@ca-server1.us.oracle.com>
In-Reply-To: <20050903064633.GB4593@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509031821.27070.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 September 2005 02:46, Wim Coekaerts wrote:
> On Sat, Sep 03, 2005 at 02:42:36AM -0400, Daniel Phillips wrote:
> > On Friday 02 September 2005 20:16, Mark Fasheh wrote:
> > > As far as userspace dlm apis go, dlmfs already abstracts away a large
> > > part of the dlm interaction...
> >
> > Dumb question, why can't you use sysfs for this instead of rolling your
> > own?
>
> because it's totally different. have a look at what it does.

You create a dlm domain when a directory is created.  You create a lock 
resource when a file of that name is opened.  You lock the resource when the 
file is opened.  You access the lvb by read/writing the file.  Why doesn't 
that fit the configfs-nee-sysfs model?  If it does, the payoff will be about 
500 lines saved.

This little dlm fs is very slick, but grossly inefficient.  Maybe efficiency 
doesn't matter here since it is just your slow-path userspace tools taking 
these locks.  Please do not even think of proposing this as a way to export a 
kernel-based dlm for general purpose use!

Your userdlm.c file has some hidden gold in it.  You have factored the dlm 
calls far more attractively than the bad old bazillion-parameter Vaxcluster 
legacy.  You are almost in system call zone there.  (But note my earlier 
comment on dlms in general: until there are dlm-based applications, merging a 
general-purpose dlm API is pointless and has nothing to do with getting your 
filesystem merged.)

Regards,

Daniel
