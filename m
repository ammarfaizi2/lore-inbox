Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbTGVBVp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 21:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270775AbTGVBVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 21:21:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:50376 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267186AbTGVBVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 21:21:07 -0400
Date: Mon, 21 Jul 2003 18:33:38 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Matthew Harrell 
	<mharrell-dated-1059268898.4dcd80@bittwiddlers.com>
Cc: lists-sender-14a37a@bittwiddlers.com, linux-kernel@vger.kernel.org
Subject: Re: hid: ctrl urb status -75?
Message-Id: <20030721183338.44634e51.rddunlap@osdl.org>
In-Reply-To: <20030722012137.GA7159@bittwiddlers.com>
References: <20030722012137.GA7159@bittwiddlers.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jul 2003 21:21:37 -0400 Matthew Harrell <lists-sender-14a37a@bittwiddlers.com> wrote:

| 
| What does this error mean?  I'm attempting to plug in a USB keyboard I've got
| and it gives me the messages
| 
|   hub 1-0:0: new USB device on port 1, assigned address 3
|   input: USB HID v1.10 Keyboard [CHESEN USB Keyboard] on usb-0000:00:11.2-1
|   drivers/usb/input/hid-core.c: ctrl urb status -75 received
| 
| Other USB keyboards work fine so it must be something special with this one.
| This is under all kernels from 2.5.60 to 2.6.0-test1

include/asm-generic/errno.h says that 75 is EOVERFLOW.
Now look in Documentation/usb/error-codes.txt and it says that
EOVERFLOW is used for:
-EOVERFLOW (*)		The amount of data returned by the endpoint was
			greater than either the max packet size of the
			endpoint or the remaining buffer size.  "Babble".

The device returned too much data.
See whichever host controller driver you are using for details.

--
~Randy
