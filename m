Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbUKAHPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUKAHPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 02:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbUKAHPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 02:15:24 -0500
Received: from inetc.connecttech.com ([64.7.140.42]:2316 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id S261396AbUKAHPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 02:15:17 -0500
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Paul Fulghum'" <paulkf@microgate.com>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'Russell King'" <rmk+lkml@arm.linux.org.uk>, <Tim_T_Murphy@Dell.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UPkernel
Date: Mon, 1 Nov 2004 02:14:35 -0500
Organization: Connect Tech Inc.
Message-ID: <000201c4bfe2$7389eeb0$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <1099182383.6000.99.camel@at2.pipehead.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Fulghum
> I don't see how having flush_to_ldisc() queued
> or already running (on another processor) negates
> the prohibition on calling tty_flip_buffer_push()
> with low_latency set in interrupt context.

I always thought the whole point of low_latency was to make the
receive-path very fast, which means specifically allowing the flip
routine to run from the ISR. So checking for calling from the ISR and
specifically disallowing that is basically negating the entire raison
d'etre for low_latency.

Having said that, the interrupt context "taint" that is allowed by the
low_latency flag has been a thorn in our side for some time. It would
be nice if that path was cleaned up to run properly from interrupt or
process context.

..Stu
www.connecttech.com

