Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWBIDJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWBIDJq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 22:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbWBIDJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 22:09:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13512 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964943AbWBIDJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 22:09:45 -0500
Date: Wed, 8 Feb 2006 19:08:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: riel@redhat.com, linux-kernel@vger.kernel.org, dada1@cosmosbay.com,
       torvalds@osdl.org, mingo@elte.hu, ak@muc.de, 76306.1226@compuserve.com,
       wli@holomorphy.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-Id: <20060208190839.63c57a96.akpm@osdl.org>
In-Reply-To: <20060208190512.5ebcdfbe.akpm@osdl.org>
References: <200602051959.k15JxoHK001630@hera.kernel.org>
	<Pine.LNX.4.63.0602081728590.31711@cuia.boston.redhat.com>
	<20060208190512.5ebcdfbe.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Users of __GENERIC_PER_CPU definitely need cpu_possible_map to be initialised
>  by the time setup_per_cpu_areas() is called,

err, they'll need it once Eric's
dont-waste-percpu-memory-on-not-possible-CPUs patch is merged..

> so I think it makes sense to
>  say "thou shalt initialise cpu_possible_map in setup_arch()".
> 
>  I guess Xen isn't doing that.  Can it be made to?

Lame fix:  cpu_possible_map = (1<<NR_CPUS)-1 in setup_arch().
