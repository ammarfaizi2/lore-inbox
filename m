Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266042AbTFWOAJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 10:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266047AbTFWOAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 10:00:08 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:33677 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S266042AbTFWOAA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 10:00:00 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.72-mm3 O(1) interactivity enhancements
Date: Tue, 24 Jun 2003 00:15:23 +1000
User-Agent: KMail/1.5.2
References: <1056368505.746.4.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1056368505.746.4.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306240015.23613.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jun 2003 21:41, Felipe Alfaro Solana wrote:
> Hi!
>
> I have just cooked up a patch which mixes Mike Galbraith's excellent
> monotonic clock O(1) scheduler changes with another patch I think that
> came from Ingo Molnar and some scheduler parameter tweaks. This patch is
> against 2.5.72-mm3, but applies cleanly on top of 2.5.73.
>
> For me, it gives impressive interactive behavior. With it applied, I can
> no longer make XMMS skips sound, moving windows on an X session is
> perfectly smooth, even when moving them fastly enough for a very long
> time.

Hi Felipe.

For those who aren't familiar, you've utilised the secret desktop weapon:

+		if (!(p->time_slice % MIN_TIMESLICE) &&

This is not how Ingo intended it. This is my desktop bastardising of the 
patch. It was originally about 50ms (timeslice granularity). This changes it 
to 10ms which means all running tasks round robin every 10ms - this is what I 
use in -ck and is great for a desktop but most probably of detriment 
elsewhere. Having said that, it does nice things to desktops :-)

Con

