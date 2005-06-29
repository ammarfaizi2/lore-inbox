Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbVF2S1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbVF2S1h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbVF2S1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:27:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36234 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262404AbVF2S13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 14:27:29 -0400
Date: Wed, 29 Jun 2005 11:27:25 -0700
From: Chris Wright <chrisw@osdl.org>
To: Gernot Payer <gpayer@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch to disarm timers after an exec syscall
Message-ID: <20050629182725.GF9153@shell0.pdx.osdl.net>
References: <200506291455.45468.gpayer@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506291455.45468.gpayer@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Gernot Payer (gpayer@suse.de) wrote:
> Hi all,
> 
> while running the openposix testsuite I saw testcase timer_create/9-1.c 
> failing. This testcase tests whether timers are disarmed when a process calls 
> exec, as described in e.g. 
> http://www.opengroup.org/onlinepubs/009695399/functions/timer_create.html.

> 
> The attached one-liner patch (+ one line comment) fixes this issue. I did the 
> diff against 2.6.12.1, but the fix is pretty much the same for every other 
> 2.6.x kernel I had a look at.

No, this can't do.  It conflicts with the other bit of requirements.
Specifically:
http://www.opengroup.org/onlinepubs/009695399/functions/exec.html

As you mention:

  [TMR] Per-process timers created by the calling process
  shall be deleted before replacing the current process image with the new
  process image.

But also:

  The new process shall inherit at least the following attributes from the
  calling process image:
  <snip>
  o [XSI] Interval timers

And this kills the latter.

thanks,
-chris
