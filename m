Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVCaLbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVCaLbs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVCaLbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:31:48 -0500
Received: from mx1.elte.hu ([157.181.1.137]:54707 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261351AbVCaLah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:30:37 -0500
Date: Thu, 31 Mar 2005 13:30:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: kus Kusche Klaus <kus@keba.com>
Cc: stern@rowland.harvard.edu, linux-usb-users@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11, USB: High latency?
Message-ID: <20050331113024.GA27731@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F3673231C5@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AAD6DA242BC63C488511C611BD51F3673231C5@MAILIT.keba.co.at>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* kus Kusche Klaus <kus@keba.com> wrote:

> I'm performing realtime latency tests (for details about the hardware 
> and software, see my mail "[BUG] 2.6.11: Random SCSI/USB errors when 
> reading from USB memory stick" erlier today).
> 
> Even when the errors described in my previous mail does not occur, 
> massive USB stick transfers cause latencies of 1 to 2 milliseconds, 
> which is way too much for realtime control systems.

do these occur under PREEMPT_RT? If yes, do you get any useful trace if 
you enable all the tracing options but keep wakeup-timing off:

 # CONFIG_WAKEUP_TIMING is not set
 CONFIG_PREEMPT_TRACE=y
 CONFIG_CRITICAL_PREEMPT_TIMING=y
 CONFIG_CRITICAL_IRQSOFF_TIMING=y
 CONFIG_CRITICAL_TIMING=y
 CONFIG_LATENCY_TIMING=y
 CONFIG_LATENCY_TRACE=y
 CONFIG_MCOUNT=y

this should catch any type of preempt-off section, irqs-off and 
preempt_disable() alike. (unless the tracer has a bug.)

(WAKEUP_TIMING is useful and lightweight but if all other tracing 
features are enabled it's a bit pointless, and a bit less accurate.)

	Ingo
