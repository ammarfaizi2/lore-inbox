Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWC1DRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWC1DRI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 22:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWC1DRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 22:17:08 -0500
Received: from pproxy.gmail.com ([64.233.166.179]:23102 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751226AbWC1DRH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 22:17:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AG2kA+Rdq4HhVrJ5KAY74u7U5lj+oizvRNG7Lcm9V0wzcho8ttHSIaYmP8mkTfjrUBWSXNwaHVUI1q/J96oUfjdZLqig/+0YTh3/AUjtCZGlDOYbBIzKd7i3s8KaZi2mFsv6yiSYUofdLGwHfLpFlnDUFrb80heUtOH9PsYXWFY=
Message-ID: <632b79000603271917h4104049dh9b6b8251feac0437@mail.gmail.com>
Date: Mon, 27 Mar 2006 21:17:03 -0600
From: "Don Dupuis" <dondster@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Oops at __bio_clone with 2.6.16-rc6 anyone??????
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will get this oops during reboots. It doesn't happen everytime, but
It happens on this system at least 1 to 2 out of 10 reboots. The
machine is a Dell Powervault 745n. Here is the oops output:

Mar 20 22:27:49 (none) kernel: EXT3-fs: mounted filesystem with
journal data mode.
Mar 20 22:27:49 (none) kernel: Unable to handle kernel paging request
at virtual address f8000000
Mar 20 22:27:49 (none) kernel: printing eip:
Mar 20 22:27:49 (none) kernel: c0156db1
Mar 20 22:27:49 (none) kernel: *pde = 00000000
Mar 20 22:27:49 (none) kernel: Oops: 0000 [#1]
Mar 20 22:27:49 (none) kernel: SMP
Mar 20 22:27:49 (none) kernel: Modules linked in:
Mar 20 22:27:49 (none) kernel: CPU: 0
Mar 20 22:27:50 (none) kernel: EIP: 0060:[<c0156db1>] Not tainted VLI
Mar 20 22:27:50 (none) kernel: EFLAGS: 00010206 (2.6.16-rc6 #3)
Mar 20 22:27:50 (none) kernel: EIP is at __bio_clone+0x29/0x9b
Mar 20 22:27:50 (none) kernel: eax: 00000300 ebx: f68f3700 ecx:
00000002 edx: f7fffc80
Mar 20 22:27:50 (none) kernel: esi: f8000000 edi: f7f3d378 ebp:
f7c44b98 esp: f7c44b84
Mar 20 22:27:50 (none) kernel: ds: 007b es: 007b ss: 0068
Mar 20 22:27:50 (none) kernel: Process ldconfig (pid: 581,
threadinfo=f7c44000 task=f7db9070)
Mar 20 22:27:50 (none) kernel: Stack: <0>f7d3b458 f68f3700 f68f3700
f7fffc80 f65b4640 f7c44ba8 c0156e4e f7d4c664
Mar 20 22:27:50 (none) kernel: 00000010 f7c44bf4 c02c8346
00000080 00000000 00000e00 c0154b1b 00000000
Mar 20 22:27:50 (none) kernel: 0000007f 00000080 f7fffc80
f7d4a740 f7d44400 f7fffc80 f7d3b458 c01579c3
Mar 20 22:27:50 (none) kernel: Call Trace:
Mar 20 22:27:50 (none) kernel: [<c0104260>] show_stack_log_lvl+0xa8/0xb0
Mar 20 22:27:50 (none) kernel: [<c0104397>] show_registers+0x109/0x171
Mar 20 22:27:50 (none) kernel: [<c010456e>] die+0xfb/0x16f
Mar 20 22:27:50 (none) kernel: [<c0114750>] do_page_fault+0x359/0x48b
Mar 20 22:27:50 (none) kernel: [<c0103f0b>] error_code+0x4f/0x54
Mar 20 22:27:50 (none) kernel: [<c0156e4e>] bio_clone+0x2b/0x31
Mar 20 22:27:50 (none) kernel: [<c02c8346>] make_request+0x208/0x3d4
Mar 20 22:27:50 (none) kernel: [<c02c8211>] make_request+0xd3/0x3d4
Mar 20 22:27:50 (none) kernel: [<c01d3b68>] generic_make_request+0xf5/0x105
Mar 20 22:27:50 (none) kernel: [<c01d3c19>] submit_bio+0xa1/0xa9
Mar 20 22:27:50 (none) kernel: [<c0170453>] mpage_bio_submit+0x1c/0x21
Mar 20 22:27:50 (none) kernel: [<c017085c>] do_mpage_readpage+0x30b/0x44d
Mar 20 22:27:50 (none) kernel: [<c0170a2b>] mpage_readpages+0x8d/0xf1
Mar 20 22:27:50 (none) kernel: [<c01a7ee7>] ext3_readpages+0x14/0x16
Mar 20 22:27:50 (none) kernel: [<c013e92f>] read_pages+0x26/0xc6
Mar 20 22:27:50 (none) kernel: [<c013eae8>]
__do_page_cache_readahead+0x119/0x135
Mar 20 22:27:50 (none) kernel: [<c013ebac>] do_page_cache_readahead+0x3d/0x49
Mar 20 22:27:50 (none) kernel: [<c0139c92>] filemap_nopage+0x149/0x2c9
Mar 20 22:27:50 (none) kernel: [<c01445ce>] do_no_page+0x82/0x245
Mar 20 22:27:50 (none) kernel: [<c01448fb>] __handle_mm_fault+0xf4/0x1ba
Mar 20 22:27:50 (none) kernel: [<c011456b>] do_page_fault+0x174/0x48b
Mar 20 22:27:50 (none) kernel: [<c0103f0b>] error_code+0x4f/0x54
Mar 20 22:27:50 (none) kernel: Code: 5d c3 55 89 e5 57 56 53 51 51 89
45 f0 8b 42 0c 8b 4d f0 8b 40 58 8b 40 34 89 45 ec 6b 42 2c 0c 8b 79
30 8b 72 30 89 c1 c1 e9 02 <f3> a5 89 c1 83 e1 03 74 02 f3 a4 8b 45 f0
8b 0a 8b 5a 04 89 58


Thanks

Don Dupuis
