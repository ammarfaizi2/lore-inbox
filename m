Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTD2Ffw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 01:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTD2Ffw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 01:35:52 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:26890 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S261956AbTD2Ffv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 01:35:51 -0400
Message-Id: <200304290538.h3T5cLu16097@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: James@superbug.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Bug in linux kernel when playing DVDs.
Date: Tue, 29 Apr 2003 08:46:00 +0300
X-Mailer: KMail [version 1.3.2]
References: <3EABB532.5000101@superbug.demon.co.uk>
In-Reply-To: <3EABB532.5000101@superbug.demon.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 April 2003 13:47, James Courtier-Dutton wrote:
> Hello,
>
> I have found a bug in the linux kernel when it plays DVDs. I use xine
> (xine.sf.net) for playing DVDs.
> At some point during the playing there is an error on the DVD. But
> currently this error is not handled correctly by the linux kernel.
> This puts the kernel into an uncertain state, causing the kernel to
> take 100% CPU and fail all future read requests.
...
> Apr 26 17:16:24 games kernel: hdd: cdrom_decode_status: error=0x34
> Apr 26 17:16:24 games kernel: hdd: ATAPI reset complete
> Apr 26 17:16:25 games kernel: end_request: I/O error, dev 16:40
> (hdd), sector 7750464
...
> DriveReady SeekComplete Error }
> Apr 26 17:16:59 games kernel: hdd: cdrom_decode_status: error=0x34
> Apr 26 17:16:59 games kernel: hdd: ATAPI reset complete
> Apr 26 17:16:59 games kernel: end_request: I/O error, dev 16:40
> (hdd), sector 7750468

See? Sector # is increasing... Linux retries the read several times,
then reports EIO to userspace and goes to next sectors. Unfortunately,
they are bad too, so the loop repeats. Eventually it will pass
by all bad sectors (if not, it's a bug) but it can take longish
time.

Apart of making max retry # settable by the user, I don't see how
this can be made better. Pity. This is common problem on CDs...
--
vda
