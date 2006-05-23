Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWEWBzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWEWBzz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 21:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWEWBzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 21:55:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:14572 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751243AbWEWBzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 21:55:54 -0400
From: Andi Kleen <ak@suse.de>
To: Keith Owens <kaos@sgi.com>
Subject: Re: NMI problems with Dell SMP Xeons
Date: Tue, 23 May 2006 03:55:48 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <4715.1148347606@kao2.melbourne.sgi.com>
In-Reply-To: <4715.1148347606@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605230355.48399.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nd add special cases just to get an NMI send with different vector.
> 
> I have never disagreed that all NMIs will end up on the NMI vector (2).

The problem was that KDB had an own handler for its debug vector,
although that was only ever called as NMI.

> Unfortunately the way that you changed the x86_64 kdb code, it now does
> neither.  Your hack to kdb sends an IPI using NMI_VECTOR (2) which is
> 
> (a) not actually sent as an NMI and
> (b) on most of the hardware I have tested, it does not even get through
>     to the other cpus, instead it generates APIC errors.

Ok fine we can use some other vector and just the NMI bit. 
Feel free to submit a patch to do that conversion for NMI_VECTOR

-Andi
