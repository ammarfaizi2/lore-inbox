Return-Path: <linux-kernel-owner+w=401wt.eu-S1751662AbXAVL1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbXAVL1J (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 06:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbXAVL1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 06:27:09 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50138 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751672AbXAVL1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 06:27:08 -0500
Date: Mon, 22 Jan 2007 11:37:58 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Joe Barr <joe@pjprimer.com>
Cc: Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Serial port blues
Message-ID: <20070122113758.4197911c@localhost.localdomain>
In-Reply-To: <1169242654.20402.154.camel@warthawg-desktop>
References: <1169242654.20402.154.camel@warthawg-desktop>
X-Mailer: Claws Mail 2.7.1 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Serial port latency is heavily dependant on the HZ rate for data bits
and input side stuff and you can set the low latency flag to improve upon
that. Beyond that if you are using the modem control ioctls then it
depends a lot on the hardware. USB has some implicit queuing on the bus
but generic uarts have very little on the whole.

You should be able to get much better results by using
mlockall(MCL_FUTURE) on the actual test process and setting the priority
into the real time range, in combination with turning on low latency on
the motherboard ports. 

The current -mm kernels also support arbitary baud rate (well 45 or 50
rather than 45.5), although this hasn't yet been enabled for all
platforms or pushed into the base kernel for i386 yet. It will be soon
however and then glibc can be tweaked to use it by default.

Alan
