Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262037AbSI3M3S>; Mon, 30 Sep 2002 08:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbSI3M3S>; Mon, 30 Sep 2002 08:29:18 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:7674 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262037AbSI3M3R>; Mon, 30 Sep 2002 08:29:17 -0400
Subject: Re: 2.4.20-pre7-ac3 IDE taskfile io woes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Cassella <pwc@bigw.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209291934050.3146-100000@manetheren>
References: <Pine.LNX.4.44.0209291934050.3146-100000@manetheren>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Sep 2002 13:41:17 +0100
Message-Id: <1033389677.16337.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-30 at 06:10, Paul Cassella wrote:
> I experienced severe performance disruptions followed by what appeared to
> be a system hang twice.  Before that, I was recieving an "hdd: lost
> interrupt"  message every few hours, and the system felt sluggish.  (The
> ide-scsi device is hdc, not hdd.)  I have not had these problems with a
> kernel compiled without taskfile io.

taskfile I/O write is broken and loses IRQ's. Non taskfile I/O write
should be fine. Thats one of the known problems that needs debugging


> 11:42:29 bug: kernel timer added twice at c01b0107.

Thats always a bug.

> 
> c01b00b8 T ide_set_handler
> c01b0110 t atapi_reset_pollfunc
> 
> 11:45:35 scsi0 channel 0 : resetting for second half of retries.
> 11:45:35 SCSI bus is being reset for host 0 channel 0.
> 11:45:35 hdd: ide_set_handler: handler not null; old=c01b0110, new=c01b1474

We ended up trying to add a handler before we had finished getting rid
of the previous one.


