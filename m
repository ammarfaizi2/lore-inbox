Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271863AbRIIDoP>; Sat, 8 Sep 2001 23:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271865AbRIIDoF>; Sat, 8 Sep 2001 23:44:05 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:42756 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S271863AbRIIDnv>; Sat, 8 Sep 2001 23:43:51 -0400
Subject: Re: [SMP lock BUG?] Re: Feedback on preemptible kernel patch
From: Robert Love <rml@tech9.net>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Roger Larsson <roger.larsson@norran.net>, linux-kernel@vger.kernel.org,
        nigel@nrg.org
In-Reply-To: <000901c138bb$8e151270$010411ac@local>
In-Reply-To: <000901c138bb$8e151270$010411ac@local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.05.07.08 (Preview Release)
Date: 08 Sep 2001 23:44:27 -0400
Message-Id: <1000007070.836.14.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-09-08 at 19:11, Manfred Spraul wrote:
> No.
> It seems to be a missing ctx_sw_off() in highmem.h:
> kmap_atomic uses a per-cpu variable, thus ctx_sw_off() is needed in
> kmap_atomic, and ctx_sw_on() in kunmap_atomic().

in my tree, kmap_atomic and kunmap_atomic are just defined to
kmap/kunmap.  are you suggesting something like this?

#define kmap_atomic(page,idx)	ctx_sw_off(); kmap(page);
#define kunmap_atomic(page,idx)	ctx_sw_on(); kunmap(page);

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

