Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbSKRPcS>; Mon, 18 Nov 2002 10:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262813AbSKRPcS>; Mon, 18 Nov 2002 10:32:18 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:4606 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262812AbSKRPcS>; Mon, 18 Nov 2002 10:32:18 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20021118161750.A32042@wotan.suse.de> 
References: <20021118161750.A32042@wotan.suse.de>  <3DD3FCB3.40506@us.ibm.com> <14814.1037632523@passion.cambridge.redhat.com> 
To: Andi Kleen <ak@suse.de>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] early printk for x86 
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Mon, 18 Nov 2002 15:39:12 +0000
Message-ID: <16835.1037633952@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ak@suse.de said:
>  The generic serial driver needs lots of infrastructure that is not
> present in early boot. Also the early_printk serial driver is polled,
> not interrupt driven.

No, the generic serial _console_ is polled and should require no more 
infrastructure than the early_console version which it strongly resembles.

After all, it's generally called from console_init(), at which point 
there's little more infrastructure available than in setup_arch() _anyway_.

You should happily be able to call serial8250_console_init() earlier then
console_init() currently does.

(Btw, if you're playing with this code I posted a cleanup to all the 
horrible #ifdefs in console_init, converting it to the __initcall mechanism.
http://marc.theaimsgroup.com/?l=linux-kernel&m=103660078206270&w=2 )

--
dwmw2

