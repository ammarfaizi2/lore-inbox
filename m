Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269156AbTB0DRB>; Wed, 26 Feb 2003 22:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269159AbTB0DRB>; Wed, 26 Feb 2003 22:17:01 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:16823 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S269156AbTB0DRA>;
	Wed, 26 Feb 2003 22:17:00 -0500
Message-ID: <3E5D84DD.2020402@us.ibm.com>
Date: Wed, 26 Feb 2003 19:24:13 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       akpm@digeo.com
Subject: Re: Horrible L2 cache effects from kernel compile
References: <3E5ABBC1.8050203@us.ibm.com.suse.lists.linux.kernel> <p7365r88heo.fsf@amdsimf.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Other numbers may work better for your workload. Please test.
The whole post:
http://marc.theaimsgroup.com/?l=linux-kernel&m=104619044800608&w=2

The number of cycles in d_lookup increased by 10% with your patch.  But,
it looks like lots of stuff was moving around, so I wouldn't take too
much stock in it.

% change       2.5.62        2.5.62-ak-dc
in cycles  cycles(%oftot)  cycles(%oftot)
 +20.685%    6251(0.397%)    9834(0.603%) ext3_get_inode_loc
 +13.296%   16183(1.027%)   21863(1.341%) try_to_wake_up
 +10.560%  130566(8.283%) 166867(10.239%) d_lookup
 +10.202%   12525(0.795%)   15892(0.975%) filemap_nopage
  +5.991%   22127(1.404%)   25793(1.583%) schedule
  +5.581%    8705(0.552%)   10064(0.618%) run_timer_softirq
  +4.246%    7922(0.503%)    8917(0.547%) current_kernel_time
  +4.116%    9196(0.583%)   10324(0.633%) __wake_up
  +3.739%   21650(1.373%)   24123(1.480%) __find_get_block
  +3.631%    7226(0.458%)    8034(0.493%) do_page_cache_readahead
  +3.287%   72668(4.610%)   80239(4.923%) find_get_page
  +2.857%   11435(0.725%)   12518(0.768%) strnlen_user
  -2.184%   35107(2.227%)   34745(2.132%) .text.lock.inode
  -2.200%   17129(1.087%)   16947(1.040%) __fput
  -2.706%   28213(1.790%)   27632(1.695%) start_this_handle
  -2.823%   36539(2.318%)   35703(2.191%) smp_apic_timer_interrupt
  -3.668%   26074(1.654%)   25050(1.537%) load_balance
  -3.844%    8367(0.531%)    8010(0.491%) find_vma
  -4.340%   46642(2.959%)   44211(2.713%) scheduler_tick
  -4.650%    9965(0.632%)    9387(0.576%) default_idle
  -4.667%   14213(0.902%)   13384(0.821%) do_wp_page
  -4.728%   13603(0.863%)   12794(0.785%) mark_offset_tsc
  -4.815%   39748(2.522%)   37319(2.290%) __blk_queue_bounce
  -6.545%   44437(2.819%)   40298(2.473%) x86_profile_hook
  -6.991%   36113(2.291%)   32457(1.991%) __copy_from_user_ll
  -7.660%   16275(1.032%)   14432(0.886%) may_open
 -13.539%   28492(1.807%)   22432(1.376%) get_empty_filp
 -16.257%   10334(0.656%)    7696(0.472%) file_move

-- 
Dave Hansen
haveblue@us.ibm.com

