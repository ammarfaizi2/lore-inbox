Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVAMVvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVAMVvx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVAMVuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:50:25 -0500
Received: from relay.axxeo.de ([213.239.199.237]:21947 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S261734AbVAMVqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:46:50 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
Date: Thu, 13 Jan 2005 22:46:37 +0100
User-Agent: KMail/1.7.1
Cc: linux@horizon.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050108082535.24141.qmail@science.horizon.com> <Pine.LNX.4.58.0501081018271.2386@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501081018271.2386@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501132246.37289.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus Torvalds wrote:
> None of the pipes would do anything on their own - they aren't "actors".
> They'd be purely buffers. So if you want to have an asynchronous
> long-running "tee()/copy()/peek()", you'd have a thread that does that for
> you.

Hmm, that's a pity, because it makes hardware support more difficult.

I thought you might consider an system call, which "wires up" fds.

Imagine a device fd, which gets lots of measuring data, wired through a 
DSP pipe, spliced to realtime display fd and file storage fd. 

How many buffers do you like to use here? How much unnecessary copies 
are made by the CPU?

Any realtime mass data processing needing hardware support could benefit
from "active" pipes, where either end could be drivers "knowing each other"
and deciding to rather route the IO in hardware, avoiding to go through the
overworked memory bus and CPU.

This kind of "wire me up to my next chip" is needed quite often in the 
embedded world, where power matters and special purpose chips or even 
DSPs rule. Every chipset vendor does its own libraries there for now,
but a more generic approach might be better.

What do you think?

Regards

Ingo Oeser

