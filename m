Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275936AbSIUUFm>; Sat, 21 Sep 2002 16:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275937AbSIUUFm>; Sat, 21 Sep 2002 16:05:42 -0400
Received: from franka.aracnet.com ([216.99.193.44]:61674 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S275936AbSIUUFl>; Sat, 21 Sep 2002 16:05:41 -0400
Date: Sat, 21 Sep 2002 13:09:12 -0700
From: "Martin J. Bligh" <fletch@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Dipankar Sarma <dipankar@in.ibm.com>, LSE <lse-tech@lists.sourceforge.net>
Subject: dcache RCU reduces system time for kernel compile by 10%
Message-ID: <2441951.1032613752@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Installing dcache rcu drops system time for a kernel compile
from 52.7s to 47.3s - a little better than 10% reduction.
Total elapsed time doesn't change much, but I think this is
due to the lack of parallelism in the benchmark ... I need to
start running 32 parallel kernel compiles ;-)

Results were from a 16 cpu NUMA-Q. Comparison done on 2.5.36-mm1

Profile head before RCU:

  6964 do_anonymous_page                       
  4297 .text.lock.namei                        
  4189 page_remove_rmap                        
  2261 page_add_rmap                           
  2245 __generic_copy_from_user                
  2217 .text.lock.dec_and_lock                 
  1685 vm_enough_memory                        
  1539 zap_pte_range                           
  1503 file_read_actor                         
  1389 rmqueue                                 
  1139 find_get_page                           
  1074 get_empty_filp                          
  1063 do_no_page                              
   975 link_path_walk                          
   863 __fput                                  
   838 path_lookup                             
   833 __free_pages_ok                         
   810 atomic_dec_and_lock                     
   793 __d_lookup                              
   737 do_page_fault                           
   670 .text.lock.file_table                   
   593 dput                
   577 pte_alloc_one                           
   554 __generic_copy_to_user                  

profile head after RCU:

  6841 do_anonymous_page                       
  4171 page_remove_rmap                        
  2423 __generic_copy_from_user                
  2321 page_add_rmap                           
  2247 d_lookup                                
  1773 vm_enough_memory                        
  1566 zap_pte_range                           
  1527 file_read_actor                         
  1342 rmqueue                                 
  1281 .text.lock.file_table                   
  1153 find_get_page                           
  1149 get_empty_filp                          
  1049 do_no_page                              
   891 atomic_dec_and_lock                     
   775 do_page_fault                           
   752 __free_pages_ok                         
   667 follow_mount                            
   549 __fput                                  
   535 pte_alloc_one                           
   529 do_generic_file_read                    
   521 path_lookup                             
   517 schedule                                
   509 release_pages                           
   504 do_softirq                              

