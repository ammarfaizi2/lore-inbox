Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVCHJ6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVCHJ6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 04:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVCHJ4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 04:56:51 -0500
Received: from aun.it.uu.se ([130.238.12.36]:36768 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261944AbVCHJ4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 04:56:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16941.30406.381804.166260@alkaid.it.uu.se>
Date: Tue, 8 Mar 2005 10:56:22 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Frank Rowand <frowand@mvista.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH 2/5] ppc RT: ppc_cpu_khz.patch
In-Reply-To: <200503072148.j27Lm8Hu006320@localhost.localdomain>
References: <200503072148.j27Lm8Hu006320@localhost.localdomain>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Rowand writes:
 > Source: MontaVista Software, Inc.
 > Signed-off-by: Frank Rowand <frowand@mvista.com>
 > 
 > Index: linux-2.6.10/arch/ppc/platforms/prpmc800.c
 > ===================================================================
 > --- linux-2.6.10.orig/arch/ppc/platforms/prpmc800.c
 > +++ linux-2.6.10/arch/ppc/platforms/prpmc800.c
 > @@ -331,6 +331,7 @@ static void __init prpmc800_calibrate_de
 >  		tb_ticks_per_second = 100000000 / 4;
 >  		tb_ticks_per_jiffy = tb_ticks_per_second / HZ;
 >  		tb_to_us = mulhwu_scale_factor(tb_ticks_per_second, 1000000);
 > +		cpu_khz = tb_ticks_per_second / 1000;
 >  		return;
 >  	}
 >  
 > @@ -371,6 +372,7 @@ static void __init prpmc800_calibrate_de
 >  	tb_ticks_per_second = (tbl_end - tbl_start) * 2;
 >  	tb_ticks_per_jiffy = tb_ticks_per_second / HZ;
 >  	tb_to_us = mulhwu_scale_factor(tb_ticks_per_second, 1000000);
 > +	cpu_khz = tb_ticks_per_second / 1000;

etc

While I really like the idea of adding a cpu_khz platform variable
to ppc32 (my ppc32 perfctr driver has to do horrible things trying
to retrieve the TB and core frequencies), it looks to me as if your
cpu_khz really is the TB frequency not the core frequency. If so,
then please rename it to tb_khz to avoid confusion.

/Mikael
