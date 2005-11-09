Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbVKIVnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbVKIVnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030780AbVKIVnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:43:13 -0500
Received: from mail27.sea5.speakeasy.net ([69.17.117.29]:14524 "EHLO
	mail27.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030331AbVKIVnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:43:11 -0500
Date: Wed, 9 Nov 2005 13:43:10 -0800 (PST)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: linas <linas@austin.ibm.com>
cc: "J.A. Magallon" <jamagallon@able.es>, Kyle Moffett <mrmacman_g4@mac.com>,
       Douglas McNaught <doug@mcnaught.org>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc64-dev@ozlabs.org
Subject: Re: typedefs and structs
In-Reply-To: <20051109192028.GP19593@austin.ibm.com>
Message-ID: <Pine.LNX.4.58.0511091339090.31338@shell3.speakeasy.net>
References: <20051107204136.GG19593@austin.ibm.com>
 <1131412273.14381.142.camel@localhost.localdomain> <20051108232327.GA19593@austin.ibm.com>
 <B68D1F72-F433-4E94-B755-98808482809D@mac.com> <20051109003048.GK19593@austin.ibm.com>
 <m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local> <20051109004808.GM19593@austin.ibm.com>
 <19255C96-8B64-4615-A3A7-9E5A850DE398@mac.com> <20051109111640.757f399a@werewolf.auna.net>
 <Pine.LNX.4.58.0511090816300.4260@shell2.speakeasy.net>
 <20051109192028.GP19593@austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2005, linas wrote:

> On Wed, Nov 09, 2005 at 08:22:15AM -0800, Vadim Lobanov was heard to remark:
> > On Wed, 9 Nov 2005, J.A. Magallon wrote:
> >
> > > void do_some_stuff(T& arg1,T&  arg2)
> >
> > A diligent C programmer would write this as follows:
> > 	void do_some_stuff (struct T * a, struct T * b);
> > So I don't see C++ winning at all here.
>
> I guess the real point that I'd wanted to make, and seems
> to have gotten lost, was that by avoiding using pointers,
> you end up designing code in a very different way, and you
> can find out that often/usually, you don't need structs
> filled with a zoo of pointers.
>
> Minimizing pointers is good: less ref counting is needed,
> fewer mallocs are needed, fewer locks are needed
> (because of local/private scope!!), and null pointer
> deref errors are less likely.
>
> There are even performance implications: on modern CPU's
> there's a very long pipeline to memory (hundreds of cycles
> for a cache miss! Really! Worse if you have run out of
> TLB entries!). So walking a long linked list chasing
> pointers can really really hurt performance.
>
> By using refs instead of pointers, it helps you focus
> on the issue of "do I really need to store this pointer
> somewhere? Will I really need it later, or can I be done
> with it now?".
>
> I don't know if the idea of "using fewer pointers" can
> actually be carried out in the kernel. For starters,
> the stack is way too short to be able to put much on it.

I really see the two issues at hand as being very much orthogonal to
each other.

Namely, you put data on the stack when you need it in the local
'context' only, whereas you put data globally when it needs to be
available globally. The C++ references are nothing more than syntactic
sugar (and we all know what they say about that and semicolons) for
pointers, and so I don't see how they would affect the choices at all.
Choosing where the data goes should be done according to the data's
lifetime, not the specifics of how functions are declared.

</soapbox>

> --linas
>
>

-Vadim Lobanov
