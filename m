Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129724AbQJ0KZF>; Fri, 27 Oct 2000 06:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129636AbQJ0KY4>; Fri, 27 Oct 2000 06:24:56 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:22991 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129724AbQJ0KYp>; Fri, 27 Oct 2000 06:24:45 -0400
Message-ID: <39F957BC.4289FF10@uow.edu.au>
Date: Fri, 27 Oct 2000 21:23:56 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Alexander Viro <viro@math.psu.edu>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>, kumon@flab.fujitsu.co.jp,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Negative scalability by removal of lock_kernel()?(Was: Strange 
 performance behavior of 2.4.0-test9)
In-Reply-To: <39F92187.A7621A09@timpanogas.org> <Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>,
		<Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Oct 27, 2000 at 03:13:33AM -0400 <20001027094613.A18382@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> When you have two CPUs contending on common paths it is better to do:
> [ spinlock stuff ]

Andi, if the lock_kernel() is removed then the first time the CPUs will butt heads is on a semaphore.  This is much more expensive.

I bet if acquire_fl_sem() and release_fl_sem() are turned into lock_kernel()/unlock_kernel() then the scalability will come back.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
