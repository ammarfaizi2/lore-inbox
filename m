Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266964AbSLWUOT>; Mon, 23 Dec 2002 15:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266965AbSLWUOT>; Mon, 23 Dec 2002 15:14:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:37504 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266964AbSLWUOS>;
	Mon, 23 Dec 2002 15:14:18 -0500
Date: Mon, 23 Dec 2002 12:16:32 -0800 (PST)
Message-Id: <20021223.121632.105420794.davem@redhat.com>
To: kiran@in.ibm.com
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Convert sockets_in_use to use per_cpu areas
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021223190847.G23413@in.ibm.com>
References: <20021223190847.G23413@in.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ravikiran G Thirumalai <kiran@in.ibm.com>
   Date: Mon, 23 Dec 2002 19:08:48 +0530

    
   -static union {
   -	int	counter;
   -	char	__pad[SMP_CACHE_BYTES];
   -} sockets_in_use[NR_CPUS] __cacheline_aligned = {{0}};
   +static DEFINE_PER_CPU(int, sockets_in_use);

You have to provide an explicit initializer for DEFINE_PER_CPU
declarations or you break some platforms with older GCC's which
otherwise won't put it into the proper section.

