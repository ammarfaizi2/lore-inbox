Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267552AbUIUJSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267552AbUIUJSr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 05:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267543AbUIUJSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 05:18:47 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:48518 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S267552AbUIUJSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 05:18:18 -0400
Date: Tue, 21 Sep 2004 11:18:16 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Olaf Hering <olh@suse.de>, DervishD <lkml@dervishd.net>,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
Message-ID: <20040921091816.GA12215@MAIL.13thfloor.at>
Mail-Followup-To: Helge Hafting <helge.hafting@hist.no>,
	Olaf Hering <olh@suse.de>, DervishD <lkml@dervishd.net>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920094602.GA24466@suse.de> <20040920105950.GI5482@DervishD> <414EDA10.7050304@hist.no> <20040920132151.GA30175@suse.de> <414EDC0B.3030108@hist.no> <20040920141256.GB601@MAIL.13thfloor.at> <414FD624.7050603@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414FD624.7050603@hist.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2004 at 09:20:04AM +0200, Helge Hafting wrote:
> Herbert Poetzl wrote:
> 
> >On Mon, Sep 20, 2004 at 03:32:59PM +0200, Helge Hafting wrote:
> > 
> >>Olaf Hering wrote:
> >>
> >>>On Mon, Sep 20, Helge Hafting wrote:
> >>>
> >>>>Using a mtab that is a link to /proc/mounts fails with quota too.
> >>>>Quta tools read /etc/mtab looking for "usrquota" and or "grpquota"
> >>>>mount options.  These appear in a normal /etc/mtab but not in 
> >>>>/proc/mounts,
> >>>>       
> >>>I have never played with quota. But: does the kernel or a userland tool
> >>>if quota is active for a mount point? smells like a kernel bug.
> >
> >- to make the quota active (enable it), the mount option
> > is required
> >
> >- to display an enabled quota as mount option, the quota
> > on that 'mount point' has to be enabled 
> >
> >chicken egg thing, eh?
> >
> Chicken egg by design perhaps, but I can't see
> why it have to be that way.
> 
> >besides that, not every mountpoint can support quota
> >and quota should (must) not be enabled at mount time
> >because before the quota is enabled, the quota hash
> >has to be initialized to the current usage ...
> > 
> >
> A better way:
> Enable the quota at mount time.  If the system isn't ready
> for that, i.e. the quota files aren't created/updated - then
> refuse the mount.  (Alternatively, mount without quota and
> log a complaint.) The administrator can then mount
> without quota, run checkquota, and  mount /fs -o remount,usrquota
> to turn quota on.
> 
> In other words:
> quotaon becomes mount -o remount,usrquota
> quotaoff becomes mount -o remount,nousrquota
> (And/or grpquota of course)
> 
> Does it have to be any more complicated than that?

probably not, but I guess you have to discuss
this with the quota maintainer ... ;)

best,
Herbert

> >>Doing it at mount time instead, byt actually using those options,
> >>seems saner to me.  But I guess they had their reasons. . .
> >
> >yes, quota calculation, see above ...
> > 
> What I don't get is why we have to mount with quota options
> that aren't acutally used, and then turn quota on.
> Why not mount without quota, and then remount with
> quota options when enabling quota for the first time?
> 
> The common case should be a fs that was shut down
> cleanly and was mounted with quota the last time it
> was used.  So it should be able to mount directly
> with quota on, because all the on-disk quota information
> is valid and up to date.
> 
> Helge Hafting
> 
