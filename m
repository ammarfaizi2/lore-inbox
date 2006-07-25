Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWGYUHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWGYUHW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWGYUHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:07:21 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:55263 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964846AbWGYUHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:07:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17606.31023.273943.551848@cargo.ozlabs.ibm.com>
Date: Wed, 26 Jul 2006 06:03:59 +1000
From: Paul Mackerras <paulus@samba.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Neil Horman <nhorman@tuxdriver.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
In-Reply-To: <44C66C91.8090700@zytor.com>
References: <20060725174100.GA4608@hmsreliant.homelinux.net>
	<03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org>
	<20060725182833.GE4608@hmsreliant.homelinux.net>
	<44C66C91.8090700@zytor.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:

> Not really.  This introduces a potentially very difficult support 
> user-visible interface.  Consider a tickless kernel -- you might end up 
> taking tick interrupts ONLY to update this page, since you don't have 
> any way of knowing when userspace wants to look at it.

It's not that bad; if userspace is running, the cpu isn't idle, so
there isn't the motivation to go tickless on that cpu.  In other
words, if every cpu has suspended ticks, then no cpu can be running
stuff that needs to look at this page.

Paul.
