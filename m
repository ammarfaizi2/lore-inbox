Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWFNWQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWFNWQA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 18:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWFNWQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 18:16:00 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:30189
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932408AbWFNWP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 18:15:59 -0400
Date: Wed, 14 Jun 2006 15:16:17 -0700 (PDT)
Message-Id: <20060614.151617.122788798.davem@davemloft.net>
To: heiko.carstens@de.ibm.com
Cc: jgarzik@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, mingo@elte.hu, fpavlic@de.ibm.com
Subject: Re: [patch] ipv4: fix lock usage in udp_ioctl
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060614194305.GB10391@osiris.ibm.com>
References: <20060614194305.GB10391@osiris.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 14 Jun 2006 21:43:05 +0200

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Fix lock usage in udp_ioctl().
> 
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

More likely the qeth driver shouldn't call into the socket code in
hardware interrupt context.  From your logs that's what it seems is
happening.

The socket receive queue should only be touched in software
interrupt context, never in hardware interrupt context.  That's
why the locking does BH disabling at best.
