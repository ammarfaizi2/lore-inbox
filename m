Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129364AbRB0Av4>; Mon, 26 Feb 2001 19:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129372AbRB0Avq>; Mon, 26 Feb 2001 19:51:46 -0500
Received: from k2.llnl.gov ([134.9.1.1]:33015 "EHLO k2.llnl.gov")
	by vger.kernel.org with ESMTP id <S129364AbRB0Avf>;
	Mon, 26 Feb 2001 19:51:35 -0500
Message-ID: <3A9AF9E7.D0924A4C@scs.ch>
Date: Mon, 26 Feb 2001 16:50:47 -0800
From: Reto Baettig <baettig@scs.ch>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: MM Linux <linux-mm@kvack.org>, Kernel Linux <linux-kernel@vger.kernel.org>,
        Martin Frey <frey@scs.ch>
Subject: Re: RFC: vmalloc improvements
In-Reply-To: <Pine.LNX.4.30.0102240129200.5327-100000@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> question: what is this application, and why does it need so much virtual
> memory? vmalloc()-able memory is maximized to 128 MB right now, and
> increasing it conflicts with directly mapping RAM, so generally it's a
> good idea to avoid vmalloc() as much as possible.

We implemented a RPC mechanism over a fast network in the kernel. The
end application is a distributed filesystem. The RPC server needs lots
of 2MB receive buffers which are allocated using vmalloc because the NIC
has its own pagetables.
The buffers then get handed to the consumer (lots of threads) which
eventually frees them. This way, we have a performance on the RPC layer
of 200MBytes/s.

The 128MB limit is probably an Intel limitation since we don't see it on
our Alpha Machines (Linux 2.2.18 Alpha SMP)

Reto
