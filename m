Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130142AbQK0Vc1>; Mon, 27 Nov 2000 16:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129639AbQK0VcR>; Mon, 27 Nov 2000 16:32:17 -0500
Received: from mail1.rdc3.on.home.com ([24.2.9.40]:8680 "EHLO
        mail1.rdc3.on.home.com") by vger.kernel.org with ESMTP
        id <S129927AbQK0Vb6>; Mon, 27 Nov 2000 16:31:58 -0500
Message-ID: <001001c058b5$405f82e0$6400a8c0@wlfdle1.on.wave.home.com>
From: "John Zielinski" <grimr@home.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0011271530120.7352-100000@weyl.math.psu.edu>
Subject: Re: Anyone else kernel mounting a filesystem that has a block device?
Date: Mon, 27 Nov 2000 16:01:44 -0500
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 27 Nov 2000, John Zielinski wrote:
>
> > I'm going to be mounting a filesystem that uses a block device from
inside
> > the kernel.  This mount will not be visible from userland nor can it be
> > unmounted from userland.  Is anyone else doing something like this so we
can
> > coordinate on the changes needed to fs/super.c?
>
> No changes needed. Check kern_mount().

Oops.  Should have said 'physical' block device.  The kern_mount() function
calls get_unnamed_dev().  I want to modify it so that it also takes an 'char
* dev_name' and does the same thing as the code in do_mount() which picks
which get_sb_???() functions to call.

I'll just make a kern_mount2() until all the other code that calls
kern_mount is changed so that it passes a "none" or something as the second
parameter.

John


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
