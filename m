Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWIAKSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWIAKSk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 06:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWIAKSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 06:18:40 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:38348 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750991AbWIAKSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 06:18:40 -0400
Date: Fri, 1 Sep 2006 06:12:51 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
To: Badari Pulavarty <pbadari@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@osdl.org>
Message-ID: <200609010615_MC3-1-C9FA-ECE6@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1157049193.22667.19.camel@dyn9047017100.beaverton.ibm.com>

On Thu, 31 Aug 2006 11:33:13 -0700, Badari Pulavarty wrote:

> As you can see from the following stack - it shows 
> 
>       msync_interval() -> 
>               set_page_dirty() -> 
>                       __set_page_dirty_buffers()
> 
> But actual trace is (looking at the code):
> 
>       msync_interval() -> 
>               msync_page_range() ->
>                  msync_pud_range() -> 
>                     msync_pgd_range() ->
>                        msync_pte_range() ->   
>                               set_page_dirty() -> 
>                                       __set_page_dirty_buffers()
> 
> Why is it skipping all msync_page/pud/pgd/pte_range() routines ?

Sometimes this is caused by tail calls, i.e. when the last line
of a function calls another function it can many times be optimized
into a jump.

You can disable this by compiling with CONFIG_FRAME_POINTER=y.

-- 
Chuck

