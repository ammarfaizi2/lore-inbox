Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285091AbRLFJvZ>; Thu, 6 Dec 2001 04:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285086AbRLFJvQ>; Thu, 6 Dec 2001 04:51:16 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:16656 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S285074AbRLFJu6>; Thu, 6 Dec 2001 04:50:58 -0500
Date: Thu, 6 Dec 2001 04:50:41 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "David S. Miller" <davem@redhat.com>, jgarzik@mandrakesoft.com,
        kaos@ocs.com.au, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.16 for pointers to __devexit functions
Message-ID: <20011206045041.F4087@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <20011206.001423.118949508.davem@redhat.com> <11777.1007619756@kao2.melbourne.sgi.com> <3C0F27CA.59C22DEF@mandrakesoft.com> <20011206.001423.118949508.davem@redhat.com> <15133.1007631619@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15133.1007631619@redhat.com>; from dwmw2@infradead.org on Thu, Dec 06, 2001 at 09:40:19AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 09:40:19AM +0000, David Woodhouse wrote:
> 
> davem@redhat.com said:
> > >    Why not __attribute__((weak)) ?
> > This doesn't work on all platforms unfortunately :( 
> 
> Doesn't work at all, or just doesn't work with the (current) minimum
> recommended compiler? We have to increase those minima at some point. 

Actually, I think all GCCs will error on it, or at least should.
Most of the __devexit routines are static, you get something like:
test.c:2: weak declaration of `foo' must be public

It is very weird thing to have a non-public weak, and assemblers will do
weird things if you tweak it in assembly output.

	Jakub
