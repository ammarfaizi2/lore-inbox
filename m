Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265387AbTF1UT4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 16:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265392AbTF1UT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 16:19:56 -0400
Received: from [163.118.102.59] ([163.118.102.59]:53632 "EHLO
	mail.drunkencodepoets.com") by vger.kernel.org with ESMTP
	id S265387AbTF1UTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 16:19:55 -0400
Date: Sat, 28 Jun 2003 16:26:56 -0400
From: pat erley <paterley@drunkencodepoets.com>
To: linux-kernel@vger.kernel.org
Cc: Con Kolivas <kernel@kolivas.org>
Subject: Re: patch-O1int-0306281420 for 2.5.73 interactivity
Message-Id: <20030628162656.06e7e046.paterley@drunkencodepoets.com>
In-Reply-To: <200306281516.12975.kernel@kolivas.org>
References: <200306281516.12975.kernel@kolivas.org>
Organization: drunkencodepoets.com
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made a small error when I sent Con a piece of magic I wrote up to help the sleep period.  

what it says right now:

/kernel/sched.c around line 325


sleep_period = (sleep_period *
	17 * sleep_period / ((17 * sleep_period / (5 * tau) + 2) * 5 * tau));
----------------------------------------------------------^

it should be:

sleep_period = (sleep_period *
	17 * sleep_period / ((17 * sleep_period / (5 * tau + 2)) * 5 * tau));
--------------------------------------------------------------^

stupid parenthesis.

a little background.  what this essentially is is a taylor approximation of the function ln(66x+1) normalized.  ln(66x+1) happens to do a great job oas a weighting function on the range of 0 to 1, and because the input only happens to range from 0 to 1, only 2 terms were needed to do a 'good enough' job.

Pat
-- 
