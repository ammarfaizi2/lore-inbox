Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287193AbSAGVtm>; Mon, 7 Jan 2002 16:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287196AbSAGVtd>; Mon, 7 Jan 2002 16:49:33 -0500
Received: from mxzilla3.xs4all.nl ([194.109.6.49]:43537 "EHLO
	mxzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S287193AbSAGVtW>; Mon, 7 Jan 2002 16:49:22 -0500
Date: Mon, 7 Jan 2002 22:49:07 +0100
From: jtv <jtv@xs4all.nl>
To: Bernard Dautrevaux <Dautrevaux@microprocess.com>
Cc: "'dewar@gnat.com'" <dewar@gnat.com>, paulus@samba.org, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020107224907.D8157@xs4all.nl>
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E402@IIS000>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E402@IIS000>; from Dautrevaux@microprocess.com on Mon, Jan 07, 2002 at 02:24:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 02:24:35PM +0100, Bernard Dautrevaux wrote:
> 
> Note however that some may not have noticed, in the volatile-using examples,
> that there is a difference between a "pointer to volatile char" and a
> "volatile pointer to char"; the former, defined as "volatile char*" does not
> help in the case of the RELOC macro, while the latter, written "char
> *volatile" (note that volatile is now AFTER the '*', not before) is a sure
> fix as the semantics of "volatile" ensure that the compiler will NO MORE use
> the value it PREVIOUSLY knows was the one of the pointer. 

One problem I ran into considering 'char *volatile' was this one: the
compiler is supposed to disable certain optimizations involving
registerization and such, but isn't it still allowed to do constant
folding?  That would eliminate the pointer from the intermediate code
altogether, and so the volatile qualifier would be quickly forgotten.  
No fixo breako.

Nothing's taking the pointer's address, so the compiler _will_ be able 
to prove that (in a sensible universe) no other thread, interrupt, 
kernel code or Angered Rain God will be able to find our pointer--much 
less change it.


Jeroen

