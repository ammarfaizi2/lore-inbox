Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbSJCMum>; Thu, 3 Oct 2002 08:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263281AbSJCMum>; Thu, 3 Oct 2002 08:50:42 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:18672 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263279AbSJCMul>; Thu, 3 Oct 2002 08:50:41 -0400
Subject: Re: [rfc] [patch] kernel hooks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: vamsi@in.ibm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       richardj_moore@uk.ibm.com, grundym@us.ibm.com, vamsi_krishna@in.ibm.com,
       suparna <bsuparna@in.ibm.com>
In-Reply-To: <15772.15056.287602.502467@kim.it.uu.se>
References: <20021003175600.A17884@in.ibm.com> 
	<15772.15056.287602.502467@kim.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 14:01:41 +0100
Message-Id: <1033650101.28022.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 13:40, Mikael Pettersson wrote:
> You just triggered Intel's "Unsynchronised Cross-Modifying Code
> Operations Can Cause Unexpected Instruction Execution Results"
> Erratum, which affects _every_ multiprocessor Intel P6 box.
> It's Pentium 3 Erratum E49 if you want to look it up; the other
> Intel P6s have it too, but with different numbers.
> 
> In short, the only safe way to do this sort of thing is to force
> all other processors to wait on a barrier first, then modify the
> code, then release the barrier.

You must also ensure that the code you are modifying isnt on an IRQ path
(if it is you must do spin locks and then be very careful about cross
cpu tlb deadlocks). Finally you have no choice but to ensure you never
use it on the NMI path

