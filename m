Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310295AbSCPML1>; Sat, 16 Mar 2002 07:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310298AbSCPMLS>; Sat, 16 Mar 2002 07:11:18 -0500
Received: from petkele.almamedia.fi ([194.215.205.158]:33186 "HELO
	petkele.almamedia.fi") by vger.kernel.org with SMTP
	id <S310295AbSCPMLD>; Sat, 16 Mar 2002 07:11:03 -0500
Message-ID: <3C933633.891663B0@pp.inet.fi>
Date: Sat, 16 Mar 2002 14:10:27 +0200
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Herbert Valerio Riedel <hvr@hvrlab.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre3aa2
In-Reply-To: <20020314032801.C1273@dualathlon.random> <3C912ACF.AF3EE6F0@pp.inet.fi> <20020315105621.GA22169@suse.de> <3C9230C6.4119CB4C@pp.inet.fi> <20020315185747.P10073@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> Nevertheless as Jens said the infinite-loop-allocation in the
> ->make_request_fn path are deadlock prone at the moment, not because
> they sleeps but because they need a reserved mempool to guarantee
> operations can go ahead slowly without deadlocks even if dynamic
> allocation fails, but this is not a very pratical problem, it's very
> unlikely to deadlock there (it's not worse than the other infinite loop
> in getblk() that affects not just loop).

Unlikely to deadlock for normal filesystems, but swap on encrypted loop is a
different case.

Deadlock free operation is exactly why my prealloc loop patch is needed.
Beyond initial preallocating that is done at losetup time, it does not
allocate anything from kernel memory pools, but effectively recycles its
private per loop device preallocated memory. Encrypted swap needs that, and
normal device backed loop file systems are also happy with deadlock free and
VM stress free operation.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>
