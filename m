Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbWH2QnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbWH2QnI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbWH2QnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:43:08 -0400
Received: from gw.goop.org ([64.81.55.164]:61319 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965104AbWH2QnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:43:06 -0400
Message-ID: <44F46E8C.1000308@goop.org>
Date: Tue, 29 Aug 2006 09:42:52 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Dong Feng <middle.fengdong@gmail.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: The 3G (or nG) Kernel Memory Space Offset
References: <a2ebde260608290715o627c631uca67e5b84b8c0777@mail.gmail.com>	 <Pine.LNX.4.61.0608291634380.16371@yvahk01.tjqt.qr> <a2ebde260608290901w73575e18hffd8a9d6c989f523@mail.gmail.com>
In-Reply-To: <a2ebde260608290901w73575e18hffd8a9d6c989f523@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dong Feng wrote:
> Sorry for my typo. I actually means "0-1G physical memory space." My
> question is actually why there is a 3G offset from linear kernel to
> physical kernel. Why not simply have kernel memory linear space
> located on 0-1G linear address, and therefore the physical kernel and
> linear kernel just coincide?

If kernel virtual addresses were low, you would either need to do an 
address-space switch (=TLB flush) on every user-kernel switch, or 
require userspace to be at some high address.  The former would be very 
expensive, and the latter very strange (the standard x86 ABI requires 
low addresses).  The clean solution is to map the kernel to the high 
part of the address space, but it is easier to load the kernel into low 
physical memory at boot, thus leading to a physical-virtual offset.  The 
selection of 3G is a reasonable tradeoff of physical memory size vs user 
virtual address space size, but of course it can be adjusted, or you can 
use highmem.

    J
