Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317005AbSGNTJH>; Sun, 14 Jul 2002 15:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317006AbSGNTJH>; Sun, 14 Jul 2002 15:09:07 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:1764 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S317005AbSGNTJG>; Sun, 14 Jul 2002 15:09:06 -0400
Date: Sun, 14 Jul 2002 21:10:24 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207141910.g6EJAOrC019354@burner.fokus.gmd.de>
To: alan@lxorguk.ukuu.org.uk, schilling@fokus.gmd.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From alan@lxorguk.ukuu.org.uk Sun Jul 14 17:35:44 2002


>Try doing the following in SCSI

>-	Device managed storage layout  "Allocate x blocks close to 	handle y
>and give me a new handle"

You don't want do do this in SCSI because it is a task of a layer above SCSI.


>-	Per I/O request readahead hints (please read on xyzK , please 	dont
>readahead)

Again:	this is a task of a layer above SCSI.
	In some cases, where you might refer to medium access level read ahead,
	this is done by implementing tagged SCSI command queueing.

>-	Per I/O request writeback hints (write back cache is ok, write 	back
>cache is ok only if NV, don't bother caching, streaming I/O
>	hint)

Again: this is a task of a layer above SCSI. See Solaris and FreeBSD as 
examples.

It would help if you first do some homework and read some decent kernel 
sources to understand how a kernel needs to be layered to implement
e.g. Storage/FS/kernel/user interface layering.

Then use e.g. 'iostat' to see how overlapping disk I/O is done.

>I have controllers which can do most of the above. I don't want to talk
>scsi to them and spend all my cpu time faking, decoding and recoding
>command blocks, spoofing error handling and the like.

>Its simply inappropriate to consider the SCSI command set as a high
>level interface for block and related I/O. 

It looks like you never did metering tests to see what amount of time
is needed to handle the SCSI protocol.

I did many tests when implementing RSCSI. Even when you include TCP/IP
times, the overhead is <= 100 µs per SCSI command.


>As to your comments on sg. Everyone except you happened to think that
>Doug Gilberts very nice sg changes were the right path. I still think it
>was the right decision. 

Not knowing what is bad may make people believe that something is good.

>> If this discussion stays as it currently looks like, it does not make 
>> sense for me to try to find a better solution. Let me call it this
>> way: this thread was just another proof that it is not possible to
>> have a technical based solution with the Linux folks. It seems t be >
>> just a waste of time :-(

>The Linux development process aggressively filters bad ideas.

It definitely did not help 4 years ago, when the sg problem did came up.


Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
