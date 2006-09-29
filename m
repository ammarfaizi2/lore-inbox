Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422819AbWI2UgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422819AbWI2UgW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 16:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422821AbWI2UgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 16:36:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:22455 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422819AbWI2UgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 16:36:21 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.18-mm2
Date: Fri, 29 Sep 2006 22:36:15 +0200
User-Agent: KMail/1.9.3
Cc: Jim Cromie <jim.cromie@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060928014623.ccc9b885.akpm@osdl.org> <200609290108.15400.ak@suse.de> <20060929201449.GA32262@elte.hu>
In-Reply-To: <20060929201449.GA32262@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609292236.15330.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 September 2006 22:14, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > BTW I was planning to make LOCAL_APIC unconditional on i386 too like 
> > on x86-64.
> 
> please dont - embedded doesnt need it most of the time.

What do you mean with not need?  Local APIC is an infinitely better
interface than PIC and faster. On embedded too this makes a lot of sense.
And a lot of modern systems don't even work anymore without
APIC enabled because Windows uses it and the BIOS haven't been
tested without it (e.g. you often find totally broken code paths
in the AML for PIC mode) 

The code size also isn't a good argument because the delta
isn't that big:

   text    data     bss     dec     hex filename
3303894  694980  436420 4435294  43ad5e obj32-up/vmlinux
3266532  665732  402372 4334636  42242c obj32-up-noapic/vmlinux

~63K. I don't think such a small difference is worth the maintenance
overhead of the many ifdefs and hairy code paths. If someone really
cared about that memory they could save much more by just optimizing
some dynamic memory allocations instead, which waste much more.

The only reason to not use it are old broken BIOS or old CPUs 
without local APIC, but those can be all handled at runtime like
the 64bit kernel does.

The SUSE kernel has a imho good default heuristic based on 
DMI date, DMI number of processors and of course trusting the ACPI tables
(don't use if disabled there) 

> At most make it  
> default y and dependent on EMBEDDED.

The whole point is to get rid of the many ifdefs and frequent
compile breakage of it. This would defeat it.

-Andi
