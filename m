Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293717AbSCPFan>; Sat, 16 Mar 2002 00:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293718AbSCPFae>; Sat, 16 Mar 2002 00:30:34 -0500
Received: from mail.bstc.net ([63.90.24.2]:4365 "HELO mail.bstc.net")
	by vger.kernel.org with SMTP id <S293717AbSCPFaZ>;
	Sat, 16 Mar 2002 00:30:25 -0500
Date: Sat, 16 Mar 2002 16:27:30 +1100
From: Anton Blanchard <anton@samba.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020316052730.GB9396@krispykreme>
In-Reply-To: <20020313085217.GA11658@krispykreme> <460695164.1016001894@[10.10.2.3]> <20020314112725.GA2008@krispykreme> <13360000.1016130109@w-hlinder.des>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13360000.1016130109@w-hlinder.des>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> 	There are two dcache patches. The one I wrote based on Al Viro's
> 	suggestion for fast path walking is especially good for NUMA
> 	systems hit by cache bouncing (d_lookup is the main culprit in 
> 	the dcache). Martin had some initial results that looked very
> 	good. 

I gave the patch a go, here is the before and after for the kernel
compile benchmark. As you can see d_lookup and atomic_dec_and_lock
have both dropped. Since the main bottleneck for us is still the
ppc64 mm code, we didnt see a noticable drop in wall clock time.

It would be interesting to try the patch on a large specweb run,
Ive seen the dcache lock become a problem when running 8 way specweb.

Anton

before:
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

after:
152844 total                                      0.0539
113527 .cpu_idle                               
 12740 .local_flush_tlb_range                  
  7701 .local_flush_tlb_page                   
  2564 .insert_hpte_into_group                 
  2099 .do_anonymous_page                      
  1780 .lru_cache_add                          
  1230 .__copy_tofrom_user                     
  1082 .save_remaining_regs                    
   581 .rmqueue                                
   486 .__free_pages_ok                        
   479 .do_page_fault                          
   465 .copy_page                              
   371 .zap_page_range                         
   333 .atomic_dec_and_lock                    
   332 .set_page_dirty                         
   286 .__find_get_page                        
   275 .__d_lookup                             
   263 .path_lookup                            
   250 .page_cache_release                     
   221 .lru_cache_del                          
   218 .sys_brk                                
   215 .__flush_dcache_icache                  
