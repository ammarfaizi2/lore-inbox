Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284720AbRLDAUw>; Mon, 3 Dec 2001 19:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284858AbRLDASH>; Mon, 3 Dec 2001 19:18:07 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:64536 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S285213AbRLCVxo>; Mon, 3 Dec 2001 16:53:44 -0500
Date: Mon, 3 Dec 2001 16:53:42 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: David Mosberger <davidm@hpl.hp.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
        linux-ia64@linuxia64.org, marcelo@conectiva.com.br, davem@redhat.com
Subject: Re: [Linux-ia64] patch to no longer use ia64's software mmu
Message-ID: <20011203165342.A16017@devserv.devel.redhat.com>
In-Reply-To: <20011203160059.A2022@devserv.devel.redhat.com> <15371.62205.231945.798891@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15371.62205.231945.798891@napali.hpl.hp.com>; from davidm@hpl.hp.com on Mon, Dec 03, 2001 at 01:47:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2001 at 01:47:41PM -0800, David Mosberger wrote:

> How soon will Jens' patch make it into the official tree?  I think
> that would be a pre-requisite before switching to a highmem based
> implementation.

I understood (and hope) "soon". 

> Another concern I have is that, fundamentally, I dislike the idea of
> penalizing all IA-64 platforms due to one chipset that is, shall we
> say, "lacking" (i.e., doesn't have an I/O TLB).

I think some of it (if not all) can be abstracted in the machine vectors;
setting CONFIG_HIGHMEM doesn't hurt anything; the only important part is
where you put > 4Gb memory, eg in the NORMAL or HIGH zone. That choice,
while hardcoded in my patch, can obviously be made at runtime based on
capabilities of the machine... (the remaining overhead due to 
kmap is (almost) zero already as the compiler will basically optimize 
the inline away as it's a nop in the context of the users)

Greetings,
   Arjan van de Ven
