Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSG3UDR>; Tue, 30 Jul 2002 16:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSG3UDR>; Tue, 30 Jul 2002 16:03:17 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:63464 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316322AbSG3UDQ>; Tue, 30 Jul 2002 16:03:16 -0400
Date: Tue, 30 Jul 2002 16:06:31 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sanitize TLS API
Message-ID: <20020730160631.R1596@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20020730174336.A18385@lst.de> <Pine.LNX.4.44.0207302059060.22902-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207302059060.22902-100000@localhost.localdomain>; from mingo@elte.hu on Tue, Jul 30, 2002 at 09:00:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 09:00:09PM +0200, Ingo Molnar wrote:
> 
> On Tue, 30 Jul 2002, Christoph Hellwig wrote:
> 
> > Currently sys_set_thread_area has a magic flags argument that might
> > change it's behaivour completly.
> > 
> > Split out the TLS_FLAG_CLEAR case that has nothing in common with the
> > rest into it's own syscall, sys_clear_thread_area and change the second
> > argument to int writable.
> 
> i did not feel like wasting two syscall slots for this, but the cleanups
> look fine to me otherwise.

Actually, is the clear operation really necessary?
IMHO the best clear is movw $0x03, %gs, then all accesses through %gs will
trap. Calling set_thread_area (0, 1); will result in 0xb segment
acting exactly like %ds or %es.

	Jakub
