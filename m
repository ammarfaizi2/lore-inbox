Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030377AbWARQXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbWARQXt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWARQXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:23:48 -0500
Received: from mx.pathscale.com ([64.160.42.68]:4543 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1030377AbWARQXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:23:48 -0500
Subject: Why is wmb() a no-op on x86_64?
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, discuss@x86-64.org, Andi Kleen <ak@suse.de>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 18 Jan 2006 08:23:37 -0800
Message-Id: <1137601417.4757.38.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andi -

I notice that wmb() is a no-op on x86_64 kernels unless
CONFIG_UNORDERED_IO is set.  Is there any particular reason for this?
It's not similarly conditional on other platforms, and as a consequence,
in our driver (which requires a write barrier in some situations for
correctness), I have to add the following piece of ugliness:

#if defined(CONFIG_X86_64) && !defined(CONFIG_UNORDERED_IO)
#define ipath_wmb() asm volatile("sfence" ::: "memory")
#else
#define ipath_wmb() wmb()
#endif

	<b

