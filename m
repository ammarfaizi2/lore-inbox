Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278763AbRJZRMk>; Fri, 26 Oct 2001 13:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278759AbRJZRMa>; Fri, 26 Oct 2001 13:12:30 -0400
Received: from t2.redhat.com ([199.183.24.243]:61175 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S278746AbRJZRM0>;
	Fri, 26 Oct 2001 13:12:26 -0400
Date: Fri, 26 Oct 2001 10:11:45 -0700
From: Richard Henderson <rth@redhat.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, torvalds@transmeta.com,
        alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: alpha 2.4.13: fix taso osf emulation
Message-ID: <20011026101145.D1663@redhat.com>
In-Reply-To: <20011026013101.A1404@redhat.com> <Pine.GSO.3.96.1011026113847.14048A-100000@delta.ds2.pg.gda.pl> <20011026144522.B18880@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011026144522.B18880@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Fri, Oct 26, 2001 at 02:45:22PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2001 at 02:45:22PM +0400, Ivan Kokshaysky wrote:
>  find_vma() only after VM wraparound, which is extremely rare;
>  keeps osf /sbin/loader happy, so no need for alpha-specific routine.

Yes there is, since TASO applications need to wrap at 1<<31, 
not TASK_SIZE.  Note that TASK_SIZE should _not_ be changed
for TASO applications, since they can explicitly map memory
above 4G.  An example here is em86, in which the low 4G is
reserved for the emulated program, and the emulator lives in
high memory.

> Patch appended, comments?

I think you're working too hard to make this "efficient", and
in the process making the code hard to read.  A subroutine
containing a simple search-forward loop is just as effective.


r~
