Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbVCPTfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbVCPTfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 14:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVCPTej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 14:34:39 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:16330 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262766AbVCPTbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 14:31:19 -0500
Date: Wed, 16 Mar 2005 11:30:31 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Prefaulting
In-Reply-To: <20050311194349.1e546d8c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503161116190.30053@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503110444220.19419@schroedinger.engr.sgi.com>
 <20050311172228.773cf03d.akpm@osdl.org> <Pine.LNX.4.58.0503111913560.24817@schroedinger.engr.sgi.com>
 <20050311194349.1e546d8c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005, Andrew Morton wrote:

> >  200 MB allocation
> >
> >   Mb Rep Thr CLine  User      System   Wall  flt/cpu/s fault/wsec
> >  200  3    1   1    0.02s      0.48s   0.05s860119.275 859918.989
> >  200  3    1   1    0.02s      0.46s   0.04s886129.730 886551.621
> >  200  3    1   1    0.01s      0.47s   0.04s887920.166 886855.775
>
> But the system time went through the roof.  Would that be accounting
> inaccuracy?

Redoing the test with 2.6.11.3-bk2 on AMD64(i386 mode) 1G Ram

unpatched:

 Mb Rep Thr CLine  User      System   Wall  flt/cpu/s fault/wsec
200  3    1   1    0.00s      0.17s   0.01s844090.542 845814.978
200  3    1   1    0.00s      0.17s   0.01s853466.095 853376.002
200  3    1   1    0.00s      0.17s   0.01s853466.095 855138.626
200  3    1   1    0.00s      0.17s   0.01s848750.083 847934.815
200  3    1   1    0.00s      0.17s   0.01s848754.773 848248.554
200  3    1   1    0.00s      0.17s   0.01s844085.903 843914.312
200  3    1   1    0.01s      0.16s   0.01s848750.083 850573.694
200  3    1   1    0.00s      0.17s   0.01s844090.542 845451.843

prefault patch /proc/sys/vm/max_prealloc_order set to 4

Mb Rep Thr CLine  User      System   Wall  flt/cpu/s fault/wsec
200  3    1   1    0.00s      0.17s   0.01s848750.083 847902.050
200  3    1   1    0.00s      0.17s   0.01s853466.095 853565.693
200  3    1   1    0.00s      0.17s   0.01s848750.083 849595.115
200  3    1   1    0.00s      0.17s   0.01s848754.773 848628.162
200  3    1   1    0.00s      0.17s   0.01s844090.542 844554.657
200  3    1   1    0.00s      0.17s   0.01s848754.773 848590.654
200  3    1   1    0.00s      0.17s   0.01s848750.083 848792.295
200  3    1   1    0.00s      0.17s   0.01s844090.542 846406.904

Must have been something wrong with the test.


