Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263333AbTDULLA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 07:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263474AbTDULLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 07:11:00 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:30983 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S263333AbTDULK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 07:10:59 -0400
Message-Id: <200304211113.h3LBDuu08057@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: John Bradford <john@grabjohn.com>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Date: Mon, 21 Apr 2003 14:22:01 +0300
X-Mailer: KMail [version 1.3.2]
Cc: john@grabjohn.com (John Bradford),
       skraw@ithnet.com (Stephan von Krawczynski),
       linux-kernel@vger.kernel.org
References: <200304210935.h3L9ZLXc000256@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200304210935.h3L9ZLXc000256@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 April 2003 12:35, John Bradford wrote:
> > > Modern disks generally do this kind of thing themselves.  By the
> > > time
> >
> >                ^^^^^^^^^^^^
> > How many times does Stephan need to say it? 'Generally do'
> > is not enough, because it means 'sometimes they dont'.
>
> OK, _ALL_ modern disks do.
>
> Name an IDE or SCSI disk on sale today that doesn't retry on write
> failiure.  Forget I said 'Generally do'.

I don't know about drives currently on sale, but I think
it is possible that some Flash or DRAM-based IDE pseudo-disks
do not have extensive sector remapping features. They can just
do ECC thing and error out.

Also if disk just runs out of spare sectors, it has no other
option other than just report failure, right? (Oh,
of course it can decide to execute 'my firmware is buggy'
option instead ;)

But.

The disk, which I hold in my hand *right now*, namely:
	WD Caviar 21200
MDL: WDAC21200-00H
P/N: 99-004211-000
CCC: E3 2 APR 97 S
DCM: AFAAYAW
WD S/N: WT342 251 1943

does have some bad sectors and otherwise performs satisfactorily.
It's my 'big diskette'. So, if I decide to write some MP3s
on it and carry 'em home, and it will suddenly struck a new bad
sector...

Why in hell should I see my fs remounted RO?
Why do I have to read entire disk to my main disk,
recreate the fs with new badblock map, write back everything,
and retry writing MP3???

I prefer a big fat ugly kernel printk (KERN_ERR) across my console
and all the logs: "ext3fs: write error at sector #NNNN. Marking as bad.
Your disk may be failing!"

What's wrong with me?
--
vda
