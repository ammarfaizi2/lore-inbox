Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbSLMFpT>; Fri, 13 Dec 2002 00:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbSLMFpT>; Fri, 13 Dec 2002 00:45:19 -0500
Received: from elin.scali.no ([62.70.89.10]:7943 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S261451AbSLMFpS>;
	Fri, 13 Dec 2002 00:45:18 -0500
Date: Fri, 13 Dec 2002 06:53:03 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: James Cleverdon <jamesclv@us.ibm.com>
cc: Zwane Mwaikambo <zwane@holomorphy.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Martin Bligh <mbligh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5][RFC] Using xAPIC apic address space on !Summit
In-Reply-To: <200212121932.06196.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0212130644540.1053-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2002, James Cleverdon wrote:

> On Thursday 12 December 2002 07:26 pm, Zwane Mwaikambo wrote:
> > On Thu, 12 Dec 2002, Nakajima, Jun wrote:
> > > BTW, we are working on a xAPIC patch that supports more than 8 CPUs in a
> > > generic fashion (don't use hardcode OEM checking). We already tested it
> > > on two OEM systems with 16 CPUs.
> > > - It uses clustered mode. We don't want to use physical mode because it
> > > does not support lowest priority delivery mode.
> >
> > Wouldn't that only be for all including self? Or is the documentation
> > incorrect?
> >
> > Thanks,
> > 	Zwane
> 
> I'm not sure I understand your question.  Lowest Priority delivery mode only 
> works with logical interrupts.  (I've tried it with physical intrs.  It fails 
> miserably.)  The "all including self" and "all excluding self" destination 
> shorthands don't do lowest priority arbitration.  They always deliver the 
> interrupt to the CPUs mentioned in the shortand.
> 
> Lowest priority delivery mode isn't _too_ useful in Linux yet.  It would be 
> nice to preferentially target idle CPUs with interrupts in real time.  That 
> means changing each CPU's Task Priority Register (TPR) to represent how busy 
> it is.  I've got some patches to do that, but haven't posted them as anything 
> more than a RFC.
> 

Hmm, I though the APIC routing patch found in the LSE project 
(http://sourceforge.net/projects/lse/) did this already. Atleast I've 
tested this patch on a couple of Dual E7500 Xeon boxes (kernel 2.4.20) and 
it distributes interrupts nicely.

However with the patch enabled, the interrupt latency on for example the 
Intel GbE 82544GC devices increased a fraction with this patch (a 
microsecond or two).

Regards,
--
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY

