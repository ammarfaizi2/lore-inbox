Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269967AbUJHNgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269967AbUJHNgz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 09:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269973AbUJHNgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 09:36:54 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:56898 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S269967AbUJHNfO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 09:35:14 -0400
Subject: Re: [RFC][PATCH] TTY flip buffer SMP changes
From: Paul Fulghum <paulkf@microgate.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041008062650.GC2745@thunk.org>
References: <1097179099.1519.17.camel@deimos.microgate.com>
	 <1097177830.31768.129.camel@localhost.localdomain>
	 <20041008062650.GC2745@thunk.org>
Content-Type: text/plain
Message-Id: <1097242506.2008.30.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Oct 2004 08:35:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 01:26, Theodore Ts'o wrote:
> Even if kmalloc() isn't as fast using two ring buffers which we flip
> back and forth, CPU's have gotten a lot faster since when I
> implemented the flip buffers some 12 years ago (i.e., 8 Moore law's
> doublings ago).

The sk_buff solution does look attractive,
particularly for high data rates.

It does seem to carry serious overhead (in relation
to ring buffers) for devices with small FIFOs.

At 115200bps, I saw the 16550 driver accumulate
~8 bytes per interrupt. Using 2 sk_buffs per interrupt
means 256 sk_buff allocations to push 1KiB (71ms) of data
to the line discipline. This amounts to ~3600 sk_buff
allocations per second at 115200bps.

-- 
Paul Fulghum
paulkf@microgate.com

