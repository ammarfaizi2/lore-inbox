Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143713AbRAHNVV>; Mon, 8 Jan 2001 08:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143716AbRAHNVL>; Mon, 8 Jan 2001 08:21:11 -0500
Received: from laxmls02.socal.rr.com ([24.30.163.11]:32196 "EHLO
	laxmls02.socal.rr.com") by vger.kernel.org with ESMTP
	id <S143713AbRAHNU5>; Mon, 8 Jan 2001 08:20:57 -0500
From: Shane Nay <shane@agendacomputing.com>
Reply-To: shane@agendacomputing.com
Organization: Agenda Computing
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] cramfs is ro only, so honour this in inode->mode
Date: Mon, 8 Jan 2001 12:13:39 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010108141702.I10035@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010108141702.I10035@nightmaster.csn.tu-chemnitz.de>
MIME-Version: 1.0
Message-Id: <0101081213390Z.02165@www.easysolutions.net>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,
> cramfs is a read-only fs. So we should honour that in inode->mode
> to avoid confusion of programs.
>
> My isofs shows this too, so I think I'm right deleting the write
> permissions in the inode. May be we should change it in
> mkcramfs (too).
>
> I don't know what POSIX says about RO fs, but I can't find any
> real sense in having W permissions for an RO fs.

The only sense I can derive from it is the situation that I'm in.  We use 
cramfs partitions for lots of stuff, but one of them is to hold mirrors of 
the "default" configuration of the user-area of our device.  (Flash)  It 
makes it easy to just copy over the base partitions knowing the permisions 
will stick right.

This may not initially seem like such a great thing..., but imagine a base 
distro being distributed as a cramfs file.  Copy the thing over to your HD 
and you're done, otherwise the distro packaging has to keep track of 
permisions for each file, etc.

On the other hand..., maybe I'm being "selfish", and this is the right way to 
go.  You never write to it, so why track the write bits?  (One answer is 
maybe later we can create a writable cramfs, but oh well)  Lord knows I could 
use a few extra bits in the cramfs inode.... (Using sticky bit to denote XIP 
mode binaries right now..., such a hack)

Thanks,
Shane Nay.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
