Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVCaLfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVCaLfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVCaLfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:35:47 -0500
Received: from mx2.elte.hu ([157.181.151.9]:53155 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261360AbVCaLfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:35:37 -0500
Date: Thu, 31 Mar 2005 13:35:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: kus Kusche Klaus <kus@keba.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: 2.6.11, IDE: Strange scheduling behaviour: high-pri RT process not scheduled?
Message-ID: <20050331113526.GB27731@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F3673231C2@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AAD6DA242BC63C488511C611BD51F3673231C2@MAILIT.keba.co.at>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* kus Kusche Klaus <kus@keba.com> wrote:

> I've written a small test program which enables periodic RTC 
> interrupts at 8192 Hz and then goes into a loop reading /dev/rtc and 
> collecting timing statistics (using the rdtscl macro).

getting /dev/rtc handling right for latency measurement is ... tricky.  
The method i'm using under PREEMPT_RT is:

 chrt -f 84 -p `pidof 'IRQ 0'`
 chrt -f 95 -p `pidof 'IRQ 8'`
 ./rtc_wakeup -f 1024 -t 100000

you can get rtc_wakeup from:

 http://www.affenbande.org/~tapas/wiki/index.php?rtc_wakeup

written by Florian Schmidt.

do you see high latencies even with rtc_wakeup?

	Ingo
