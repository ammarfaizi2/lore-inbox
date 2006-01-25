Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWAYHXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWAYHXA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 02:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWAYHXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 02:23:00 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:63402 "EHLO
	mail.intellilink.co.jp") by vger.kernel.org with ESMTP
	id S1750749AbWAYHW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 02:22:59 -0500
Subject: Re: [PATCH 5/5] stack overflow safe kdump (2.6.15-i386) - private
	nmi stack
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: vgoyal@in.ibm.com
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, ak@suse.de,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
In-Reply-To: <20060120131936.GE4695@in.ibm.com>
References: <1137417926.2256.89.camel@localhost.localdomain>
	 <20060118015111.GD23143@in.ibm.com>
	 <1137645795.2243.32.camel@localhost.localdomain>
	 <20060120131936.GE4695@in.ibm.com>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Wed, 25 Jan 2006 16:22:30 +0900
Message-Id: <1138173750.7159.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 08:19 -0500, Vivek Goyal wrote:
> On Thu, Jan 19, 2006 at 01:43:14PM +0900, Fernando Luis Vazquez Cao wrote:
> > On Tue, 2006-01-17 at 20:51 -0500, Vivek Goyal wrote:
> > > 
> > > Does not work for 8K stacks. Also we are switching the stack all the
> > > time for NMI. I am not sure if that is really required (performance?).
> > Yes, it does not work for 8K stacks, but this is something premeditated.
> > Since private stacks for interrupts are only used when 4KSTACKS
> > is enabled I felt that to be consistent it should be the same in
> > the NMI's case. Anyway if it is deemed correct (I agree it is desirable)
> > I could implement it.
> > 
> > Regarding the impact in performance, note that when we use 4K stacks we
> > are switching stacks _every_ time an interrupt occurs. I do not see why
> > we should not do the same for NMIs. Specially since the cost of
> > switching stacks is relatively small when compared to the cost of
> > executing the NMI watchdog's handler.
> > 
> > > Can't it be made to work both for 4K and 8K stack. And switch to reserved
> > > stack on NMI, only if crash has happened.
> > Yes, it could be done, but I think it is safer to use a private stack
> > all the time, so that the NMI handler does not contribute to an eventual
> > stack overflow. I would like to avoid the case of the the stack
> > overflowing inside the NMI handler.
> 
> Ok. Then we are looking at an entirely different problem and that is avoid
> stack overflows for NMI for 4K stacks in general and not necessarily a
> crash dump specific code hardening. 
Exactly.

Fernando

