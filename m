Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVFHQ7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVFHQ7D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVFHQ7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:59:02 -0400
Received: from mailgate1b.savvis.net ([216.91.182.6]:21956 "EHLO
	mailgate1b.savvis.net") by vger.kernel.org with ESMTP
	id S261232AbVFHQ6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 12:58:49 -0400
From: "Dan A. Dickey" <dan.dickey@savvis.net>
Reply-To: dan.dickey@savvis.net
Organization: WAM!NET a Division of SAVVIS, Inc.
To: Andrew Morton <akpm@osdl.org>
Subject: Re: System state too high for too long...
Date: Wed, 8 Jun 2005 11:58:40 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200506071125.41543.dan.dickey@savvis.net> <20050607211310.7f6ee27e.akpm@osdl.org>
In-Reply-To: <20050607211310.7f6ee27e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506081158.40461.dan.dickey@savvis.net>
X-OriginalArrivalTime: 08 Jun 2005 16:58:40.0496 (UTC) FILETIME=[520E8F00:01C56C4B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 June 2005 23:13, Andrew Morton wrote:
> "Dan A. Dickey" <dan.dickey@savvis.net> wrote:
> > This problem has now been persistent enough in the last few
> > kernels I've run that I've subscribed (once again) to the
> > linux-kernel list and would like to report it.
> >  I'm using gentoo-sources-2.6.11-r9.

Switched to vanilla-sources 2.6.12-rc6 just to rule out
the possible influence of patches...

> >  When the system is compiling something, the state typically
> >  stays at about 85-95% system time.  This just really does not
> >  seem right for my workload, and additionally only appeared
> >  a few releases ago (sorry, I didn't bother to track it - I
> > thought it might go away in a release or two; but it has not).
...
> >   1  0  12752  62284  57348 211268    0    0     4    53 1087  
> > 807 17 83  0  0
> >   1  0  12752  59400  57356 211328    0    0     0    34 1222 
> > 1919 17 83  0  0
>
> (grr, wordwrapping.)

Yeah; sorry - my email gui is doing that.  I turned it off.
Don't know why I had it on in the first place.

> - Check that your disks are running in DMA mode (if they're IDE)
> (with hdparm)

It looks to me like it is:
# hdparm -I /dev/hda

/dev/hda:

ATA device, with non-removable media
        Model Number:       WDC WD400BB-75DEA0
        Serial Number:      WD-WMAD16857838
        Firmware Revision:  05.03E05
Standards:
        Supported: 5 4 3 2
        Likely used: 6
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:   78165360
        device size with M = 1024*1024:       38166 MBytes
        device size with M = 1000*1000:       40020 MBytes (40 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 40     Queue depth: 1
        Standby timer values: spec'd by Standard, with device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
           *    SMART feature set
           *    Device Configuration Overlay feature set
           *    Automatic Acoustic Management feature set
                SET MAX security extension
           *    DOWNLOAD MICROCODE cmd
           *    SMART self-test
           *    SMART error logging
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by CSEL
Checksum: correct

> - See what `time make' says

It says:
real    9m51.034s
user    1m43.371s
sys     6m2.018s

> - Generate a kernel profile (See Documentation/basic_profiling.txt)

How much of it is useful?  I used readprofile; here is what to me looks
like the most relevant portion of it.
# sort -nr +2 < captured_profile | head -n 40
281609 kmem_cache_free                          2448.7739
 25158 default_idle                             535.2766
  8704 kernel_map_pages                          93.5914
  3870 sock_poll                                 86.0000
  6133 poison_obj                                80.6974
  8846 kfree                                     60.5890
  2784 _atomic_dec_and_lock                      30.2609
   696 fput                                      27.8400
  2824 change_page_attr                          24.9912
  2483 fget                                      22.9907
  9986 buffered_rmqueue                          18.6306
  2086 sysenter_past_esp                         17.8291
  1091 sub_preempt_count                         17.3175
  5607 __d_lookup                                14.9920
  1295 strncpy_from_user                         11.6667
   568 add_preempt_count                         11.3600
  1597 vfs_getattr                               10.9384
  3672 tcp_poll                                  10.2857
  1270 __copy_to_user_ll                         10.0794
  1323 __do_softirq                               9.4500
   902 kmap_atomic                                7.9823
   290 dbg_redzone1                               6.9048
   731 __get_zone_counts                          6.7064
   417 path_release                               6.6190
   277 kmem_flagcheck                             6.2955
   136 __mod_page_state                           6.1818
    84 obj_reallen                                6.0000
   947 kmem_cache_alloc                           5.9937
   995 getname                                    5.5587
   182 kunmap_atomic                              5.2000
   139 get_offset_tsc                             5.1481
    65 ide_outbsync                               5.0000
  1824 path_lookup                                4.9973
   410 find_get_page                              4.6591
   429 find_vma                                   4.5638
   749 __might_sleep                              4.4850
  4216 do_wp_page                                 4.4756
   245 sys_lstat64                                4.3750
   553 follow_mount                               3.6867
   623 page_address                               3.4611

If more of this would help, let me know and I can get
it to whomever can help.  Thanks!
	-Dan

-- 
Dan A. Dickey
dan.dickey@savvis.net

SAVVIS
Transforming Information Technology
