Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129903AbRCAUag>; Thu, 1 Mar 2001 15:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129901AbRCAUa1>; Thu, 1 Mar 2001 15:30:27 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2052 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129890AbRCAUaO>;
	Thu, 1 Mar 2001 15:30:14 -0500
Date: Wed, 28 Feb 2001 12:30:14 +0000
From: Pavel Machek <pavel@suse.cz>
To: Petr Konecny <pekon@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk change messages
Message-ID: <20010228123014.B40@(none)>
In-Reply-To: <qwwvgpvdhdr.fsf@decibel.fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <qwwvgpvdhdr.fsf@decibel.fi.muni.cz>; from pekon@informatics.muni.cz on Tue, Feb 27, 2001 at 09:02:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've been trying to use vold to automount CDs. The daemon tries to open
> /dev/cdrom and if it succeeds it examines the media and mounts it under
> /cdrom/volume_name.
> 
> The problem is that when there is no disk in the drive the following
> message:
>   VFS: Disk change detected on device ide1(22,0)
> is written to system log during each open call.  Vold calls open every 5
> seconds, so it's 17280 lines in log/day. I have been able to avoid these
> messages by commenting out a line in drivers/ide/ide-cd.c (patch
> included) and have not seen any problems yet.
> 
> I guess I have three questions:
>  1. can this patch break things ? I suppose it could happen only

No.

>  2. is it possible to avoid the message by modifying vold ? E.g. finding
>     out that there is no media in the drive without calling open.

Don't think so.

>  3. is there a clean way to avoid these repeated messages ?

Syslogdshould sumarize "last message repeated 123456 times"
.

>                                                 Thanks, Petr
> 
> --- ide-cd.c    2001/02/22 22:30:02     1.1.1.11
> +++ ide-cd.c    2001/02/27 19:51:58
> @@ -601,7 +601,7 @@
> 
>                 /* Check for tray open. */
>                 if (sense_key == NOT_READY) {
> -                       cdrom_saw_media_change (drive);
> +/*                     cdrom_saw_media_change (drive); */
>                 } else if (sense_key == UNIT_ATTENTION) {
>                         /* Check for media change. */
>                         cdrom_saw_media_change (drive);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

