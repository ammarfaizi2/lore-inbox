Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263496AbREYDAu>; Thu, 24 May 2001 23:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263499AbREYDAk>; Thu, 24 May 2001 23:00:40 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:33529 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263496AbREYDA1>;
	Thu, 24 May 2001 23:00:27 -0400
Date: Thu, 24 May 2001 23:00:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
In-Reply-To: <200105250248.TAA00836@csl.Stanford.EDU>
Message-ID: <Pine.GSO.4.21.0105242257280.24864-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 May 2001, Dawson Engler wrote:

> > check_nmi_watchdog() is __init and we know exactly when it's called.
> > The interesting cases (SMP kernel, since for UP NR_CPUS==1) are:
> 
> Ah, nice --- I keep meaning to tell the checker to demote its warning
> about NULL bugs or large stack vars in __init routines and/or routines
> that have the substring "init" in them ;-)

Please, don't. These functions are often used from/as init_module(),
so they must handle the case when allocation fails. They can be
called long after the boot.

