Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbTDKOme (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 10:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbTDKOme (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 10:42:34 -0400
Received: from 12-229-131-42.client.attbi.com ([12.229.131.42]:45449 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S264373AbTDKOmc (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 10:42:32 -0400
Message-ID: <3E96D711.70404@comcast.net>
Date: Fri, 11 Apr 2003 07:54:09 -0700
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030409
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: kernel@kolivas.org
Subject: Re: 2.4.20-ck5
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've compiled a new kernel using the ck5 patchset you made, but have had
some problems. It seems that with my configuration, I expose a memory
leak somewhere. After the system has been up for a while, or if I try to
compile anything non-trivial (kde-libs for example), The system will use
up all available memory and further memory alloc's fail. Swap is hardly
being used in this case. My syslog file does report:


Apr 10 19:06:19 waltsathlon kernel: __alloc_pages: 1-order allocation
failed (gfp=0x1f0/0)
Apr 10 19:06:19 waltsathlon kernel: __alloc_pages: 0-order allocation
failed (gfp=0xf0/0)
Apr 10 19:06:19 waltsathlon kernel: __alloc_pages: 1-order allocation
failed (gfp=0x1f0/0)

Typically, apps fail although the OOM killer isn't triggered (not sure
if it's enabled in ck5).

I'm wondering if there's a strange interaction with XFS? I also use the
Nvidia driver, however, I also tested without loading it and receive the
same results. My XFS thought is due to the strange behaviour of the
filesystem with this patchset. When I tried compiling kdelibs, the
system chugged along until memory was used (15-20 mins) and then the
compile could no longer proceed. After seeing this and issuing a 'sync',
the drives thrashed for approx. 30-45 seconds as if flushing unwritten
data. It's as if writes are being stored indefinitely? Reverting back to
ck4 and all is well. System info below:

Chaintech 7KDD 760MPX MB
2 x AMD 2400MP
1 GB ECC Ram
2-2 disk striped arrays - 1 software MD, 1 Promise Fasttrak
XFS filesystem on all mount points except boot
Compiled with GCC-3.2.2
glibc-2.3.1

Anything else you need? Please CC as I'm not subscribed. Thanks,

-Walt

