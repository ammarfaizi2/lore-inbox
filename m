Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbSLMDYq>; Thu, 12 Dec 2002 22:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261205AbSLMDYq>; Thu, 12 Dec 2002 22:24:46 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:64919 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261173AbSLMDYp> convert rfc822-to-8bit; Thu, 12 Dec 2002 22:24:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Zwane Mwaikambo <zwane@holomorphy.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][2.5][RFC] Using xAPIC apic address space on !Summit
Date: Thu, 12 Dec 2002 19:32:06 -0800
User-Agent: KMail/1.4.3
Cc: Martin Bligh <mbligh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <F2DBA543B89AD51184B600508B68D40010F1CE54@fmsmsx103.fm.intel.com> <Pine.LNX.4.50.0212122221450.6931-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0212122221450.6931-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212121932.06196.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 December 2002 07:26 pm, Zwane Mwaikambo wrote:
> On Thu, 12 Dec 2002, Nakajima, Jun wrote:
> > BTW, we are working on a xAPIC patch that supports more than 8 CPUs in a
> > generic fashion (don't use hardcode OEM checking). We already tested it
> > on two OEM systems with 16 CPUs.
> > - It uses clustered mode. We don't want to use physical mode because it
> > does not support lowest priority delivery mode.
>
> Wouldn't that only be for all including self? Or is the documentation
> incorrect?
>
> Thanks,
> 	Zwane

I'm not sure I understand your question.  Lowest Priority delivery mode only 
works with logical interrupts.  (I've tried it with physical intrs.  It fails 
miserably.)  The "all including self" and "all excluding self" destination 
shorthands don't do lowest priority arbitration.  They always deliver the 
interrupt to the CPUs mentioned in the shortand.

Lowest priority delivery mode isn't _too_ useful in Linux yet.  It would be 
nice to preferentially target idle CPUs with interrupts in real time.  That 
means changing each CPU's Task Priority Register (TPR) to represent how busy 
it is.  I've got some patches to do that, but haven't posted them as anything 
more than a RFC.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

