Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286145AbRLJCHX>; Sun, 9 Dec 2001 21:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286146AbRLJCHE>; Sun, 9 Dec 2001 21:07:04 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:58777 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S286145AbRLJCG6>; Sun, 9 Dec 2001 21:06:58 -0500
Date: Sun, 09 Dec 2001 18:10:23 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rusty Russell <rusty@rustcorp.com.au>
cc: anton@samba.org, davej@suse.de, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Linux 2.4.17-pre5
Message-ID: <2899076331.1007921423@[10.10.1.2]>
In-Reply-To: <E16DEVr-0008SW-00@the-village.bc.nu>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 	If you number each CPU so its two IDs are smp_num_cpus()/2
>> 	apart, you will NOT need to put some crappy hack in the
>> 	scheduler to pack your CPUs correctly.
> 
> Which is a major change to the x86 tree and an invasive one. Right now the
> X86 is doing a 1:1 mapping, and I can offer Marcelo no proof that somewhere
> buried in the x86 arch code there isnt something that assumes this or mixes
> a logical and physical cpu id wrongly in error. 

I don't think it matters if you do a 1:1 map or not, since the NUMA-Q boxes work 
fine without assuming this (I don't use physical APIC id's at all, except for from 
the I/O APIC to just broadcast), and I don't think anyone else does either after
we boostrap.

It shouldn't be all that hard to check. Mentally mark every time we look at the 
physical APIC id, and which variables are set from that and thus "tainted". I
did this once - I don't think it's very many at all.

I don't think changing the order we look at phys_cpu_present_map should
make much of a difference.

On the other hand, relying on the "arbitrary" cpu numbers either way doesn't
seem like the best of ideas ;-)

Martin.
