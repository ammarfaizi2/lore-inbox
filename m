Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbULIK6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbULIK6O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 05:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbULIK6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 05:58:14 -0500
Received: from gprs215-175.eurotel.cz ([160.218.215.175]:63616 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261502AbULIK6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 05:58:07 -0500
Date: Thu, 9 Dec 2004 11:57:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Lameter <clameter@sgi.com>
Cc: nickpiggin@yahoo.com.au, Jeff Garzik <jgarzik@pobox.com>,
       torvalds@osdl.org, hugh@veritas.com, benh@kernel.crashing.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Anticipatory prefaulting in the page fault handler V1
Message-ID: <20041209105753.GB1131@elf.ucw.cz>
References: <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org> <41AEB44D.2040805@pobox.com> <20041201223441.3820fbc0.akpm@osdl.org> <41AEBAB9.3050705@pobox.com> <20041201230217.1d2071a8.akpm@osdl.org> <179540000.1101972418@[10.10.2.4]> <41AEC4D7.4060507@pobox.com> <20041202101029.7fe8b303.cliffw@osdl.org> <Pine.LNX.4.58.0412080920240.27156@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412080920240.27156@schroedinger.engr.sgi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Standard Kernel on a 512 Cpu machine allocating 32GB with an increasing
> number of threads (and thus increasing parallellism of page faults):
> 
>  Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
>  32   3    1    1.416s    138.165s 139.050s 45073.831  45097.498
...
> Patched kernel:
> 
> Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
>  32   3    1    1.098s    138.544s 139.063s 45053.657  45057.920
...
> These number are roughly equal to what can be accomplished with the
> page fault scalability patches.
> 
> Kernel patches with both the page fault scalability patches and
> prefaulting:
> 
>  Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
>  32  10    1    4.103s    456.384s 460.046s 45541.992  45544.369
...
> 
> The fault rate doubles when both patches are applied.
...
> We are getting into an almost linear scalability in the high end with
> both patches and end up with a fault rate > 3 mio faults per second.

Well, with both patches you also slow single-threaded case more than
twice. What are the effects of this patch on UP system?
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
