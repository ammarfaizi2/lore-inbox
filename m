Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbTKXQuE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 11:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTKXQuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 11:50:04 -0500
Received: from fmr04.intel.com ([143.183.121.6]:5863 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263766AbTKXQuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 11:50:01 -0500
Subject: Re: not fixed in 2.4.23-rc3 (was: Re: 2.4.22 SMP kernel build for
	hyper threading P4)
From: Len Brown <len.brown@intel.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Eduard Bloch <edi@gmx.de>, linux-kernel@vger.kernel.org, davej@redhat.com
In-Reply-To: <20031124070016.GX22764@holomorphy.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC886F@hdsmsx402.hd.intel.com>
	 <20031123204532.GA6093@zombie.inka.de> <1069654747.2812.689.camel@dhcppc4>
	 <20031124070016.GX22764@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1069692557.3035.17.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Nov 2003 11:49:18 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-24 at 02:00, William Lee Irwin III wrote:

> A similar (but more elaborate) fix is in 2.6.

Why is the additional variable "kicked" in 2.6 necessary?
Appears that kicked == (cpucount + 1), and the loop already
compares that to NR_CPUS via max_cpus:

                if (max_cpus <= cpucount+1)
                        continue;

Though I think it would read more clearly this way:

                if (cpucount + 1 >= max_cpus)
                        break;

Speaking of max_cpus, it would probably be a good thing if maxcpus() did
not allow the administrator to set max_cpus > NR_CPUS at boot time.

cheers,
-Len



