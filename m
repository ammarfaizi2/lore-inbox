Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266572AbUITONA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266572AbUITONA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 10:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUITONA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 10:13:00 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:33413 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S266572AbUITOM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 10:12:57 -0400
Date: Mon, 20 Sep 2004 16:12:56 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Olaf Hering <olh@suse.de>, DervishD <lkml@dervishd.net>,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
Message-ID: <20040920141256.GB601@MAIL.13thfloor.at>
Mail-Followup-To: Helge Hafting <helge.hafting@hist.no>,
	Olaf Hering <olh@suse.de>, DervishD <lkml@dervishd.net>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920094602.GA24466@suse.de> <20040920105950.GI5482@DervishD> <414EDA10.7050304@hist.no> <20040920132151.GA30175@suse.de> <414EDC0B.3030108@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414EDC0B.3030108@hist.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 03:32:59PM +0200, Helge Hafting wrote:
> Olaf Hering wrote:
> 
> >On Mon, Sep 20, Helge Hafting wrote:
> >
> >>Using a mtab that is a link to /proc/mounts fails with quota too.
> >>Quta tools read /etc/mtab looking for "usrquota" and or "grpquota"
> >>mount options.  These appear in a normal /etc/mtab but not in 
> >>/proc/mounts,
> >
> >I have never played with quota. But: does the kernel or a userland tool
> >if quota is active for a mount point? smells like a kernel bug.

- to make the quota active (enable it), the mount option
  is required

- to display an enabled quota as mount option, the quota
  on that 'mount point' has to be enabled 

chicken egg thing, eh?

besides that, not every mountpoint can support quota
and quota should (must) not be enabled at mount time
because before the quota is enabled, the quota hash
has to be initialized to the current usage ...

> The kernel must know that quota is in use, or it'd be unable to
> refuse the syscalls when someone tries to go over his quota.

yep, after 'enabling' quota on a specific filesystem
the kernel knows which quota is enabled ...

> From "man mount":
>       grpquota / noquota / quota / usrquota
>              These  options are accepted but ignored.  (However, quota 
> utili???
>              ties may react to such strings in /etc/fstab.)
> 
> quota utilities indeed react to such strings in /etc/mtab too.
> 
> Qutas aren't actually enabled when the mount options are used,
> they are enabled when the "quotaon" tool runs.  I guess it uses
> some special syscall or ioctl to really turn quota on.

yes, and basically the 'mount options' are not stored
by the kernel in any way, so it would be simple to 
remove that check in the quota tools and replace them
by something else ...

> Doing it at mount time instead, byt actually using those options,
> seems saner to me.  But I guess they had their reasons. . .

yes, quota calculation, see above ...

HTH,
Herbert

> Helge Hafting
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
