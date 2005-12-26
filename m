Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVLZSrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVLZSrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 13:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbVLZSrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 13:47:12 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:491 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S932090AbVLZSrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 13:47:11 -0500
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 No Idle HZ aka dynticks 051221
In-Reply-To: <20051226025525.GA6697@thunk.org>
References: <200512210310.51084.kernel@kolivas.org> <20051225171617.GA6929@thunk.org> <20051225171617.GA6929@thunk.org> <20051226025525.GA6697@thunk.org>
Date: Mon, 26 Dec 2005 18:47:10 +0000
Message-Id: <E1EqxNG-0003Ze-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> wrote:

> With dyntick enabled, the laptop never enters the C4 state, but
> instead bounces back and forth between C2 and C3 (and I notice that we
> never enter C1 state, even when the CPU is completely pegged, but
> that's true with or without dyntick).  

C1 is a power-saving mode - if your CPU is pegged, you won't be in any
C state (the acpi code seems to make this confusing by showing you the
last mode you were in - however, the usage count won't change). If the
C2 latency isn't significantly larger than the C1 latency, I don't think
there's ever any reason to want to use C1.

To further confuse things, the ipw2100 driver will silently disable
anything higher than C2 if it ever receives a corrupt packet. I'm not
convinced this is a good thing.
-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
