Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266271AbTAOML5>; Wed, 15 Jan 2003 07:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266274AbTAOML5>; Wed, 15 Jan 2003 07:11:57 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:62613 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266271AbTAOML4>;
	Wed, 15 Jan 2003 07:11:56 -0500
Date: Wed, 15 Jan 2003 12:18:15 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: "James H. Cloos Jr." <cloos@jhcloos.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, davej@suse.de
Subject: Re: new CPUID bit
Message-ID: <20030115121815.GB32694@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Mikael Pettersson <mikpe@csd.uu.se>,
	"James H. Cloos Jr." <cloos@jhcloos.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, davej@suse.de
References: <3E23E04B.2050802@redhat.com> <m38yxn377m.fsf@lugabout.jhcloos.org> <15909.7444.490945.972037@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15909.7444.490945.972037@harpo.it.uu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 09:34:28AM +0100, Mikael Pettersson wrote:

 > A better reference for this stuff is (IMHO) AP-485, the "Intel Processor
 > Identification and the CPUID Instruction" application note. It's regularly
 > updated, and in this particular case, its description of CPUID with EAX=1
 > differs from the IA32 Volume 2 manual (245471xx) in two ways:
 > 
 > - EBX bit 31 is called "SBF", Signal Break on FERR.
 > - ECX is defined to contain additional feature flags. Currently only one
 >   is defined: ECX bit 10 is the "Context ID" feature for putting the L1
 >   D-cache in adaptive or shared mode, which matters for hyper-threaded CPUs.
 > 
 > Supporting the new ECX feature flags in the kernel will require some surgery,
 > since the current code assumes x86_capability[0] is Intel, [1] is AMD,
 > [2] is Transmeta, and [3] is for conflicting or synthesized feature flags.
 > We either shift AMD etc down one index and put ECX in [1], or add a new index
 > [4] for ECX, or kludge the few ECX-defined features in [3].

Or we change it so we end up with something like..

x86_capability[0].standard and x86_capability[0].extended

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
