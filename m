Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVEBRuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVEBRuB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 13:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVEBRuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 13:50:01 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:2798 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261361AbVEBRsm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 13:48:42 -0400
Subject: Re: IDE problems in 2.6.12-rc1-bk1 onwards (was Re: 2.6.12-rc3-mm1)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bzolnier@gmail.com, Dominik Brodowski <linux@brodo.de>,
       Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org
In-Reply-To: <03be01c54e77$83d86980$0f01a8c0@max>
References: <03be01c54e77$83d86980$0f01a8c0@max>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1115056032.10369.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 02 May 2005 18:47:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-05-01 at 18:59, Richard Purdie wrote:
> Solution: ide_unregister() should return failure and pass responsibility for 
> handling it to ide-cs or it should always succeed. I'd favour the latter as 
> the ide layer should really handle its own cleanup. Maybe a parameter should 
> be added to ide_unregister() to select the behaviour if the drive is busy/in 
> use? If the hardware is gone, we want it to happen regardless for example...

This is what the -ac tree has done for some time. It tried to unregister
and
if that fails will wait and retry. It also sets the I/O operations to a
set of
null operations to ensure that there are no further unneccessary
writes/reads from the empty bus slot.

Alan

