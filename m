Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264488AbSIVTQw>; Sun, 22 Sep 2002 15:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264492AbSIVTQw>; Sun, 22 Sep 2002 15:16:52 -0400
Received: from franka.aracnet.com ([216.99.193.44]:63212 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264488AbSIVTQv>; Sun, 22 Sep 2002 15:16:51 -0400
Date: Sun, 22 Sep 2002 12:20:16 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>,
       William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Message-ID: <85905225.1032697215@[10.10.2.3]>
In-Reply-To: <78206124.1032689516@[10.10.2.3]>
References: <78206124.1032689516@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried putting back the current->node logic now that we have
the correct node IDs, but it made things worse (not as bad as
before, but ... looks like we're still allocing off the wrong
node.

This run is the last one in the list.

Virgin:
Elapsed: 20.82s User: 191.262s System: 59.782s CPU: 1206.4%
  7059 do_anonymous_page                       
  4459 page_remove_rmap                        
  3863 handle_mm_fault                         
  3695 .text.lock.namei                        
  2912 page_add_rmap                           
  2458 rmqueue                                 
  2119 vm_enough_memory                        

Both numasched patches, just compile fixes:
Elapsed: 28.744s User: 204.62s System: 173.708s CPU: 1315.8%
 38978 do_anonymous_page                       
 36533 rmqueue                                 
 35099 __free_pages_ok                         
  5551 page_remove_rmap                        
  4694 handle_mm_fault                         
  3166 page_add_rmap                           

Both numasched patches, alloc from local node
Elapsed: 21.094s User: 195.808s System: 62.41s CPU: 1224.4%
  7475 do_anonymous_page                       
  4564 page_remove_rmap                        
  4167 handle_mm_fault                         
  3467 .text.lock.namei                        
  2520 page_add_rmap                           
  2112 rmqueue                                 
  1905 .text.lock.dec_and_lock                 
  1849 zap_pte_range                           
  1668 vm_enough_memory                        

Both numasched patches, hack node IDs, alloc from local node
Elapsed: 21.918s User: 190.224s System: 59.166s CPU: 1137.4%
  5793 do_anonymous_page                       
  4475 page_remove_rmap                        
  4281 handle_mm_fault                         
  3820 .text.lock.namei                        
  2625 page_add_rmap                           
  2028 .text.lock.dec_and_lock                 
  1748 vm_enough_memory                        
  1713 file_read_actor                         
  1672 rmqueue                                 

Both numasched patches, hack node IDs, alloc from current->node
Elapsed: 24.414s User: 194.86s System: 98.606s CPU: 1201.6%
 30317 do_anonymous_page                       
  6962 rmqueue                                 
  5190 page_remove_rmap                        
  4773 handle_mm_fault                         
  3522 .text.lock.namei                        
  3161 page_add_rmap                           

