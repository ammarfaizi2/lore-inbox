Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUFXKio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUFXKio (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 06:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264211AbUFXKin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 06:38:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35794 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264198AbUFXKim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 06:38:42 -0400
Date: Thu, 24 Jun 2004 06:36:58 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Paul Jackson <pj@sgi.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: using gcc built-ins for bitops?
Message-ID: <20040624103657.GV21264@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040624070936.GB30057@devserv.devel.redhat.com> <20040624023109.6213c1ce.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624023109.6213c1ce.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 02:31:09AM -0700, Paul Jackson wrote:
> I see a list of these gcc bitop builtins at the bottom of the page:
> 
>   http://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html
> 
> Looks like you can find the position of the first 1 bit, the length of
> the leading or trailing seq of 0 bits, the hamming weight (popcount) and
> the parity, each for int, long and long long.
> 
> I just add this for the benefit of others.
> 
> As to your primary question - is this worth doing - I don't have
> an answer.

It is, for 2 reasons:
1) unlike __asm, GCC knows how to schedule the instructions in the builtins
2) GCC will handle stuff like ffz (16) at compile time rather than runtime

But, all the builtins are not natively supported on every architecture,
if there is no arch support, it falls back to a libgcc library function,
which the kernel probably wants to avoid.
E.g. popcount on i386, etc.

	Jakub
