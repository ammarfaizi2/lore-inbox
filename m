Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318164AbSGWSYa>; Tue, 23 Jul 2002 14:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318166AbSGWSY3>; Tue, 23 Jul 2002 14:24:29 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:25349 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S318164AbSGWSY3>; Tue, 23 Jul 2002 14:24:29 -0400
Date: Tue, 23 Jul 2002 19:27:26 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: "Isabelle, Francois" <Francois.Isabelle@ca.kontron.com>
Cc: "Linux-Ha (E-mail)" <linux-ha@muc.de>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Handling NMI in a kernel module
Message-ID: <20020723182726.GA92574@compsoc.man.ac.uk>
References: <5009AD9521A8D41198EE00805F85F18F219A7E@sembo111.teknor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5009AD9521A8D41198EE00805F85F18F219A7E@sembo111.teknor.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Boards of Canada - Geogaddi
X-Scanner: exiscan *17X4Nf-000GWb-00*Ig6oZlleF8Y* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 01:37:01PM -0400, Isabelle, Francois wrote:

> Is it possible to request_nmi() the way you can request_irq() from a kernel
> driver on the i386 arch?

Not currently, no.

> Our hardware watchdog is dual stage and can generate NMI on first stage ,
> our cPCI handle switch can also be used for Hot swap request via NMI.
> I'ld like to make use of this, I noticed cpqhealth module already
> implemented some nmi handling but this driver is close sourced.

You can do some horrible hack with sidt + _set_gate() to replace the NMI trap handler.

> Should we patch in i386/kernel/traps.c to add a callback to our stuff in
> unkown_nmi_error().
> 
> I'ld like my driver to register a callback there, what about maintaining a
> list of user callback functions which could be registered via:
>  
> request_nmi(int option, void (*hander)(void *dev_id, struct pt_regs *regs),
> unsigned long flags, const char *dev_name, void *dev_id);
> 
> where option could take meaning such as
>  - prepend   : place at start of nmi callback functions
>  - append    : place at end of nmi callback functions 
>  - truncate : replace callback chain

Why all three ? When would anything other than prepend be useful ? Each
handler must simply see if the NMI is their responsibility, and pass its
duty along to the next handler if not.

What is the purpose of dev_name, dev_id, and flags exactly ?
 
Personally, I'd like to see such a patch.

regards
john

-- 
"If you cannot convince them, confuse them."
	- Harry S. Truman
