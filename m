Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293728AbSCPGQe>; Sat, 16 Mar 2002 01:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293731AbSCPGQY>; Sat, 16 Mar 2002 01:16:24 -0500
Received: from mail.bstc.net ([63.90.24.2]:52492 "HELO mail.bstc.net")
	by vger.kernel.org with SMTP id <S293728AbSCPGQK>;
	Sat, 16 Mar 2002 01:16:10 -0500
Date: Sat, 16 Mar 2002 17:15:35 +1100
From: Anton Blanchard <anton@samba.org>
To: lse-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: 7.52 second kernel compile
Message-ID: <20020316061535.GA16653@krispykreme>
In-Reply-To: <20020313085217.GA11658@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020313085217.GA11658@krispykreme>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Let the kernel compile benchmarks continue!

I think Im addicted. I need help!

In this update we added 8 cpus and rewrote the ppc64 pagetable management
code to do lockless inserts and removals (there is still locking at
the pte level to avoid races).

hardware: 32 way logical partition, 1.1GHz POWER4, 60G RAM

kernel: 2.5.7-pre1 + ppc64 pagetable rework

kernel compiled: 2.4.18 x86 with Martin's config

compiler: gcc 2.95.3 x86 cross compiler

make[1]: Leaving directory `/home/anton/intel_kernel/linux/arch/i386/boot'
128.89user 40.23system 0:07.52elapsed 2246%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (437084major+572835minor)pagefaults 0swaps

7.52 seconds is not a bad result for something running under a hypervisor.
The profile looks much better now. We still spend a lot of time flushing tlb
entries but we can look into batching them.

Anton
--
anton@samba.org
anton@au.ibm.com

155912 total                                      0.0550
114562 .cpu_idle                               

 12615 .local_flush_tlb_range                  
  8476 .local_flush_tlb_page                   
  2576 .insert_hpte_into_group                 

  1980 .do_anonymous_page                      
  1813 .lru_cache_add                          
  1390 .d_lookup                               
  1320 .__copy_tofrom_user                     
  1140 .save_remaining_regs                    
   612 .rmqueue                                
   517 .atomic_dec_and_lock                    
   492 .do_page_fault                          
   444 .copy_page                              
   438 .__free_pages_ok                        
   375 .set_page_dirty                         
   350 .zap_page_range                         
   314 .schedule                               
   270 .__find_get_page                        
   245 .page_cache_release                     
   233 .lru_cache_del                          
   231 .hvc_poll                               
   215 .sys_brk                                
