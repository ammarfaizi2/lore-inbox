Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbVKGDX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbVKGDX7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVKGDX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:23:59 -0500
Received: from defout.telus.net ([199.185.220.240]:56289 "EHLO
	priv-edtnes46.telusplanet.net") by vger.kernel.org with ESMTP
	id S932421AbVKGDX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:23:58 -0500
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch 1/14] mm: opt rmqueue
Date: Mon, 7 Nov 2005 04:23:44 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <436DBAC3.7090902@yahoo.com.au> <p73br0x3ceq.fsf@verdi.suse.de> <436EA88C.3050104@yahoo.com.au>
In-Reply-To: <436EA88C.3050104@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511070423.45306.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 November 2005 02:06, Nick Piggin wrote:

> Yes, all this turning on and off of interrupts does have a
> significant cost here.

How did you find out? 

>
> With the full patchset applied, most of the hot path statistics
> get put under areas that already require interrupts to be off,
> however there are still a few I didn't get around to doing.
> zone_statistics on CONFIG_NUMA, for example.

These should just be local_t 

>
> I wonder if local_t is still good on architectures like ppc64
> where it still requires an ll/sc sequence?

The current default fallback local_t doesn't require that. It uses
different fields indexed by !!in_interrupt()

-Andi
