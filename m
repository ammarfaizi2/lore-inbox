Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262276AbTC1Hql>; Fri, 28 Mar 2003 02:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262284AbTC1Hql>; Fri, 28 Mar 2003 02:46:41 -0500
Received: from holomorphy.com ([66.224.33.161]:31150 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262276AbTC1Hqk>;
	Fri, 28 Mar 2003 02:46:40 -0500
Date: Thu, 27 Mar 2003 23:57:30 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 64GB NUMA-Q after pgcl
Message-ID: <20030328075730.GP30140@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
References: <20030328040038.GO1350@holomorphy.com> <Pine.LNX.4.50.0303280243080.2884-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303280243080.2884-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 28, 2003 at 02:45:30AM -0500, Zwane Mwaikambo wrote:
> before:
> Memory: 65306956k/67100672k available (1724k kernel code, 98252k reserved, 781k data, 284k init, 65134592k highmem)
> after:
> Memory: 65946144k/67100672k available (1956k kernel code, 15936k reserved, 667k data, 300k init, 65198080k highmem)
> Would you mind explaining the details as to what would cause that 
> discrepancy in reserved memory size?

Sure. On NUMA-Q mem_map[] is not allocated using bootmem except for
node 0. Various other bootmem allocations are also proportional to
memory as measured in units of PAGE_SIZE, but not all.

So all we're seeing here is node 0's mem_map[] with "miscellaneous"
bootmem allocations thrown in, whether reduced or increased.

This is not very reflective of what's going on as the majority of mem_map[]
is allocated through a custom reservation mechanism as opposed to bootmem.


-- wli
