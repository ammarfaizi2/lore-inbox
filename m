Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271911AbRJTIuX>; Sat, 20 Oct 2001 04:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271800AbRJTIuM>; Sat, 20 Oct 2001 04:50:12 -0400
Received: from femail43.sdc1.sfba.home.com ([24.254.60.37]:43165 "EHLO
	femail43.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S271741AbRJTIuE>; Sat, 20 Oct 2001 04:50:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: Poor floppy performance in kernel 2.4.10
Date: Sat, 20 Oct 2001 00:20:38 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <20011018194415.S12055@athlon.random> <XFMail.20011019095006.pochini@shiny.it> <9qpihk$23p$1@penguin.transmeta.com>
In-Reply-To: <9qpihk$23p$1@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <0110200020380L.15870@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 October 2001 11:57, Linus Torvalds wrote:

> Well, the original reason to not trust the media-change signal is that
> some floppy drives simply do not implement the signal at all. Don't ask
> me why. So a loong time ago Linux had the problem that when you changed
> floppies you wouldn't see the new information - or you'd see _partially_
> new and old information depending on what your access patterns were and
> what the caches contained.
>
> So it's pretty much across the board - broken SCSI, broken floppies,
> just about any changeable media tends to have _some_ bad cases. And with
> the floppy case, there was no way to notice at run-time whether the unit
> was broken or not - the floppy drives have no ID's to blacklist etc. So
> either you tell people to flush their caches by hand (which we did), or
> you just always flush it between separate opens (which we later did).
>
> 			Linus

The original dos case was timeout based.  They sat down and changed the disk 
as fast as they could, and worked out it took something like two and a half 
seconds to swap disks.  So if subsequent accesses were within two and a half 
seconds and got valid data on the first attempt, they decided it had to be 
the same disk... 

These days with the button it's probably more like a second and a half, but 
the principle's the same.

Also, enough drives do it right (the vast majority), that a 
"broken_disk_change" module/boot option seems more sensible as a non-default 
thing for those that really are hosed...

Rob
