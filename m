Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267489AbSLNBWr>; Fri, 13 Dec 2002 20:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267493AbSLNBWr>; Fri, 13 Dec 2002 20:22:47 -0500
Received: from gum.itee.uq.edu.au ([130.102.66.1]:17549 "EHLO
	gum.itee.uq.edu.au") by vger.kernel.org with ESMTP
	id <S267489AbSLNBWq>; Fri, 13 Dec 2002 20:22:46 -0500
Date: Sat, 14 Dec 2002 11:26:34 +1000 (EST)
From: Chris Pascoe <c.pascoe@itee.uq.edu.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Karina <kgs@acabtu.com.mx>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Trouble with kernel 2.4.18-18.7.x
In-Reply-To: <1039553498.14302.58.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.44.0212141111490.27655-100000@mango.itee.uq.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Checked: This message probably not SPAM
X-Spam-Score: -3.3
X-Spam-Tests: EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,SPAM_PHRASE_01_02,USER_AGENT_PINE
X-Spam-Report: SPAM: -3.30 hits, 8 required;
	SPAM: * -0.8 -- Found a In-Reply-To header
	SPAM: * -0.6 -- Message-Id indicates a non-spam MUA (Pine)
	SPAM: * -1.6 -- BODY: Contains what looks like an email attribution
	SPAM: *  0.5 -- BODY: Spam phrases score is 01 to 02 (low)
	SPAM: * -0.8 -- BODY: Contains what looks like a quoted email text
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Dec 2002, Alan Cox wrote:

> > kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter errno = 2
>
> That one is a bit stranger. I'd have expected it to put the scsi adapter
> in the initrd which apparently it hasnt

Possibly not bugzilla worthy - it's /sbin/modprobe that's ENOENT, not the
scsi adapter module itself.

This message is generated when the initrd loads scsi_mod.o and then
sd_mod.o without loading any hostadapters first.  init_sd does a
scsi_register_module(MODULE_SCSI_DEV, &sd_template) which causes a
request_module("scsi_hostadapter") in scsi_mod.o as the initrd hasn't yet
loaded any hostadapters.  The initrd then proceeds to load some the
hostadapter drivers explicitly via insmod and everything proceeds fine.

Presumably if mkinitrd was reordered to load scsi_mod, first hostadapter,
then sd_mod, etc, the message would go away but as it stands it is purely
cosmetic.

Chris

