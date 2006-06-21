Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWFUKJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWFUKJx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 06:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWFUKJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 06:09:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:31924 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751467AbWFUKJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 06:09:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bhHJ3fO7Ea+uVssTjSt619bW9XH50TcBpAKRb7nfgaO2oajnJA+W5Me626UoJp36kYlpGCkkoA2PLTg/UM46heoITtW2ToakBlMjO8RrtvxlndjapRHckUP3U1flkTxUxZc/UYMpezXHc2wBaFZH9v7qVaT9Ew4CBcsEeMdOttU=
Message-ID: <44991AFA.9050600@gmail.com>
Date: Wed, 21 Jun 2006 12:10:02 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: John Rigg <lk@sound-man.co.uk>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rt1 unknown symbol monotonic_clock
References: <20060621100623.GA2960@localhost.localdomain>
In-Reply-To: <20060621100623.GA2960@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

John Rigg napisał(a):
> Just compiled 2.6.17-rt1 on x86_64 UP system and got the following
> message when doing `make modules_install':
> WARNING: /lib/modules/2.6.17-rt1/kernel/drivers/char/hangcheck-timer.ko \
> needs unknown symbol monotonic_clock

Please try this patch

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/char/hangcheck-timer.c linux-work/drivers/char/hangcheck-timer.c
--- linux-work-clean/drivers/char/hangcheck-timer.c	2006-06-19 21:04:36.000000000 +0200
+++ linux-work/drivers/char/hangcheck-timer.c	2006-06-19 21:08:49.000000000 +0200
@@ -133,6 +133,8 @@ static inline unsigned long long monoton
 {
 	return get_cycles();
 }
+
+EXPORT_SYMBOL(monotonic_clock);
 #endif  /* HAVE_MONOTONIC */

> 
> John

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
