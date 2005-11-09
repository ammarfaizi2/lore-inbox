Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbVKITUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbVKITUw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 14:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbVKITUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 14:20:52 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:33944 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030342AbVKITUv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 14:20:51 -0500
Date: Wed, 9 Nov 2005 13:20:28 -0600
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: "J.A. Magallon" <jamagallon@able.es>, Kyle Moffett <mrmacman_g4@mac.com>,
       Douglas McNaught <doug@mcnaught.org>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc64-dev@ozlabs.org
Subject: Re: typedefs and structs
Message-ID: <20051109192028.GP19593@austin.ibm.com>
References: <20051107204136.GG19593@austin.ibm.com> <1131412273.14381.142.camel@localhost.localdomain> <20051108232327.GA19593@austin.ibm.com> <B68D1F72-F433-4E94-B755-98808482809D@mac.com> <20051109003048.GK19593@austin.ibm.com> <m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local> <20051109004808.GM19593@austin.ibm.com> <19255C96-8B64-4615-A3A7-9E5A850DE398@mac.com> <20051109111640.757f399a@werewolf.auna.net> <Pine.LNX.4.58.0511090816300.4260@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0511090816300.4260@shell2.speakeasy.net>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 08:22:15AM -0800, Vadim Lobanov was heard to remark:
> On Wed, 9 Nov 2005, J.A. Magallon wrote:
> 
> > void do_some_stuff(T& arg1,T&  arg2)
> 
> A diligent C programmer would write this as follows:
> 	void do_some_stuff (struct T * a, struct T * b);
> So I don't see C++ winning at all here.

I guess the real point that I'd wanted to make, and seems
to have gotten lost, was that by avoiding using pointers, 
you end up designing code in a very different way, and you
can find out that often/usually, you don't need structs
filled with a zoo of pointers.

Minimizing pointers is good: less ref counting is needed,
fewer mallocs are needed, fewer locks are needed 
(because of local/private scope!!), and null pointer 
deref errors are less likely. 

There are even performance implications: on modern CPU's
there's a very long pipeline to memory (hundreds of cycles 
for a cache miss! Really! Worse if you have run out of 
TLB entries!). So walking a long linked list chasing 
pointers can really really hurt performance.

By using refs instead of pointers, it helps you focus 
on the issue of "do I really need to store this pointer 
somewhere? Will I really need it later, or can I be done 
with it now?".

I don't know if the idea of "using fewer pointers" can
actually be carried out in the kernel. For starters,
the stack is way too short to be able to put much on it.

--linas


