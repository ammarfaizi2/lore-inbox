Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030768AbWKORwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030768AbWKORwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030766AbWKORwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:52:31 -0500
Received: from gw.goop.org ([64.81.55.164]:37260 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030768AbWKORwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:52:30 -0500
Message-ID: <455B53DD.1030305@goop.org>
Date: Wed, 15 Nov 2006 09:52:29 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: akpm@osdl.org, Arjan van de Ven <arjan@infradead.org>, ak@suse.de,
       mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386-pda UP optimization
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <4506665D.2090001@goop.org> <1158047806.2992.7.camel@laptopd505.fenrus.org> <200611151227.04777.dada1@cosmosbay.com>
In-Reply-To: <200611151227.04777.dada1@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> I wish Jeremy give us patches for UP machines so that %gs can be let untouched 
> in entry.S (syscall entry/exit). A lot of ia32 machines are still using one 
> CPU.
>   
Unfortunately that would add cruft in a number of places.  At the
moment, context switch, ptrace and vm86 all assume entry.S has saved %gs
into pt_regs, so they can treat it like any other register.  If this
were conditional, it would require multiple places to add #ifndef
CONFIG_SMP code, which is not something I'd like to do without a good
reason.

    J
