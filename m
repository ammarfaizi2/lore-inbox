Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264516AbTLMIrH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 03:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbTLMIrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 03:47:06 -0500
Received: from multiserv.relex.ru ([213.24.247.63]:11685 "EHLO
	mail.techsupp.relex.ru") by vger.kernel.org with ESMTP
	id S264516AbTLMIrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 03:47:04 -0500
From: Yaroslav Rastrigin <yarick@relex.ru>
Organization: RELEX Inc.
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: 2.6.0-test11-wli-2
Date: Sat, 13 Dec 2003 11:45:26 +0300
User-Agent: KMail/1.5.94
References: <20031211052929.GN19856@holomorphy.com> <20031213012703.GR19856@holomorphy.com>
In-Reply-To: <20031213012703.GR19856@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312131145.27509.yarick@relex.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 December 2003 04:27, William Lee Irwin III wrote:
> On Wed, Dec 10, 2003 at 09:29:29PM -0800, William Lee Irwin III wrote:
> > Successfully tested on a Thinkpad T21 and 32GB NUMA-Q. Any feedback
> > regarding performance would be very helpful. Desktop users should
> > notice top(1) is faster, kernel hackers that kernel compiles are faster,
> > and highmem users should see much less per-process lowmem overhead
Performance is, indeed, better. My Thinkpad T21 feels slightly on steroids 
with -wli-2 :-). Some problems, though, were encountered:
1. fs/dcache.c/d_validate() function was removed in your patch, but it is used 
in at least one place ( fs/smbfs/cache.c/smb_dget_fpos() ).
2. With 2.6.0-test11 vanilla, suspend-to-ram/suspend-to-disk was working 
nicely. With -wli-2 suspend fails on 'stopping tasks' phase, and aborts with 

Dec 13 01:08:47 localhost kernel: Stopping tasks: ======================                                                    
Dec 13 01:08:47 localhost kernel:  stopping tasks failed (1 tasks remaining)                                                
Dec 13 01:08:47 localhost kernel: Restarting tasks...<6> Strange, swapper not 
stopped

Hope this helps. 
-- 
With all the best, yarick at relex dot ru.
