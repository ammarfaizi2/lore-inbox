Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbVJUTLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbVJUTLX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 15:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbVJUTLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 15:11:23 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:38785 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S965098AbVJUTLX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 15:11:23 -0400
X-ORBL: [67.117.73.34]
Date: Fri, 21 Oct 2005 22:10:34 +0300
From: Tony Lindgren <tony@atomide.com>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: Eric Piel <Eric.Piel@tremplin-utc.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch 5/5] TI OMAP driver
Message-ID: <20051021191032.GP20442@atomide.com>
References: <20051019081906.615365000@omelas> <20051019091717.773678000@omelas> <435613B3.5060509@tremplin-utc.net> <20051019094439.GA12594@plexity.net> <20051021163553.GJ20442@atomide.com> <20051021180026.GN20442@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6Nae48J/T25AfBN4"
Content-Disposition: inline
In-Reply-To: <20051021180026.GN20442@atomide.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [051021 21:03]:
> Hi,
> 
> * Tony Lindgren <tony@atomide.com> [051021 19:38]:
> > 
> > Cool, works on OMAP OSK after renaming the function above.
> 
> Looks like the following __iomem patch is needed for this to
> work on OMAP H4.
> 
> At least these two compilers get confused without the following
> patch:
> 
> arm-xscale-linux-gnu-gcc (GCC) 3.4.4
> gcc version 3.4.3 (release) (CodeSourcery ARM Q1B 2005)

Here's one more patch on top of my previous patch. Now it's
tested to work on 24xx too in addition to 16xx. The status
bit did not work on 24xx earlier, and looks like the status
bit is always ready on 16xx.

Tony

--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-omap-rng-24xx-works

--- a/drivers/char/rng/omap-rng.c
+++ b/drivers/char/rng/omap-rng.c
@@ -65,9 +65,10 @@
 	__raw_writel(val, rng_base + reg);
 }
 
+/* REVISIT: Does the status bit really work on 16xx? */
 static int omap_rng_data_present(void)
 {
-	return omap_rng_read_reg(RNG_STAT_REG);
+	return omap_rng_read_reg(RNG_STAT_REG) ? 0 : 1;
 }
 
 static int omap_rng_data_read(u32 *data)

--6Nae48J/T25AfBN4--
