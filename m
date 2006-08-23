Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWHWJ7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWHWJ7k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 05:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWHWJ7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 05:59:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:39755 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751491AbWHWJ7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 05:59:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:to:subject:cc:content-type:mime-version:references:content-transfer-encoding:message-id:in-reply-to:user-agent:from;
        b=hy3oFSDHLIRYj4Yh9mYCCqlHw3DhvwAfPWnlX2vj6t6PY0yQY0FD3r8CLGSTi8L5jhlYOd0DHdTZ7LpzEjBd9U7AHlkjQDCtttiGvLk+JBk4N0Sdmvyh5NrY5Zv4pEUXS04sIfmN4F+pdAQclhMoiqVntRPCZFvV9HPor3ldEQQ=
Date: Wed, 23 Aug 2006 11:59:50 +0200
To: "Denis Vlasenko" <vda.linux@googlemail.com>
Subject: Re: Specify devices manually in exotic environment
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
References: <op.teo9mqjlepq0rv@localhost> <200608231031.07024.vda.linux@googlemail.com>
Content-Transfer-Encoding: 7bit
Message-ID: <op.teqd10ztepq0rv@localhost>
In-Reply-To: <200608231031.07024.vda.linux@googlemail.com>
User-Agent: Opera Mail/9.00 (Linux)
From: Milan Hauth <milahu@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 10:31:06 +0200, Denis Vlasenko  
<vda.linux@googlemail.com> wrote:

> More info? What information is not passed?

Well, usually the BIOS enables access to the IDE bus, but not with me. But  
how does WinNT work on the T20 then..? Also lspci does not show any device  
identifiers -- just loads of cryptic numbers..

> mknod /dev/root b "$ROOTMAJ" "$ROOTMIN"

This also did not help -- 'cat: /dev/root: No such device or address'.  
Major/minor is 4/0, as recommended in the kernel docs for /dev/root.

So where can I find my flash memory..? Again, with GRUB I just had to  
specify the device address (0x80) and the kernel/initrd positions in  
sector syntax, which works fine. Maybe I can do the same in Linux with my  
ext2 partition, to specify the start and end sectors ('Specify drives  
manually..'). But where to start?

Here's some other info (typos may be included):


/proc/devices:
**************
Character devices:
   1 mem
   2 pty
   3 ttyp
   4 /dev/vc/0
   4 tty
   4 ttyS
   5 /dev/tty
   5 /dev/console
   5 /dev/ptmx
   7 vcs
  10 misc
  13 input
  14 sound
  29 fb
  89 i2c
  90 mtd
116 alsa
128 ptm
136 pts
180 usb
189 usb_device
226 drm

Block devices:
   1 ramdisk
   7 loop
   8 sd
  44 ftl
  65 sd
  66 sd
  67 sd
  68 sd
  69 sd
  70 sd
  71 sd
  93 nftl
128 sd      <--    Is this my 0x80 device..?
129 sd      <--    ..then this would be my 1st part.. [1]
130 sd
131 sd
132 sd
133 sd
134 sd
135 sd

[1] ..but how to access that block device then? What major/minor combi is  
needed here..?


lspci:
******
00:00.0 0600: 1078:0001
00:0f.0 0200: 100b:0020
00:12.0 0601: 1078:0100 (rev 30)
00:12.1 0680: 1078:0101
00:12.2 0101: 1078:0102
00:12.3 0401: 1078:0103
00:12.4 0300: 1078:0104
00:13.0 0c03: 0e11:a0f8 (rev 06)


/proc/iomem:
************
00000000-0008efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000ccfff : 0000:00:13.0
   000cc000-000ccfff : ohci_hcd
000f0000-000fffff : System ROM
00100000-07d0ffff : System RAM
   00100000-00303920 : Kernel code
   00303921-003cdeb3 : Kernel data
10000000-1000ffff : 0000:00:0f.0
10010000-10010fff : 0000:00:0f.0
   10010000-10010fff : natsemi
40010000-40010fff : 0000:00:12.4
40011000-4001107f : 0000:00:12.3
40012000-400120ff : 0000:00:12.1


Hope this helps.. somehow.

Cheers, milahu
