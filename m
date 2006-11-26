Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967334AbWKZIYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967334AbWKZIYu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 03:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967336AbWKZIYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 03:24:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36230 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S967334AbWKZIYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 03:24:50 -0500
Subject: Re: [patch] x86: unify/rewrite SMP TSC sync code
From: Arjan van de Ven <arjan@infradead.org>
To: Wink Saville <wink@saville.com>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <45694D6F.60100@saville.com>
References: <fa./NRPJg+JjfSQLUVwnX1GpHGIojQ@ifi.uio.no>
	 <fa.Y0RKABHd+7qnbGQYBAGPvlJ0Qic@ifi.uio.no>
	 <fa.fD3WSpNqEJ4736vYzEak5Gf3xTw@ifi.uio.no>
	 <fa.A+gkQAO1DLThaxJxPLPl3yE1CGo@ifi.uio.no>
	 <fa.INurNKWdUKAEULTHyfpSW65a/Ng@ifi.uio.no>
	 <fa.n9vySiI9RS2MCl0DZPDzxZEPiFw@ifi.uio.no> <4569404E.20402@shaw.ca>
	 <45694D6F.60100@saville.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 26 Nov 2006 09:24:44 +0100
Message-Id: <1164529484.3147.68.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-26 at 00:16 -0800, Wink Saville wrote:
> Robert Hancock wrote:
> >>>> Actually, we need to ask the CPU/System makers to provide a system wide
> > Generally user mode code should just be using gettimeofday. When the TSC 
> > is usable as a sane time source, the kernel will use it. When it's not, 
> > it will use something else like the HPET, ACPI PM Timer or (at last 
> > resort) the PIT, in increasing degrees of slowness.
> > 
> 
> But gettimeofday is much too expensive compared to RDTSC.

it's the cost of a syscall (1000 cycles?) plus what it takes to get a
reasonable time estimate. Assuming your kernel has enough time support
AND your tsc is reasonably ok, it'll be using that. If it's NOT using
that then that's a pretty good sign that you can't also use it in
userspace....

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

