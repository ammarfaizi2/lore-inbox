Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275916AbSIURIn>; Sat, 21 Sep 2002 13:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275917AbSIURIm>; Sat, 21 Sep 2002 13:08:42 -0400
Received: from franka.aracnet.com ([216.99.193.44]:56228 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S275916AbSIURIl>; Sat, 21 Sep 2002 13:08:41 -0400
Date: Sat, 21 Sep 2002 10:11:30 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
cc: LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Message-ID: <600156739.1032603089@[10.10.2.3]>
In-Reply-To: <598631797.1032601564@[10.10.2.3]>
References: <598631797.1032601564@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From the below, I'd suggest you're getting pages off the wrong 
> nodes: do_anonymous_page is page zeroing, and rmqueue the buddy
> allocator. Are you sure the current->node thing is getting set
> correctly? I'll try backing out your alloc_pages tweaking, and
> see what happens.

OK, well removing that part of the patch gets us back from 28s to 
about 21s (compared to 20s virgin), total user time compared to 
virgin is up from 59s to 62s, user from 191 to 195. So it's still 
a net loss, but not by nearly as much. Are you determining target 
node on fork or exec ? I forget ...

Profile is more comparible. Nothing sticks out any more, but maybe
it just needs some tuning for balance intervals or something. 

153385 total                                      0.1544
 91219 default_idle                            
  7475 do_anonymous_page                       
  4564 page_remove_rmap                        
  4167 handle_mm_fault                         
  3467 .text.lock.namei                        
  2520 page_add_rmap                           
  2112 rmqueue                                 
  1905 .text.lock.dec_and_lock                 
  1849 zap_pte_range                           
  1668 vm_enough_memory                        
  1612 __free_pages_ok                         
  1504 file_read_actor                         
  1484 find_get_page                           
  1381 __generic_copy_from_user                
  1207 do_no_page                              
  1066 schedule                                
  1050 get_empty_filp                          
  1034 link_path_walk                          

