Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbUKWCTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUKWCTH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 21:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUKWCRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:17:14 -0500
Received: from ngate.noida.hcltech.com ([202.54.110.230]:17617 "EHLO
	ngate.noida.hcltech.com") by vger.kernel.org with ESMTP
	id S261212AbUKWCNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 21:13:36 -0500
Message-ID: <267988DEACEC5A4D86D5FCD780313FBB2BFBB6@exch-03.noida.hcltech.com>
From: "Deepak Kumar Gupta, Noida" <dkumar@hcltech.com>
To: "'Robin Holt '" <holt@sgi.com>,
       "Deepak Kumar Gupta, Noida" <dkumar@hcltech.com>
Cc: "''lilbilchow@yahoo.com' '" <lilbilchow@yahoo.com>,
       "''ananth@sgi.com' '" <ananth@sgi.com>,
       "''linux-kernel@vger.kernel.org' '" <linux-kernel@vger.kernel.org>,
       "''linux-ia64@vger.kernel.org' '" <linux-ia64@vger.kernel.org>
Subject: RE: smp_call_function/flush_tlb_all hang on large memory system
Date: Tue, 23 Nov 2004 07:41:07 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin 

The output of CPU is 

CPU  A: 0x02:   Kernel: CPU busy
        0x03:   Kernel: CPU busy
CPU  C: 0x03:   Kernel: CPU busy

well regarding filing the issue.. i haven't yet contactated support
persons.. send the mail to just know whether there is already a solution
available or not.. 

If you are interested in stack trace.. then it is as follows:-

[0]kdb> bt
Stack traceback for pid 7
0xe00000307b818000        7        1  1    0   R  0xe00000307b8185a0 *kswapd
0xe00000000444b120 smp_call_function+0x5e0
        args (0xe000000005033698, 0xe000000005033698, 0x1,
0xa000000000008000, 0x1)
        kernel .text 0xe000000004400000 0xe00000000444ab40
0xe00000000444b160
0xe00000000444a330 smp_flush_tlb_all+0x30
        args (0xe0000000044545a0, 0x288)
        kernel .text 0xe000000004400000 0xe00000000444a300
0xe00000000444a360
0xe0000000044545a0 flush_tlb_range+0x40
        args (0xe00000307a5b64c8, 0x2000000002128000, 0x200000000212c000,
0xe000000004559880, 0x58e)
        kernel .text 0xe000000004400000 0xe000000004454560
0xe000000004454700
0xe000000004559880 try_to_swap_out+0x320
        args (0xe00000307a5b64c8, 0xe00000303b910468, 0x27be00,
0xe000003045638250, 0xa0007fffffe20300)
        kernel .text 0xe000000004400000 0xe000000004559560
0xe000000004559c60
0xe0000000045564d0 swap_out+0x810
        args (0xa0007fffffe20300, 0x1d0, 0xe000003005400000,
0xe000003045638250, 0xe00000307a5b64c8)
        kernel .text 0xe000000004400000 0xe000000004555cc0
0xe000000004556680
0xe000000004556b10 shrink_cache+0x490
        args (0xe0000030054187f0, 0xc, 0xe000003005400000, 0x1d0,
0xa0007fffff6b9110)
        kernel .text 0xe000000004400000 0xe000000004556680
0xe0000000045574a0
0xe000000004557aa0 shrink_caches+0xe0
        args (0xe000003005400000, 0x6, 0x1d0, 0x20, 0xe000003005400000)
        kernel .text 0xe000000004400000 0xe0000000045579c0
0xe000000004557b60
0xe000000004557bf0 try_to_free_pages_zone+0x90
        args (0xe000003005400000, 0x1d0, 0x5, 0xe00000000541c998,
0xe000000005033848)
        kernel .text 0xe000000004400000 0xe000000004557b60
0xe000000004557cc0
0xe0000000045590d0 kswapd_balance_pgdat+0x110
        args (0xe000003005400000, 0xe000003005400030, 0x0,
0xe000003005400000, 0x0)
        kernel .text 0xe000000004400000 0xe000000004558fc0
0xe000000004559140
0xe0000000045591b0 kswapd_balance+0x70
        args (0x0, 0xe00000000586eb10, 0xe000000004559510, 0x287)
        kernel .text 0xe000000004400000 0xe000000004559140
0xe000000004559220
0xe000000004559510 kswapd+0x170
        args (0x0, 0xe000000004f4e250, 0x1, 0xe000000004416b00, 0x30c)
        kernel .text 0xe000000004400000 0xe0000000045593a0
0xe000000004559560
0xe000000004416b00 arch_kernel_thread+0x160
        args (0xe000000004d0f2b8, 0xe00000000521b660, 0x0, 0x0,
0xe0000000044e4a30)
        kernel .text 0xe000000004400000 0xe0000000044169a0
0xe000000004416c20
0xe0000000044e4a30 kernel_thread+0xf0
        args (0xe000000004d0f2b0, 0x0, 0xe00, 0x0, 0xe000000004d34990)
        kernel .text 0xe000000004400000 0xe0000000044e4940
0xe0000000044e4a60
0xe000000004d34990 kswapd_init+0x70
        args (0xe000000004d1d030, 0x285)
        kernel .text.init 0xe000000004d1c000 0xe000000004d34920
0xe000000004d34a00
0xe000000004d1d030 do_initcalls+0x50
        args (0xe000000004e5b2d8, 0xe00000000521b660, 0xe000000004e5b578,
0xe000000004408e20, 0x20a)
        kernel .text.init 0xe000000004d1c000 0xe000000004d1cfe0
0xe000000004d1d080
0xe000000004408e20 init+0xc0
        args (0x0, 0xe000003007014830, 0xe000000004416b00, 0x30c)
        kernel .text 0xe000000004400000 0xe000000004408d60
0xe0000000044090a0
0xe000000004416b00 arch_kernel_thread+0x160
        args (0xe000000004d10f88, 0xe00000000521b660, 0x0,
0xaeeeeeee8badbeef, 0xe0000000044e4a30)
        kernel .text 0xe000000004400000 0xe0000000044169a0
0xe000000004416c20
0xe0000000044e4a30 kernel_thread+0xf0
        args (0xe000000004d10f80, 0x0, 0xe00, 0x0, 0xe000000004408cd0)
        kernel .text 0xe000000004400000 0xe0000000044e4940
0xe0000000044e4a60
0xe000000004408cd0 rest_init+0x50
        args (0xe000000004d1cf60, 0x58e)
        kernel .text 0xe000000004400000 0xe000000004408c80
0xe000000004408d60
0xe000000004d1cf60 start_kernel+0x480
        args (0x307bda9c08, 0xb1f, 0x300467e378, 0x3004875a00, 0x307bd4b7b0)
        kernel .text.init 0xe000000004d1c000 0xe000000004d1cae0
0xe000000004d1cfe0
0xe0000000044081c0 start_ap+0x2a0
        args (0x307bf77000, 0x3004a3eb50, 0x0, 0x1, 0x307bda9c08)
        kernel .text 0xe000000004400000 0xe000000004407f20
0xe0000000044081e0

Best Regards
Deepak Kumar Gupta.
 

-----Original Message-----
From: Robin Holt
To: Deepak Kumar Gupta, Noida
Cc: 'lilbilchow@yahoo.com'; 'ananth@sgi.com';
'linux-kernel@vger.kernel.org'; 'linux-ia64@vger.kernel.org'
Sent: 11/22/04 5:44 PM
Subject: Re: smp_call_function/flush_tlb_all hang on large memory system

On Mon, Nov 22, 2004 at 03:15:00PM +0530, Deepak Kumar Gupta, Noida
wrote:
> Hi William/Rajagopal
> 
> I saw your posting related to problem on internet. Just curious to ask
you
> have you got any solution for that or not.. as i am facing same
problem on
> SGI Propack 3 (based on kernel 2.4.18)on 2 CPU IA64 machine..
> 
> If you got any solution for this then pls let me know..
> 
> Any help in this regard is appreciated.
> 
> posting:
http://www.cs.helsinki.fi/linux/linux-kernel/2003-11/1153.html
> 

Can you provide the output from an L2 "leds" command?  This will tell us
what the cpus are doing and whether they have interrupts enabled.  Have
you
contacted your support people yet?  I did not see an open case for this,
but have no idea how your support person exactly filed it.

Thanks,
Robin Holt
