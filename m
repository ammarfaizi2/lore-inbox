Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267244AbTBUIgB>; Fri, 21 Feb 2003 03:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267245AbTBUIgB>; Fri, 21 Feb 2003 03:36:01 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:60164 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267244AbTBUIgA>; Fri, 21 Feb 2003 03:36:00 -0500
Date: Fri, 21 Feb 2003 08:45:43 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       "David S. Miller" <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family
Message-ID: <20030221084543.A25765@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	"David S. Miller" <davem@redhat.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Jean Tourrilhes <jt@bougret.hpl.hp.com>,
	linux-kernel@vger.kernel.org
References: <Your <5.1.0.14.2.20030220092216.0d3fefd0@mail1.qualcomm.com> <20030221004041.05C1F2C2D5@lists.samba.org> <5.1.0.14.2.20030220165016.0d47c688@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5.1.0.14.2.20030220165016.0d47c688@mail1.qualcomm.com>; from maxk@qualcomm.com on Thu, Feb 20, 2003 at 05:17:52PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 05:17:52PM -0800, Max Krasnyansky wrote:
> Yeah, I think 'try' is definitely be a misnomer in this case.
> How about something like this ?
> 
> static inline void __module_get(struct module *mod)
> {
> #ifdef CONFIG_MODULE_DETECT_API_VIOLATION
>         if (!module_refcount(mod))
>                 __unsafe(mod);
> #endif
>         local_inc(&mod->ref[get_cpu()].count);
>         put_cpu();
> }
> 
> We will be able to compile the kernel with CONFIG_MODULE_DETECT_API_VIOLATION
> and easily find all modules that call __module_get() without holding a reference.

Drop the ifdef, add and add an unlikely instead?

