Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWERBKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWERBKP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 21:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWERBKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 21:10:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:7311 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750817AbWERBKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 21:10:14 -0400
Message-Id: <4t16i2$142pji@orsmga001.jf.intel.com>
X-IronPort-AV: i="4.05,139,1146466800"; 
   d="scan'208"; a="37840498:sNHT14291459"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Con Kolivas'" <kernel@kolivas.org>
Cc: <tim.c.chen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
       <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>,
       "Mike Galbraith" <efault@gmx.de>
Subject: RE: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Wed, 17 May 2006 18:10:13 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZ6EvrFXQvuS1SKQR+W/A1ShecKxQAA2pVg
In-Reply-To: <200605181035.15142.kernel@kolivas.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote on Wednesday, May 17, 2006 5:35 PM
> What is missing 
> from the comment is to say that it is also designed to stop them at the 
> lowest possible priority that still keeps them in the interactive reinsertion 
> class.

> Using a constant ceiling value irrespective of nice will not guarantee 
> that tasks fall into the active reinsertion class dependant on their nice 
> value.

If I may ask, how does it work right now?  Ceiling is set at constant value
irrespective to nice value.  Are you saying current code is broken as well?


        ceiling = JIFFIES_TO_NS(MAX_SLEEP_AVG -
                  DEF_TIMESLICE);
        if (p->sleep_avg < ceiling)
                  p->sleep_avg = ceiling;


We maybe also misunderstand each other.  I'm not arguing of removing the
ceiling. Having a ceiling is the right thing to do here.  What I don't like
is that 2.6.17-rc4 has the ceiling set too high, and your patch also does
an inversion of the ceiling value w.r.t nice value.  So it's the detail of
what's the right value for priority boost that I'm uncomfortable with.

- Ken
