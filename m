Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279005AbRKAObM>; Thu, 1 Nov 2001 09:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279018AbRKAObC>; Thu, 1 Nov 2001 09:31:02 -0500
Received: from ns.suse.de ([213.95.15.193]:52498 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279005AbRKAOav>;
	Thu, 1 Nov 2001 09:30:51 -0500
To: Joris van Rantwijk <joris@deadlock.et.tudelft.nl>
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: Bind to protocol with AF_PACKET doesn't work for outgoing packets
In-Reply-To: <Pine.LNX.4.21.0111010944050.16656-100000@deadlock.et.tudelft.nl.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 Nov 2001 15:30:42 +0100
In-Reply-To: Joris van Rantwijk's message of "1 Nov 2001 10:15:31 +0100"
Message-ID: <p733d3yr2b1.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joris van Rantwijk <joris@deadlock.et.tudelft.nl> writes:
> 
> So... Shouldn't dev_queue_xmit_nit() also process ptype_base then ?

Interesting bug.

It probably should, but unfortunately then it would loop back to all normal
protocols (IP, IPv6, ARP etc.) too, which would not be good.

It may be best to change af_packet to always use ptype_all and match
the protocols itself. Alternatively there would need to be a special
case.

-Andi
