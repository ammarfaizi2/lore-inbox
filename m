Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130216AbQK2TDx>; Wed, 29 Nov 2000 14:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131231AbQK2TDm>; Wed, 29 Nov 2000 14:03:42 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:46857 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S130216AbQK2TD1>; Wed, 29 Nov 2000 14:03:27 -0500
Date: Wed, 29 Nov 2000 12:28:32 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "Joseph K. Malek" <malekjo@aphrodite.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Broken NTFS
Message-ID: <20001129122832.A8639@vger.timpanogas.org>
In-Reply-To: <Pine.LNX.3.95.1001129091726.14820A-100000@chaos.analogic.com> <Pine.LNX.4.21.0011290628350.2047-100000@fluffy.aphrodite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0011290628350.2047-100000@fluffy.aphrodite.com>; from malekjo@aphrodite.com on Wed, Nov 29, 2000 at 06:33:36AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2000 at 06:33:36AM -0800, Joseph K. Malek wrote:
> Hi all,
> 
> I have a broken NTFS, due to my own mistake of mounting the
> partition RW and moving a file instead of copying it....I've been poking
> around for an NTFS editing tool; only to find that this is easier said
> than done.  Does anyone have an NTFS repair tool for winnt 4 (I already
> have the ddk), or any idea where I can find one?
> 

I have a tool that will repair the damage caused to an NTFS volume by 
Linux.  Questions:

1.  Did you boot NT on the drive and did it become RAW?
2.  Have you run checkdisk against the drive, and if so, what happened?

If you answer yes to #1, you have probably already experienced permanent
data loss on the device.  Older NTFS versions on Linux would make changes
to the MFT without clearing the old journal file, then leave the drive
marked as "clean" to NT.  What can happen in this case is that NTFS 
on W2K will see the logfile, then attempt to roll out the changes.  In NT
the MFT is updated real time and the logfile is transacted after the fact.
This can (but not always) cause massive data loss on NTFS drives.  Anton
has fixed a lot of these issues on the newer code, but Linux NTFS
is still a very dangerous piece of software to use R/W (R/O works 
OK).

Do you need this tool?


Jeff

> thanks in advance!
> 
> -- 
> 
> .oO0Oo.|.oO0Oo.|.oO0Oo.|.oO0Oo.|.oO0Oo.|.oO0Oo.
> This message was made from 100% post-consumer
> recycled magnetic domains. No binary trees were
> destroyed to make it.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
