Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbULIKi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbULIKi2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 05:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbULIKi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 05:38:28 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:60083 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261493AbULIKi0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 05:38:26 -0500
Date: Thu, 9 Dec 2004 11:37:47 +0100
From: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, zaphodb@zaphods.net,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041209103747.GC15537@mail.muni.cz>
References: <20041203121129.GC27716@mail.muni.cz> <41B6343A.9060601@cyberone.com.au> <20041207225932.GB12030@mail.muni.cz> <41B63738.2010305@cyberone.com.au> <20041208111832.GA13592@mail.muni.cz> <41B6E415.4000602@cyberone.com.au> <20041208131442.GF13592@mail.muni.cz> <41B81254.4040107@cyberone.com.au> <20041209090245.GB15537@mail.muni.cz> <41B82909.4040302@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41B82909.4040302@cyberone.com.au>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 09:29:29PM +1100, Nick Piggin wrote:
> Perhaps they weren't working properly in 2.6.6, or something else is 
> buggy in
> 2.6.9. 16MB in 2.6.9 should definitely give a a larger atomic reserve 
> than 900K
> in 2.6.6... so if it isn't an issue with network buffer behaviour, then the
> only other possibility AFAIKS is that page reclaim latency or efficiency has
> got much worse. This would be unlikely as it should cause problems and
> regressions on other workloads.

Increasing TCP buffers in 2.6.6 works somehow because it eliminates high RTT
over the large distance.

Here is exaclty what I do:
/sbin/sysctl -w net/core/rmem_max=8388608
/sbin/sysctl -w net/core/wmem_max=8388608
/sbin/sysctl -w net/core/rmem_default=1048576
/sbin/sysctl -w net/core/wmem_default=1048576
/sbin/sysctl -w net/ipv4/tcp_window_scaling=1
/sbin/sysctl -w net/ipv4/tcp_rmem="4096 1048576 8388608"
/sbin/sysctl -w net/ipv4/tcp_wmem="4096 1048576 8388608"
echo 32768 > /proc/sys/vm/min_free_kbytes
/sbin/ifconfig eth0 txqueuelen 1000

-- 
Luká¹ Hejtmánek
