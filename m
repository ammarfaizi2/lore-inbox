Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030179AbWECNAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030179AbWECNAP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 09:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbWECNAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 09:00:14 -0400
Received: from main.gmane.org ([80.91.229.2]:32979 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030179AbWECNAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 09:00:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergei Organov <osv@javad.com>
Subject: High baud rates support for Quatech DSP-100.
Followup-To: gmane.linux.serial
Date: Wed, 03 May 2006 16:59:16 +0400
Message-ID: <e3a9g8$idv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 87.236.81.130
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
Cc: linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got a Quatech DSP-100 PCMCIA dual RS232 adapter. After adding the
adapter parameters into the 'multi_id' and 'serial_ids' tables of the
serial_cs.c driver, it is now automatically loaded and supports the card
almost fine. However, the card supports baud rates up to 460800, but
using serial_cs I get rates only up to 115200.

On the other hand, Quatech has GPL Linux driver (serial_qt.c) for this
card that has been made for some early 2.6.x kernel version and doesn't
compile for recent 2.6.16. I've managed to hack it to compile for
2.6.16.8, -- it does support 460800 indeed.

So the question is what to do next. I'd like to either modify serial_cs
to support high baud rates or to somehow get serial_qt to the linux
tree. For me it seems that the former is more appropriate as serial_qt
in fact looks like some earlier serial_cs modified by Quatech. OTOH,
supporting high baud rates seems to be very card-specific[1] and IMHO
doesn't fit well into rather generic serial_cs.

Is it OK to put card-specific code into serial_cs (provided it's invoked
only after manufacturer id is checked)? Should it be Kconfig option? Is
there a better way to go?

[1] It basically involves checking of some card-specific config
register(s), then setting another card-specific register accordingly and
setting of the 'uartclk' field of the 'struct uart_port' to
corresponding value.

-- 
Sergei.

