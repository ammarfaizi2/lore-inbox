Return-Path: <linux-kernel-owner+w=401wt.eu-S932239AbXADCrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbXADCrV (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 21:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbXADCrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 21:47:21 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53620
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932239AbXADCrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 21:47:21 -0500
Date: Wed, 03 Jan 2007 18:47:20 -0800 (PST)
Message-Id: <20070103.184720.122834327.davem@davemloft.net>
To: amit2030@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc2] [BUGFIX] drivers/atm/firestream.c: Fix
 infinite recursion when alignment passed is 0.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061230182603.d3815dcb.amit2030@gmail.com>
References: <20061230182603.d3815dcb.amit2030@gmail.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Choudhary <amit2030@gmail.com>
Date: Sat, 30 Dec 2006 18:26:03 -0800

> Description: Fix infinite recursion when alignment passed is 0 in function aligned_kmalloc(), in file drivers/atm/firestream.c. Also, a negative value for alignment does not make sense. Check for negative value too.
> The function prototype is:
> 		static void __devinit *aligned_kmalloc (int size, gfp_t flags, int alignment).
> 
> 
> Signed-off-by: Amit Choudhary <amit2030@gmail.com>

There is only one call to aligned_kmalloc() and it passes in
0x10 as the alignment argument.  Therefore all of this checking
is completely pointless.
