Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275769AbSIUQnR>; Sat, 21 Sep 2002 12:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275798AbSIUQnR>; Sat, 21 Sep 2002 12:43:17 -0400
Received: from franka.aracnet.com ([216.99.193.44]:58011 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S275769AbSIUQnQ>; Sat, 21 Sep 2002 12:43:16 -0400
Date: Sat, 21 Sep 2002 09:46:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
cc: LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Message-ID: <598631797.1032601564@[10.10.2.3]>
In-Reply-To: <597807912.1032600740@[10.10.2.3]>
References: <597807912.1032600740@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Anyway, I'm giving your code a quick spin ... will give you some
>> results later ;-)
> 
> Hmmm .... well I ran the One True Benchmark (tm). The patch 
> *increased* my kernel compile time from about 20s to about 28s. 
> Not sure I like that idea ;-) Anything you'd like tweaked, or 
> more info? Both user and system time were up ... I'll grab a 
> profile of kernel stuff.

>From the below, I'd suggest you're getting pages off the wrong 
nodes: do_anonymous_page is page zeroing, and rmqueue the buddy
allocator. Are you sure the current->node thing is getting set
correctly? I'll try backing out your alloc_pages tweaking, and
see what happens.

An old compile off 2.5.31-mm1 + extras (I don't have 37, but similar)

87elapse133639 total                                      0.1390
 74447 default_idle                            
  6887 do_anonymous_page                       
  4456 page_remove_rmap                        
  4082 handle_mm_fault                         
  3733 .text.lock.namei                        
  2512 page_add_rmap                           
  2187 __generic_copy_from_user                
  1989 rmqueue                                 
  1964 .text.lock.dec_and_lock                 
  1761 vm_enough_memory                        
  1631 file_read_actor                         
  1599 zap_pte_range                           
  1507 __free_pages_ok                         
  1323 find_get_page                           
  1117 do_no_page                              
  1097 get_empty_filp                          
  1023 link_path_walk                          

2.5.37-mm1

256745 total                                      0.2584
 82934 default_idle                            
 38978 do_anonymous_page                       
 36533 rmqueue                                 
 35099 __free_pages_ok                         
  5551 page_remove_rmap                        
  4694 handle_mm_fault                         
  3166 page_add_rmap                           
  2904 do_no_page                              
  2674 .text.lock.namei                        
  2566 __alloc_pages                           
  2526 zap_pte_range                           
  2306 __generic_copy_from_user                
  2218 file_read_actor                         
  1803 vm_enough_memory                        
  1789 do_wp_page                              
  1557 .text.lock.dec_and_lock                 
  1414 find_get_page                           
  1251 do_softirq                              
  1123 release_pages                           
  1086 link_path_walk                          
  1072 get_empty_filp                          
  1038 schedule                                
