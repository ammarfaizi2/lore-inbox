Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289243AbSAVL3m>; Tue, 22 Jan 2002 06:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289273AbSAVL3c>; Tue, 22 Jan 2002 06:29:32 -0500
Received: from ns.suse.de ([213.95.15.193]:65289 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289243AbSAVL3L>;
	Tue, 22 Jan 2002 06:29:11 -0500
Date: Tue, 22 Jan 2002 12:29:00 +0100
From: Karsten Keil <kkeil@suse.de>
To: Armin Schindler <mac@melware.de>
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: missing memset in divas and eicon in 2.2.20
Message-ID: <20020122122900.B17822@pingi.kke.suse.de>
Mail-Followup-To: Armin Schindler <mac@melware.de>,
	"Peter T. Breuer" <ptb@it.uc3m.es>,
	linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200201212336.g0LNa9b25643@oboe.it.uc3m.es> <Pine.LNX.4.31.0201221017280.21391-100000@phoenix.one.melware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.31.0201221017280.21391-100000@phoenix.one.melware.de>; from mac@melware.de on Tue, Jan 22, 2002 at 10:19:15AM +0100
Organization: SuSE Muenchen GmbH
X-Operating-System: Linux 2.2.18-SMP i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 10:19:15AM +0100, Armin Schindler wrote:
> Did you use plain 2.2.20 ?
> I cannot reproduce this problem here, can you please send me your
> kernel config.
> 

It may be also a compiler related problem, so the version of the compiler is
also important. Some newer gcc don't inline memcpy/memset if complete
structures or arrays are assigned. For example:

char x[4] = {0,};

result in a memset, if here is no define of memset in any header it will
give an undefined symbol. Earlier gcc use buildin inline versions of memset
for this. Its a long discussion with gcc people, what is is the correct way
( I don't know the end of this discussion).


> Thanx,
> Armin
> 
> On Tue, 22 Jan 2002, Peter T. Breuer wrote:
> >   betty:/usr/local/src/linux-2.2.20% sudo depmod -ae -F System.map 2.2.20-SMP
> >   depmod: *** Unresolved symbols in
> >   /lib/modules/2.2.20-SMP/misc/divas.o depmod:         memset
> >   depmod: *** Unresolved symbols in
> >   /lib/modules/2.2.20-SMP/misc/eicon.o depmod:         memset
> >
> > Both compiled as modules, SMP kernel, i686 compile.  No, I didn't make a
> > patch - I was too busy fighting with sct's patch for ext3, which is also
> > slightly toasted in the deendencies department when compiled as a
> > module.
> >
> > I don't know why these are missing memset. Of course memset is in the
> > kernel and nobody else misses it one bit! Yes, they do include at least
> > some header that incorporates memset (from linux/strings.h? Or in
> > asm-i386?), because I tried copying an inline memset.h definition into
> > their header files, and it produced a typical compiler error ("error
> > before '?' .." sic) from a memset macro clash. One of the component
> > sources of divas.o and eicon.o must be missing an #include
> > <asm/strings.h>.
> >
> > Your mission is to find and eliminate that missing include.
> >
> > Good luck.
> >
> >
> > ---------------------------------------------------------------------
> > Peter T. Breuer                   MA CASM PhD (Ing.), Prof. Asoc.
> > Area de Ingenieria Telematica	  E-mail: ptb@it.uc3m.es
> > Dpto. Ingenieria		  Tel: +34 (9)1 624 87 81
> > Universidad Carlos III de Madrid  Fax: +34 (9)1 624 8749/9430
> > Butarque 15, Leganes/Madrid       URL: http://www.it.uc3m.es/~ptb
> > E-28911 Spain                     Mob: +34 69 666 7835
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> 
> - - -   - - -   - - -   - - -
> Cytronics & Melware
> Weinbergstrasse 39
> 55296 Loerzweiler / Germany
> Tel: +49 6138 98110-0
> Fax: +49 6138 98110-9
> mailto:info@melware.de
> http://www.melware.de
> - - -   - - -   - - -   - - -
> 

-- 
Karsten Keil
SuSE Labs
ISDN development
