Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWBZU4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWBZU4B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 15:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWBZU4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 15:56:01 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:16301 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751303AbWBZU4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 15:56:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=OAU+/OFLoXowp3rblv79jh9tiOQhAibTzFU49RRc8Kh+nxl4n0o8s0VQZCz7TYHrW0FCQAlj90IXYWAD+3CNNNrP7RdWLIVK0EbvVzsAPBUHnX4TcI9JyxlaiDE/GXS22ht418DaoofR7g7agteEb6Ahc7jtFgI182y/rfEjIxM=
Subject: Re: OOM-killer too aggressive?
From: Chris Largret <largret@gmail.com>
Reply-To: largret@gmail.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Robert Hancock <hancockr@shaw.ca>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060226215627.GB4979@dmt.cnet>
References: <5KvnZ-4uN-27@gated-at.bofh.it> <4401F5E3.3090003@shaw.ca>
	 <20060226215627.GB4979@dmt.cnet>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 12:56:10 -0800
Message-Id: <1140987370.5178.9.camel@shogun.daga.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-26 at 15:56 -0600, Marcelo Tosatti wrote:
> On Sun, Feb 26, 2006 at 12:39:31PM -0600, Robert Hancock wrote:
> > I think the big question is who used up all the DMA zone.. Surely not 
> > the floppy driver..
> 
> The kernel text and data? "readelf -S vmlinux" output would be useful.

$ readelf -S vmlinux
There are 52 section headers, starting at offset 0x2548488:

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .text             PROGBITS         ffffffff81000000  00100000
       000000000026102f  0000000000000000  AX       0     0     16
  [ 2] __ex_table        PROGBITS         ffffffff81261030  00361030
       0000000000004420  0000000000000000   A       0     0     8
  [ 3] .rodata           PROGBITS         ffffffff81266000  00366000
       000000000004ba6f  0000000000000000   A       0     0     32
  [ 4] .pci_fixup        PROGBITS         ffffffff812b1a70  003b1a70
       00000000000008a0  0000000000000000   A       0     0     16
  [ 5] .rio_route        PROGBITS         ffffffff812b2310  0066997c
       0000000000000000  0000000000000000   W       0     0     1
  [ 6] __ksymtab         PROGBITS         ffffffff812b2310  003b2310
       0000000000009ac0  0000000000000000   A       0     0     16
  [ 7] __ksymtab_gpl     PROGBITS         ffffffff812bbdd0  003bbdd0
       0000000000001ea0  0000000000000000   A       0     0     16
  [ 8] __kcrctab         PROGBITS         ffffffff812bdc70  003bdc70
       0000000000004d60  0000000000000000   A       0     0     8
  [ 9] __kcrctab_gpl     PROGBITS         ffffffff812c29d0  003c29d0
       0000000000000f50  0000000000000000   A       0     0     8
  [10] __ksymtab_strings PROGBITS         ffffffff812c3920  003c3920
       0000000000010622  0000000000000000   A       0     0     32
  [11] __param           PROGBITS         ffffffff812d4000  003d4000
       0000000000000d20  0000000000000000   A       0     0     8
  [12] .data             PROGBITS         ffffffff812d5000  003d5000
       00000000000cc5d0  0000000000000000  WA       0     0     4096
  [13] .bss              NOBITS           ffffffff813a1600  004a15d0
       000000000008210c  0000000000000000  WA       0     0     64
  [14] .data.cacheline_a PROGBITS         ffffffff81424000  00524000
       0000000000004c00  0000000000000000  WA       0     0     64
  [15] .data.read_mostly PROGBITS         ffffffff81428c00  00528c00
       00000000000009b0  0000000000000000  WA       0     0     64
  [16] .vsyscall_0       PROGBITS         ffffffffff600000  00600000
       0000000000000108  0000000000000000  AX       0     0     1
  [17] .xtime_lock       PROGBITS         ffffffffff600140  00600140
       0000000000000008  0000000000000000  WA       0     0     16
  [18] .vxtime           PROGBITS         ffffffffff600150  00600150
       0000000000000030  0000000000000000  WA       0     0     16
  [19] .wall_jiffies     PROGBITS         ffffffffff600180  00600180
       0000000000000008  0000000000000000  WA       0     0     16
  [20] .sys_tz           PROGBITS         ffffffffff600190  00600190
       0000000000000008  0000000000000000  WA       0     0     16
  [21] .sysctl_vsyscall  PROGBITS         ffffffffff6001a0  006001a0
       0000000000000004  0000000000000000  WA       0     0     16
  [22] .xtime            PROGBITS         ffffffffff6001b0  006001b0
       0000000000000010  0000000000000000  WA       0     0     16
  [23] .jiffies          PROGBITS         ffffffffff6001c0  006001c0
       0000000000000008  0000000000000000  WA       0     0     16
  [24] .vsyscall_1       PROGBITS         ffffffffff600400  00600400
       000000000000002e  0000000000000000  AX       0     0     1
  [25] .vsyscall_2       PROGBITS         ffffffffff600800  00600800
       000000000000000d  0000000000000000  AX       0     0     1
  [26] .vsyscall_3       PROGBITS         ffffffffff600c00  00600c00
       000000000000000d  0000000000000000  AX       0     0     1
  [27] .data.init_task   PROGBITS         ffffffff8142c000  0062c000
       0000000000002000  0000000000000000  WA       0     0     32
  [28] .init.text        PROGBITS         ffffffff8142e000  0062e000
       00000000000238de  0000000000000000  AX       0     0     1
  [29] .init.data        PROGBITS         ffffffff81452000  00652000
       000000000000c560  0000000000000000  WA       0     0     4096
  [30] .init.setup       PROGBITS         ffffffff8145e560  0065e560
       0000000000000af8  0000000000000000  WA       0     0     8
  [31] .initcall.init    PROGBITS         ffffffff8145f058  0065f058
       0000000000000730  0000000000000000  WA       0     0     8
  [32] .con_initcall.ini PROGBITS         ffffffff8145f788  0065f788
       0000000000000018  0000000000000000  WA       0     0     8
  [33] .security_initcal PROGBITS         ffffffff8145f7a0  0066997c
       0000000000000000  0000000000000000   W       0     0     1
  [34] .altinstructions  PROGBITS         ffffffff8145f7a0  0065f7a0
       0000000000000283  0000000000000000   A       0     0     8
  [35] .altinstr_replace PROGBITS         ffffffff8145fa23  0065fa23
       0000000000000095  0000000000000000  AX       0     0     1
  [36] .exit.text        PROGBITS         ffffffff8145fab8  0065fab8
       0000000000000d5d  0000000000000000  AX       0     0     1
  [37] .init.ramfs       PROGBITS         ffffffff81461000  00661000
       0000000000000086  0000000000000000   A       0     0     1
  [38] .data.percpu      PROGBITS         ffffffff81462000  00662000
       000000000000797c  0000000000000000  WA       0     0     64
  [39] .comment          PROGBITS         0000000000000000  0066997c
       0000000000003d74  0000000000000000           0     0     1
  [40] .debug_aranges    PROGBITS         0000000000000000  0066d6f0
       000000000000d4f0  0000000000000000           0     0     1
  [41] .debug_pubnames   PROGBITS         0000000000000000  0067abe0
       0000000000026a6e  0000000000000000           0     0     1
  [42] .debug_info       PROGBITS         0000000000000000  006a164e
       0000000001ab55e4  0000000000000000           0     0     1
  [43] .debug_abbrev     PROGBITS         0000000000000000  02156c32
       00000000000ca03b  0000000000000000           0     0     1
  [44] .debug_line       PROGBITS         0000000000000000  02220c6d
       0000000000190ccd  0000000000000000           0     0     1
  [45] .debug_frame      PROGBITS         0000000000000000  023b1940
       000000000009ad88  0000000000000000           0     0     8
  [46] .debug_str        PROGBITS         0000000000000000  0244c6c8
       00000000000be96a  0000000000000001  MS       0     0     1
  [47] .debug_ranges     PROGBITS         0000000000000000  0250b032
       000000000003d1e0  0000000000000000           0     0     1
  [48] .note.GNU-stack   PROGBITS         0000000000000000  02548212
       0000000000000000  0000000000000000   X       0     0     1
  [49] .shstrtab         STRTAB           0000000000000000  02548212
       0000000000000273  0000000000000000           0     0     1
  [50] .symtab           SYMTAB           0000000000000000  02549188
       00000000000b3898  0000000000000018          51   20791     8
  [51] .strtab           STRTAB           0000000000000000  025fca20
       0000000000096692  0000000000000000           0     0     1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor
specific)

--
Chris Largret <http://daga.dyndns.org>

