Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267350AbTABXwO>; Thu, 2 Jan 2003 18:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267351AbTABXwO>; Thu, 2 Jan 2003 18:52:14 -0500
Received: from holomorphy.com ([66.224.33.161]:44230 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267350AbTABXwN>;
	Thu, 2 Jan 2003 18:52:13 -0500
Date: Thu, 2 Jan 2003 16:00:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: Questton about Zone Allocation 2.4.X
Message-ID: <20030103000034.GU9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
	linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
References: <20030102175517.A21471@vger.timpanogas.org> <20030102235147.GS9704@holomorphy.com> <20030102180849.A21498@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030102180849.A21498@vger.timpanogas.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> __get_free_pages() allocates from lowmem (i.e. 0-4GB) only.
>> Allocate from highmem instead.

0-1GB. page_address() will give unpredictable results on highmem GFP masks.

On Thu, Jan 02, 2003 at 06:08:49PM -0700, Jeff V. Merkey wrote:
> 0-4GB is where I need to allocate, so allocating from highmem is not 
> a solution.  I found the Ingo/Andrea patch for RH 8.0, but this patch 
> looks a little scary since it affects the memory allocations between
> user and kernel space and the ratios alloted to these areas (I may 
> be missing something here -- as Dave M. puts it "Jeff you are such a pain
> in the ass sometimes"  :-).  

There is no GFP mask for it. Port Jens' ZONE_DMA32 or something, or roll
ZONE_4G on your own if need be.


Bill
