Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289200AbSAGNjV>; Mon, 7 Jan 2002 08:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289208AbSAGNjJ>; Mon, 7 Jan 2002 08:39:09 -0500
Received: from [194.206.157.151] ([194.206.157.151]:45925 "EHLO
	iis000.microdata.fr") by vger.kernel.org with ESMTP
	id <S289215AbSAGNiD>; Mon, 7 Jan 2002 08:38:03 -0500
Message-ID: <17B78BDF120BD411B70100500422FC6309E403@IIS000>
From: Bernard Dautrevaux <Dautrevaux@microprocess.com>
To: "'Laurent Guerby'" <guerby@acm.org>, dewar@gnat.com
Cc: paulus@samba.org, gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
        trini@kernel.crashing.org, velco@fadata.bg
Subject: RE: [PATCH] C undefined behavior fix
Date: Mon, 7 Jan 2002 14:29:15 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Laurent Guerby [mailto:guerby@acm.org]
> Sent: Sunday, January 06, 2002 2:41 PM
> To: dewar@gnat.com
> Cc: paulus@samba.org; gcc@gcc.gnu.org; linux-kernel@vger.kernel.org;
> trini@kernel.crashing.org; velco@fadata.bg
> Subject: Re: [PATCH] C undefined behavior fix
> 
> 
> dewar@gnat.com wrote:
> 
> > pragma Atomic in Ada (volatile gets close in C, but is not 
> close enough) will
> > ensure a byte store in practice, but may not ensure byte reads.
> 
> 
> I see no distinction between read and write in the text of 
> the Ada standard.
> 
> Also I think if you declare a byte array with Atomic_Component
> and Volatile_Component and that the compiler accepts it for its
> target architecture, then the compiler is required to generate
> a byte read and store for each occurence in the text source.
>  From C.6:
> 
> 15    For an atomic object (including an atomic component) 
> all reads and
> updates of the object as a whole are indivisible.
> 
> 16    For a volatile object all reads and updates of the object as a 
> whole are
> performed directly to memory.
> 
> 20    {external effect (volatile/atomic objects) [partial]} 
> The external
> effect of a program (see 1.1.3) is defined to include each read and 
> update of
> a volatile or atomic object. The implementation shall not 
> generate any 
> memory
> reads or updates of atomic or volatile objects other than 
> those specified by
> the program.
> 
> In my exemple byte array, if I say X := T (I) I don't see how 
> a conformant
> compiler accepting the declaration could generate anything other than
> one and exactly one byte read. Per 20 it has no right to read 
> T (I+1) or 
> T(I-1)
> since they are "other" objects (components to be pedantic).

It seems to me that you are right, but there is other cases; for example:
	X := T(0)*256 + T(1);
compiled on a big endian architecture may well generate just one 16-bit word
read... 

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
