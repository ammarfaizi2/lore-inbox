Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWAHDQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWAHDQL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 22:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbWAHDQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 22:16:11 -0500
Received: from spooner.celestial.com ([192.136.111.35]:3221 "EHLO
	spooner.celestial.com") by vger.kernel.org with ESMTP
	id S1751150AbWAHDQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 22:16:10 -0500
Date: Sat, 7 Jan 2006 22:16:05 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 7/7] Make "inline" no longer mandatory for gcc 4.x
Message-ID: <20060108031605.GB26614@kurtwerks.com>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1136543825.2940.8.camel@laptopd505.fenrus.org> <1136544309.2940.25.camel@laptopd505.fenrus.org> <20060107190531.GB8990@kurtwerks.com> <1136663088.2936.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136663088.2936.36.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.15krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CCs trimmed because Ingo's mail server says relay denied]

On Sat, Jan 07, 2006 at 08:44:48PM +0100, Arjan van de Ven took 25 lines to write:
> On Sat, 2006-01-07 at 14:05 -0500, Kurt Wall wrote:
> 
> > 
> > This patch was applied on top of the previous 6 in the series from
> > Arjan. NB that it _did_ build with 3.4.4 and -Os enabled. I'm
> > rechecking, but this is the second time I've encountered this failure.
> 
> 
> Does this fix it?

Quite. The results are interesting. For my vanilla desktop config with
all patches applied, including the fixmap.h patch for x86_64,
differences are pretty dramatic: 

   text	   data	    bss	    dec	    hex	filename
2577982	 462352	 479920	3520254	 35b6fe	vmlinux.344.NO_OPT
2620255	 462336	 479984	3562575	 365c4f	vmlinux.442.NO_OPT
2326785	 462352	 479920	3269057	 31e1c1	vmlinux.344.OPT
2227294	 502680	 479984	3209958	 30fae6	vmlinux.442.OPT

344   : gcc 3.4.4
402   : gcc 4.0.2
NO_OPT: without -Os
OPT   : with -Os

Based on .text size alone, if I was going to build and run a kernel
with GCC 4.x, I'd definitely enable -Os.

Kurt
-- 
The plot was designed in a light vein that somehow became varicose.
		-- David Lardner
