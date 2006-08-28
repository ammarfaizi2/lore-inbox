Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWH1BT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWH1BT7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 21:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWH1BT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 21:19:59 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:24736 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932310AbWH1BT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 21:19:58 -0400
Message-ID: <44F244B7.1070408@garzik.org>
Date: Sun, 27 Aug 2006 21:19:51 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc4 1/5] ieee1394: sbp2: workaround for write protect
 bit of Initio firmware
References: <tkrat.bbaf8d081f6a31b7@s5r6.in-berlin.de> <tkrat.94cecc462a778dde@s5r6.in-berlin.de> <Pine.LNX.4.64.0608271308360.27779@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608271308360.27779@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> I don't think there really is _ever_ any reason to use the 10-byte version 
> if the 6-byte version is expected to work. Is there?

Yes, but not really important:  10-byte allows a 16-bit allocation 
length (additional data section), where 6-byte only allows 8-bit.

However, the mode pages the kernel requests from the device are normally 
<= 256 bytes.

In general, your intuition is correct.  use_10_for_foo is largely meant 
for the subclass of "SCSI" devices which often don't bother to implement 
the 6-byte commands, forcing the software driver to emulate 6-byte. 
use_10_for_foo allows the software driver to eliminate that in-kernel 
emulation code.

	Jeff


