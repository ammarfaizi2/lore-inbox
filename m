Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264785AbSKEKdM>; Tue, 5 Nov 2002 05:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264789AbSKEKdM>; Tue, 5 Nov 2002 05:33:12 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:45460 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264785AbSKEKdL>; Tue, 5 Nov 2002 05:33:11 -0500
Subject: Re: Patch-2.5.45-ac1  inia100 compile and run problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John W Fort <johnf@whitsunday.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <etkesucpk7plmukbdvmsa4gbs2f4rng1oa@4ax.com>
References: <etkesucpk7plmukbdvmsa4gbs2f4rng1oa@4ax.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 11:01:51 +0000
Message-Id: <1036494111.4791.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 05:16, John W Fort wrote:
> Trivial bits from 2.5.45-ac1 compile:
> drivers/scsi/inia100.h:78: warning: `inia100_detect' declared `static' but never defined
> drivers/scsi/inia100.h:79: warning: `inia100_release' declared `static' but never defined
> drivers/scsi/inia100.h:80: warning: `inia100_queue' declared `static' but never defined
> drivers/scsi/inia100.h:81: warning: `inia100_abort' declared `static' but never defined
> drivers/scsi/inia100.h:82: warning: `inia100_device_reset' declared `static' but never defined
> drivers/scsi/inia100.h:83: warning: `inia100_bus_reset' declared `static' but never defined
> 

These should be little things because of the way the include is used

> Incorrect number of segments after building list
> counted 17, received 16
> req nr_sec 256, cur_nr_sec 8
> end request: I/O error, dev 08:10 sector 6685776
> 
> and then hangs the bus.
> Would it be because there is no 'eh_host_reset_handler'?

No thats because something much nastier has occurred - you've got some
kind of block/scsi layer structure corruption. Most probably there is a
path where we called ->done(cmd) without holding the host lock

> The first run both drives reported similar I/O errors.
> Works fine with 'patch-2.5.45' from Linus.
> How can I help?

I'll go and review the changes. It looks like a locking error.

