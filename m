Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282801AbSAHJzL>; Tue, 8 Jan 2002 04:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282482AbSAHJzA>; Tue, 8 Jan 2002 04:55:00 -0500
Received: from [194.206.157.151] ([194.206.157.151]:14212 "EHLO
	iis000.microdata.fr") by vger.kernel.org with ESMTP
	id <S282801AbSAHJyq>; Tue, 8 Jan 2002 04:54:46 -0500
Message-ID: <17B78BDF120BD411B70100500422FC6309E407@IIS000>
From: Bernard Dautrevaux <Dautrevaux@microprocess.com>
To: "'jtv'" <jtv@xs4all.nl>, Bernard Dautrevaux <Dautrevaux@microprocess.com>
Cc: "'dewar@gnat.com'" <dewar@gnat.com>, paulus@samba.org, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: RE: [PATCH] C undefined behavior fix
Date: Tue, 8 Jan 2002 10:44:59 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: jtv [mailto:jtv@xs4all.nl]
> Sent: Monday, January 07, 2002 10:49 PM
> To: Bernard Dautrevaux
> Cc: 'dewar@gnat.com'; paulus@samba.org; gcc@gcc.gnu.org;
> linux-kernel@vger.kernel.org; trini@kernel.crashing.org; 
> velco@fadata.bg
> Subject: Re: [PATCH] C undefined behavior fix
> 
> 
> On Mon, Jan 07, 2002 at 02:24:35PM +0100, Bernard Dautrevaux wrote:
> > 
> > Note however that some may not have noticed, in the 
> volatile-using examples,
> > that there is a difference between a "pointer to volatile 
> char" and a
> > "volatile pointer to char"; the former, defined as 
> "volatile char*" does not
> > help in the case of the RELOC macro, while the latter, written "char
> > *volatile" (note that volatile is now AFTER the '*', not 
> before) is a sure
> > fix as the semantics of "volatile" ensure that the compiler 
> will NO MORE use
> > the value it PREVIOUSLY knows was the one of the pointer. 
> 
> One problem I ran into considering 'char *volatile' was this one: the
> compiler is supposed to disable certain optimizations involving
> registerization and such, but isn't it still allowed to do constant
> folding?  That would eliminate the pointer from the intermediate code
> altogether, and so the volatile qualifier would be quickly 
> forgotten.  
> No fixo breako.
> 
> Nothing's taking the pointer's address, so the compiler 
> _will_ be able 
> to prove that (in a sensible universe) no other thread, interrupt, 
> kernel code or Angered Rain God will be able to find our 
> pointer--much 
> less change it.

NO; the standard here is clear: any access to a volatile object is a side
effect (see , and optimization is NOT allowed to eliminate side effects, and
must do them respecting sequence points, even if it determines that the code
will in fact do nothing (see 5.1.2.3, at least in the document I have which
one of the last draft, dated 18th January 1999). That's the whole point of
the volatile specifier.

	Bernard

--------------------------------------------
Bernard Dautrevaux
Microprocess Ingenierie
97 bis, rue de Colombes
92400 COURBEVOIE
FRANCE
Tel:	+33 (0) 1 47 68 80 80
Fax:	+33 (0) 1 47 88 97 85
e-mail:	dautrevaux@microprocess.com
		b.dautrevaux@usa.net
-------------------------------------------- 
