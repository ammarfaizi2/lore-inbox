Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319060AbSH2AQa>; Wed, 28 Aug 2002 20:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319061AbSH2AQa>; Wed, 28 Aug 2002 20:16:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12042 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319060AbSH2AQ2>; Wed, 28 Aug 2002 20:16:28 -0400
Date: Thu, 29 Aug 2002 01:20:48 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@zip.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] mysterious tty deadlock
Message-ID: <20020829012048.B28773@flint.arm.linux.org.uk>
References: <20020828220114.GA878@holomorphy.com> <3D6D4DD0.1900B894@zip.com.au> <20020829002103.B28455@flint.arm.linux.org.uk> <3D6D6558.B2CE77B6@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D6D6558.B2CE77B6@zip.com.au>; from akpm@zip.com.au on Wed, Aug 28, 2002 at 05:05:44PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 05:05:44PM -0700, Andrew Morton wrote:
> Well Bill's trace is claiming that we're doing a schedule_timeout(0x7fffffff)
> for some reason.

Umm, I didn't see that:

wli> #0  schedule_timeout (timeout=-150765944) at timer.c:864
wli> #1  0xc01a28a3 in uart_wait_until_sent (tty=0xf7669000, timeout=2147483647)
wli>     at core.c:1320

Its legal for uart_wait_until_sent to be called with 2147483647 (it means
"wait until all characters are sent no matter what").  However, we'll
still call schedule_timeout with a really small value (one character
time) which means we'll be waking up pretty regularly there.

> But yes, he seems to be able to hit it too frequently for this to be
> the cause.

wli - please let me know if Andrew's patch makes any difference for you.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

