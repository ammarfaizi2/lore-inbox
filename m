Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbSKOAbQ>; Thu, 14 Nov 2002 19:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265400AbSKOAbQ>; Thu, 14 Nov 2002 19:31:16 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:12717 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265396AbSKOAbQ>; Thu, 14 Nov 2002 19:31:16 -0500
Subject: Re: [BK PATCH 1/2] Remove NGROUPS hardlimit (resend w/o qsort)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Tim Hockin <thockin@sun.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021114193156.A2801@devserv.devel.redhat.com>
References: <mailman.1037316781.6599.linux-kernel2news@redhat.com>
	<200211150006.gAF06JF01621@devserv.devel.redhat.com>
	<3DD43C65.80103@sun.com>  <20021114193156.A2801@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Nov 2002 01:04:13 +0000
Message-Id: <1037322253.17766.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-15 at 00:31, Pete Zaitcev wrote:
> > Date: Thu, 14 Nov 2002 16:14:29 -0800
> OK. I think in your case it's probably harmless. I thought
> that two (order 1) 4K pages can hold 2000 4 byte group IDs,
> and that "ought to be enough for anybody". If you envision
> 10,000 groups, then perhaps you are right, except that it may
> be about time to think about your data structures a little more.
> I'll let Andi to remind you about the performance impact (vmalloc
> area is outside of the big TLB area).

vmalloc will allocate 12K of address space or so and will actually die
first with fragmentation problems. We should also keep small numbers of
groups inline otherwise you are going to upset the "million threads"
people 8)

