Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319210AbSH2OLA>; Thu, 29 Aug 2002 10:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319211AbSH2OLA>; Thu, 29 Aug 2002 10:11:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:23466 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319210AbSH2OK7>; Thu, 29 Aug 2002 10:10:59 -0400
Subject: LTP Nightly BK Test Failure - ip_nat_helper
From: Paul Larson <plars@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 Aug 2002 09:05:14 -0500
Message-Id: <1030629915.5187.13.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The nightly bk testing last night found a new build error last night
with ip_nat_helper

This bk tree covered this range of csets:
<Starting Changeset>
ChangeSet@1.542, 2002-08-28 10:57:35+02:00, davem@redhat.com
  This converts all of the input USB drivers to manage DMA
  buffers via usb_buffer_alloc in 2.5.x  This helps platforms
  where doing a pci_{map,unmap}_single() on every input event
  is very inefficient.
  
  Also adds a missing kfree(hid), because the HID struct was never
  freed.

<Ending Changeset>
ChangeSet@1.553, 2002-08-28 17:24:08-07:00, torvalds@home.transmeta.com
  Merge with dri CVS tree:
   - update some incorrect version checks
   - update radeon driver from 1.4.0 to 1.5.0
   - use C99 named initializers

Here is the tail end of the log:
  gcc -Wp,-MD,./.ip_nat_helper.o.d -D__KERNEL__ -I/kernel/bk/linux-2.5/include -
Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-ali
asing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwit
hprefix include    -DKBUILD_BASENAME=ip_nat_helper   -c -o ip_nat_helper.o ip_na
t_helper.c
ip_nat_helper.c: In function `ip_nat_helper_register':
ip_nat_helper.c:385: parse error before string constant
ip_nat_helper.c: In function `ip_nat_helper_unregister':
ip_nat_helper.c:470: parse error before string constant
ip_nat_helper.c:471: warning: left-hand operand of comma expression has no effec
t
ip_nat_helper.c:471: parse error before `)'
make[4]: *** [ip_nat_helper.o] Error 1
make[4]: Leaving directory `/kernel/bk/linux-2.5/net/ipv4/netfilter'
make[3]: *** [netfilter] Error 2
make[3]: Leaving directory `/kernel/bk/linux-2.5/net/ipv4'
make[2]: *** [ipv4] Error 2

Thanks,
Paul Larson

