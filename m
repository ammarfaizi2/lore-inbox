Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbTH3Lb6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 07:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbTH3Lb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 07:31:58 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:33672 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261393AbTH3Lbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 07:31:43 -0400
Date: Sat, 30 Aug 2003 12:31:28 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Antonio Vargas <wind@cocodriloo.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] gcc3 warns about type-punned pointers ?
Message-ID: <20030830113128.GA18793@mail.jlokier.co.uk>
References: <20030828223511.GA23528@werewolf.able.es> <20030829152418.GB709@wind.cocodriloo.com> <20030829184847.GA2069@werewolf.able.es> <Pine.LNX.4.53.0308291517001.32044@chaos> <20030830062744.GE640@wind.cocodriloo.com> <20030830095625.GN734@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030830095625.GN734@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Sat, Aug 30, 2003 at 08:27:44AM +0200, Antonio Vargas wrote:
> > That was my fault for introducing an exchange instruction
> > into an assignement discussion, but I don't know of any
> > x86 instruction which can load 64bits to memory atomically,
> > is there any???
> 
> perhaps "pusha", but it will load fare more than you need, and I don't know
> if it's lockable.

"pusha" does not promise 64 bit writes.  It can't be interrupted, but
I see nothing that ensures the multiple 32 bit words are combined into
atomic 64 bit writes as seen by other CPUs or peripherals.

> Some MMX instruction might do it too, although not sure.

Yes, if you want a 64 bit write and don't want to use cmpxchg8b, MMX
will do it.

You can also do it with the floating-point "fistpll" instruction (also
called "fistpq").

-- Jamie
