Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265890AbTAOIZq>; Wed, 15 Jan 2003 03:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbTAOIZq>; Wed, 15 Jan 2003 03:25:46 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:53156 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S265890AbTAOIZj>;
	Wed, 15 Jan 2003 03:25:39 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15909.7444.490945.972037@harpo.it.uu.se>
Date: Wed, 15 Jan 2003 09:34:28 +0100
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, davej@suse.de
Subject: Re: new CPUID bit
In-Reply-To: <m38yxn377m.fsf@lugabout.jhcloos.org>
References: <3E23E04B.2050802@redhat.com>
	<m38yxn377m.fsf@lugabout.jhcloos.org>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James H. Cloos Jr. writes:
 > Ulrich> Northwood P4's have one more bit in the CPUID processor info
 > Ulrich> set: bit 31.  Intel calls the feature PBE (Pending Break
 > Ulrich> Enable).
 > 
 > For the curious, from <http://www.aceshardware.com/forum?read=80030620>:
 > 
 > Adrian> Bit 31 is PBE (Pending Break Enable) which you can find in the
 > Adrian> latest P4 instruction manual (document 24547106, page
 > Adrian> 159-162). To quote:

A better reference for this stuff is (IMHO) AP-485, the "Intel Processor
Identification and the CPUID Instruction" application note. It's regularly
updated, and in this particular case, its description of CPUID with EAX=1
differs from the IA32 Volume 2 manual (245471xx) in two ways:

- EBX bit 31 is called "SBF", Signal Break on FERR.
- ECX is defined to contain additional feature flags. Currently only one
  is defined: ECX bit 10 is the "Context ID" feature for putting the L1
  D-cache in adaptive or shared mode, which matters for hyper-threaded CPUs.

Supporting the new ECX feature flags in the kernel will require some surgery,
since the current code assumes x86_capability[0] is Intel, [1] is AMD,
[2] is Transmeta, and [3] is for conflicting or synthesized feature flags.
We either shift AMD etc down one index and put ECX in [1], or add a new index
[4] for ECX, or kludge the few ECX-defined features in [3].

/Mikael
