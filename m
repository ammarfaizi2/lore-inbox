Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262909AbVAFREg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbVAFREg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbVAFREg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:04:36 -0500
Received: from boa.mtg-marinetechnik.de ([62.153.155.10]:28910 "EHLO
	cascabel.mtg-marinetechnik.de") by vger.kernel.org with ESMTP
	id S262909AbVAFREH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:04:07 -0500
Message-ID: <41DD6F67.6070303@mtg-marinetechnik.de>
Date: Thu, 06 Jan 2005 18:03:35 +0100
From: Richard Ems <Richard.Ems@mtg-marinetechnik.de>
Organization: MTG Marinetechnik GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en, de, es
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Hubert Mantel <mantel@suse.de>,
       andrea@suse.de
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Subject: [PROBLEM] Badness in out_of_memory
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list, hi Mr. Mantel,

the following "badness" happened on a SuSE 9.2 with all actual updates 
and SuSE's kernel 2.6.8-24.10-smp.
The system is a dual AMD Athlon MP 2200+ with 1GB memory and 1GB swap.


# uname -a
Linux urutu 2.6.8-24.10-smp #1 SMP Wed Dec 22 11:54:27 UTC 2004 i686 
athlon i386 GNU/Linux

# free
             total       used       free     shared    buffers     cached
Mem:      1034404     683964     350440          0      30584     412916
-/+ buffers/cache:     240464     793940
Swap:      1052248     121900     930348


In /var/log/messages I found 161 times the following "badness" lines. 
The system load rised up to over 100, 159 from the "badnesses" where 
logged on the same second in /var/log/messages.

# grep -i badness /var/log/messages|wc -l
161

# grep -i badness /var/log/messages | head -5
Jan  6 14:42:24 urutu kernel: Badness in out_of_memory at mm/oom_kill.c:252
Jan  6 14:42:30 urutu kernel: Badness in out_of_memory at mm/oom_kill.c:252
Jan  6 14:42:31 urutu kernel: Badness in out_of_memory at mm/oom_kill.c:252
Jan  6 14:42:31 urutu kernel: Badness in out_of_memory at mm/oom_kill.c:252
Jan  6 14:42:31 urutu kernel: Badness in out_of_memory at mm/oom_kill.c:252

# grep -i badness /var/log/messages | tail -3
Jan  6 14:42:31 urutu kernel: Badness in out_of_memory at mm/oom_kill.c:252
Jan  6 14:42:31 urutu kernel: Badness in out_of_memory at mm/oom_kill.c:252
Jan  6 14:42:31 urutu kernel: Badness in out_of_memory at mm/oom_kill.c:252


Jan  6 14:42:24 urutu kernel: Badness in out_of_memory at mm/oom_kill.c:252
Jan  6 14:42:27 urutu kernel:  [<c01464a9>] out_of_memory+0x39/0x130
Jan  6 14:42:27 urutu kernel:  [<c014f686>] try_to_free_pages+0x196/0x1a0
Jan  6 14:42:27 urutu kernel:  [<c0147800>] __alloc_pages+0x290/0x400
Jan  6 14:42:27 urutu kernel:  [<f8856d7c>] 
dm_table_unplug_all+0x2c/0x50 [dm_mod]
Jan  6 14:42:27 urutu kernel:  [<c014a82c>] 
do_page_cache_readahead+0x13c/0x180
Jan  6 14:42:27 urutu kernel:  [<c0144139>] filemap_nopage+0x299/0x370
Jan  6 14:42:27 urutu kernel:  [<c0153022>] do_no_page+0xd2/0x2e0
Jan  6 14:42:27 urutu kernel:  [<c015348d>] handle_mm_fault+0x15d/0x1b0
Jan  6 14:42:27 urutu kernel:  [<c011c403>] do_page_fault+0x1d3/0x5ee
Jan  6 14:42:27 urutu kernel:  [<c01754d0>] __pollwait+0x0/0xd0
Jan  6 14:42:27 urutu kernel:  [<c010f1f5>] convert_fxsr_from_user+0x15/0xf0
Jan  6 14:42:27 urutu kernel:  [<c0175bfd>] sys_select+0x23d/0x4c0
Jan  6 14:42:28 urutu kernel:  [<c01f6de2>] copy_to_user+0x32/0x50
Jan  6 14:42:28 urutu kernel:  [<c011c230>] do_page_fault+0x0/0x5ee
Jan  6 14:42:28 urutu kernel:  [<c01081bd>] error_code+0x2d/0x40
Jan  6 14:42:30 urutu kernel: x1d3/0x5ee
Jan  6 14:42:30 urutu kernel:  [<c029bb78>] start_request+0x278/0x2c0
Jan  6 14:42:30 urutu kernel:  [<c010f1f5>] convert_fxsr_from_user+0x15/0xf0
Jan  6 14:42:30 urutu kernel:  [<c010f537>] restore_i387+0x67/0x70
Jan  6 14:42:30 urutu kernel:  [<c0106404>] restore_sigcontext+0x114/0x130
Jan  6 14:42:30 urutu kernel:  [<c01064e8>] sys_sigreturn+0xc8/0xe0
Jan  6 14:42:30 urutu kernel:  [<c011c230>] do_page_fault+0x0/0x5ee
Jan  6 14:42:30 urutu kernel:  [<c01081bd>] error_code+0x2d/0x40



The process killed were:
# grep Killed /var/log/messages
Jan  6 14:42:31 urutu kernel: Out of Memory: Killed process 26123 (java_vm).
Jan  6 14:42:31 urutu kernel: Out of Memory: Killed process 26126 (java_vm).
Jan  6 14:42:31 urutu kernel: Out of Memory: Killed process 26120 (java_vm).
Jan  6 14:42:31 urutu kernel: Out of Memory: Killed process 9730 
(mozilla-bin).
Jan  6 14:42:31 urutu kernel: Out of Memory: Killed process 9732 
(mozilla-bin).
Jan  6 14:42:31 urutu kernel: Out of Memory: Killed process 9739 
(mozilla-bin).


Any idea what's happening here? Do you need more info?

Thanks, Richard

-- 
Richard Ems
Tel: +49 40 65803 312
Fax: +49 40 65803 392
Richard.Ems@mtg-marinetechnik.de

MTG Marinetechnik GmbH - Wandsbeker Königstr. 62 - D 22041 Hamburg

GF Dipl.-Ing. Ullrich Keil
Handelsregister: Abt. B Nr. 11 500 - Amtsgericht Hamburg Abt. 66
USt.-IdNr.: DE 1186 70571

