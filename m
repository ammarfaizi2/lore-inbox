Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265044AbSKAPQM>; Fri, 1 Nov 2002 10:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265045AbSKAPQM>; Fri, 1 Nov 2002 10:16:12 -0500
Received: from ns.suse.de ([213.95.15.193]:51972 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265044AbSKAPQL>;
	Fri, 1 Nov 2002 10:16:11 -0500
Date: Fri, 1 Nov 2002 16:22:22 +0100
From: Andi Kleen <ak@suse.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Need help with FPU/MMX/SSE state save/restore
Message-ID: <20021101162222.A15011@wotan.suse.de>
References: <200211011433.gA1EXBp20882@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211011433.gA1EXBp20882@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does it have anything to do with the fact I'm
> using this code from csum_partial[_copy_generic] ?

You cannot use kernel_fpu_begin in interrupt context,
and the csum copy functions can be called from that in some 
cases (e.g. TCP retransmit timer). You need to check for 
in_interrupt() too.

I think the problem in your case is that you don't save/restore
your registers properly around the function call. C calling
conventions allow to clobber some of them and you don't seem
to handle that.

-Andi
