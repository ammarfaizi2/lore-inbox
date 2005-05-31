Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVEaN5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVEaN5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 09:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbVEaN5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 09:57:54 -0400
Received: from kanga.kvack.org ([66.96.29.28]:55210 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261876AbVEaN5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 09:57:50 -0400
Date: Tue, 31 May 2005 09:59:59 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andi Kleen <ak@muc.de>
Cc: Denis Vlasenko <vda@ilport.com.ua>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86-64: Use SSE for copy_page and clear_page
Message-ID: <20050531135959.GA16081@kvack.org>
References: <20050530181626.GA10212@kvack.org> <20050530193225.GC25794@muc.de> <200505311137.00011.vda@ilport.com.ua> <200505311215.06495.vda@ilport.com.ua> <20050531092358.GA9372@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050531092358.GA9372@muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 11:23:58AM +0200, Andi Kleen wrote:
> fork is only a corner case. The main case is a process allocating
> memory using brk/mmap and then using it.

At least for kernel compiles, using non-temporal stores is a slight 
win (a 2-5s improvement on 4m30s).  Granted, there seems to be a 
lot of variation in kernel compile times.

A bit more experimentation shows that non-temporal stores plus a 
prefetch of the resulting data is still better than the existing 
routines and only slightly slower than the pure non-temporal version.  
That said, it seems to result in kernel compiles that are on the high 
side of the variations I normally see (4m40s, 4m38s) compared to the 
~4m30s for an unpatched kernel and ~4m25s-4m30s for the non-temporal 
store version.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
