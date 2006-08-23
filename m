Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965304AbWHWXWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965304AbWHWXWn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 19:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965305AbWHWXWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 19:22:43 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:23205 "EHLO
	mail.arcor.de") by vger.kernel.org with ESMTP id S965304AbWHWXWm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 19:22:42 -0400
Date: Thu, 24 Aug 2006 01:22:37 +0200
From: Baurzhan Ismagulov <ibr@radix50.net>
To: linux-kernel@vger.kernel.org
Cc: msushchi@thermawave.com
Subject: Re: Help: error 514 in select()
Message-ID: <20060823232237.GI23435@radix50.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, msushchi@thermawave.com
References: <s4ea002d.084@smtp.thermawave.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s4ea002d.084@smtp.thermawave.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Misha,

On Mon, Aug 21, 2006 at 06:49:03PM -0700, Misha Sushchik wrote:
> 1) I do not know when this problem first appeared (or, re-appeared, as
> I can see from searching the web). If we knew the latest version where
> this problem was not, we would consider just going back to that
> version, instead of waiting for the bug to be fixed.

It would be fairly easy to find out once you have (2) solved.


> 2) I do not have a sensible way of reproducing this error in a short
> time. It may take a few days of running our application in order for
> it to fail in this way. This is killing us (timewise) in testing
> possible solutions.

I would start with the following:

1. Do you know all signals sent to the process in question by itself or
   by other processes? Can you log them?

2. Have you tried the patch from my last mail?

This may help to understand how the problem can be reproduced. My
current assumption is, your process calls select(2), a signal arrives,
ERESTARTNOHAND is not replaced with EINTR and the former is leaked to
the user space; you have to find out where the return value should be
replaced, and make it happen. If there are many ERESTARTNOHANDs during
the normal operation, printing the stack just before returning to user
space could help further.


> The latest kernel we had this reproduced with was 2.6.17.

Good to know! I assume you haven't tried 2.6.17.10, right? Although,
after a quick skimming through the changes since 2.6.17, I haven't seen
anything that could be relevant.


With kind regards,
Baurzhan.
