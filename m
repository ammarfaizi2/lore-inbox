Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319373AbSHVPrG>; Thu, 22 Aug 2002 11:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319375AbSHVPrF>; Thu, 22 Aug 2002 11:47:05 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:28406 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S319373AbSHVPrF>; Thu, 22 Aug 2002 11:47:05 -0400
Date: Thu, 22 Aug 2002 11:51:14 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk simultaneous oops disentangling
Message-ID: <20020822115114.B16763@redhat.com>
References: <12669.1030018158@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <12669.1030018158@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Thu, Aug 22, 2002 at 01:09:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2002 at 01:09:18PM +0100, David Howells wrote:
> Hi Linus,
> 
> Here's a patch to stop multiple simultaneous oopses on an SMP system from
> interleaving with and overwriting bits of each other. It only permits lock
> breaking if the printk lock is held by the same CPU.

This is still wrong.  It should attempt to acquire the locks with a timeout 
before trampling on them, as there may be a printk or other console output 
in progress on the other cpu.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
