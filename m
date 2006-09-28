Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965310AbWI1LEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965310AbWI1LEt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 07:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965312AbWI1LEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 07:04:49 -0400
Received: from [212.227.126.177] ([212.227.126.177]:23793 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965310AbWI1LEs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 07:04:48 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bernd Schmidt <bernds_cb1@t-online.de>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Date: Thu, 28 Sep 2006 13:04:30 +0200
User-Agent: KMail/1.9.4
Cc: Robin Getz <rgetz@blackfin.uclinux.org>, luke Yang <luke.adi@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <6.1.1.1.0.20060927121508.01ecea90@ptg1.spd.analog.com> <200609272257.02385.arnd@arndb.de> <451B9675.8070406@t-online.de>
In-Reply-To: <451B9675.8070406@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609281304.31872.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 September 2006 11:31, Bernd Schmidt wrote:
> > 
> > That completely avoids all the problems you might hit with macro expansion,
> > while still compiling to the same code.
> 
> The operand is an input, not an output. 

ok, my fault.

> We want to restore the proper  
> mask of enabled interrupts with the STI.  That mask is in the global 
> irq_flags variable (which probably ought to have a different name that 
> doesn't invite clashes).

Shouldn't you just use a constant expression here? A global variable
for it sounds rather strange, especially since the local_irq_disable()
calls are sometimes nested, not to mention the problems you'd hit on
SMP?

	Arnd <><
