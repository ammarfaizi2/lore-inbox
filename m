Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280975AbRLWLxm>; Sun, 23 Dec 2001 06:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280838AbRLWLxb>; Sun, 23 Dec 2001 06:53:31 -0500
Received: from oe15.law9.hotmail.com ([64.4.8.119]:3340 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S286874AbRLWLxX>;
	Sun, 23 Dec 2001 06:53:23 -0500
X-Originating-IP: [66.108.21.174]
From: "T. A." <tkhoadfdsaf@hotmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <Pine.GSO.4.21.0112222109050.21702-100000@weyl.math.psu.edu> <3C25A06D.7030408@zytor.com>
Subject: Re: tar vs cpio (was: Booting a modular kernel through a multiple streams file)
Date: Sat, 22 Dec 2001 14:53:09 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE15yZcIaeZ2FTVPuxT00007b64@hotmail.com>
X-OriginalArrivalTime: 23 Dec 2001 11:53:17.0361 (UTC) FILETIME=[68E3CA10:01C18BA8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    What about considering one of the simpler filesystems or archive formats
instead?  How much "Unix"-ism is required to be retained in the archive?
(permissions, device files, etc?)

    As for the bigendianness... Is it really relevant since each kernel is
tied to its own platform?  And if it is may it be better to use the native
format of the 98% or so of the Linux machines out there which are
littleendian (performance and ease of general access on the majority of host
machines comes to mind).

----- Original Message -----
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Alexander Viro" <viro@math.psu.edu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, December 23, 2001 4:14 AM
Subject: Re: tar vs cpio (was: Booting a modular kernel through a multiple
streams file)


> I have looked through the various forms of tar and cpio, and I'm getting
> the feeling that both are ugly as hell for the purpose of initializing
> initramfs.  The block-based setup of tar (and of the new Austin group
> "pax" format -- really just a new rev of tar) is awful, but some of the
> tape-oriented aspects of cpio isn't much better.  What concerns me about
> cpio in particular:
> It seems to me that this application doesn't really have a particular
> need for backward compatibility, nor for the I/O blocking stuff of
> tar/cpio.  I would certainly be willing to write a set of portable
> utilities to create an archive in a custom format, if that would be more
> desirable.  We'd still use gzip for compression, of course, and have the
> buffer composed as a combination of ".rfs" and ".rfs.gz" files,
> separated by zero-padding.
>
> What I'm talking about would probably still look a lot like the cpio
> header, but probably would use bigendian binary (bigendian because it
> allows the use of the widely portable htons() and htonl() macros), have
> explicit support for hard links, and not require a trailer block.
>
> -hpa
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
