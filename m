Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317599AbSHCQ4d>; Sat, 3 Aug 2002 12:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317610AbSHCQ4d>; Sat, 3 Aug 2002 12:56:33 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:56559 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317599AbSHCQ4c>; Sat, 3 Aug 2002 12:56:32 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.44.0208020844000.18265-100000@home.transmeta.com> 
References: <Pine.LNX.4.44.0208020844000.18265-100000@home.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davidm@hpl.hp.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: Re: adjust prefetch in free_one_pgd() 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Aug 2002 17:59:49 +0100
Message-ID: <17304.1028393989@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
> > I thought the prefetches API intended this to be a safe operation?
> Well, any _sane_ prefetch API would be safe.
> However, there is known-broken hardware out there, in which a prefetch
> from IO space will kill the machine. 

If you prefetch off the end of your object, and the thing you end up 
prefetching is a DMA buffer which we'd just nuked from our cache to allow 
the device to DMA into it, something's going to be unhappy regardless of 
whether your prefetch faults or not.

--
dwmw2


