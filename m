Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbUJXS7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbUJXS7U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 14:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbUJXS7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 14:59:20 -0400
Received: from bender.bawue.de ([193.7.176.20]:38312 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S261584AbUJXS7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 14:59:16 -0400
Date: Sun, 24 Oct 2004 20:59:10 +0200
From: Joerg Sommrey <jo@sommrey.de>
To: Christian Borntraeger <linux-kernel@borntraeger.net>,
       Jan Knutar <jk-lkml@sci.fi>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Bug? Load avg 2.0 when idle.
Message-ID: <20041024185910.GA13582@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Christian Borntraeger <linux-kernel@borntraeger.net>,
	Jan Knutar <jk-lkml@sci.fi>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20041024182918.GA12532@sommrey.de> <200410242143.51025.jk-lkml@sci.fi> <20041024182918.GA12532@sommrey.de> <200410242045.04901.linux-kernel@borntraeger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410242143.51025.jk-lkml@sci.fi> <200410242045.04901.linux-kernel@borntraeger.net>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 08:45:04PM +0200, Christian Borntraeger wrote:
> Joerg Sommrey wrote:
> > there is a load average of 2.0+ even if the box is almost idle. (i.e.
> > "top" shows just one running process: top itself.) Starting two
> > cpu-intensive processes raises the load average to 4.0+.  How can I
> > determine the source for the high load, or is this a bug?
> > I'm running 2.6.9 on a dual-athlon box.
> 
> Besides other possibilities, a bug in the kernel could be the cause. 
> Please check if any process (one or two) is in uninterruptible sleep. 
> (using ps axl the state is D)

On Sun, Oct 24, 2004 at 09:43:42PM +0300, Jan Knutar wrote:
> 
> Look for processes stuck in D state...

Thanks,
there was something hanging in D state.  Strange enough: it was waiting
for modules to be loaded.  After killing a hanging "modprobe" (S state),
the D state processes vanished and load avg returned to normal values.

-jo

-- 
-rw-r--r--  1 jo users 63 2004-10-24 19:38 /home/jo/.signature
