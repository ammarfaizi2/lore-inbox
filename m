Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbTDNS2R (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbTDNSOb (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:14:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50444 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263624AbTDNRzl (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:55:41 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Memory mapped files question
Date: 14 Apr 2003 11:07:09 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b7etcd$s0n$1@cesium.transmeta.com>
References: <002101c30239$fc0ae630$fe64a8c0@webserver> <8180000.1050330998@[10.10.2.4]> <20030414150759.GA14552@wind.cocodriloo.com> <11640000.1050332688@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <11640000.1050332688@[10.10.2.4]>
By author:    "Martin J. Bligh" <mbligh@aracnet.com>
In newsgroup: linux.dev.kernel
>
> > Martin, something which was not mentioned last week (I've just checked).
> > 
> > It's OK if we never write to disk unless explicitely told, but will we writeback
> > when we munmap?
> 
> Don't know for sure - you'd have to read the code (do_munmap) ... I couldn't
> see anything there at a quick glance. However, I'd guess we don't write it, 
> as multiple people could have the file mapped, or we could remap it
> again from somewhere. Presumably the standard LRU will just flush it out.
> 

munmap() and fsync() or msync() will flush it to disk; there is no
reason munmap() should unless perhaps the file was opened O_SYNC.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
