Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282845AbSAUXgn>; Mon, 21 Jan 2002 18:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288928AbSAUXgd>; Mon, 21 Jan 2002 18:36:33 -0500
Received: from smtp02.uc3m.es ([163.117.136.122]:34318 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S282845AbSAUXgW>;
	Mon, 21 Jan 2002 18:36:22 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200201212336.g0LNa9b25643@oboe.it.uc3m.es>
Subject: missing memset in divas and eicon in 2.2.20
To: kkeil@suse.de, mac@melware.de
Date: Tue, 22 Jan 2002 00:36:09 +0100 (MET)
Cc: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  betty:/usr/local/src/linux-2.2.20% sudo depmod -ae -F System.map 2.2.20-SMP
  depmod: *** Unresolved symbols in
  /lib/modules/2.2.20-SMP/misc/divas.o depmod:         memset
  depmod: *** Unresolved symbols in
  /lib/modules/2.2.20-SMP/misc/eicon.o depmod:         memset

Both compiled as modules, SMP kernel, i686 compile.  No, I didn't make a
patch - I was too busy fighting with sct's patch for ext3, which is also
slightly toasted in the deendencies department when compiled as a
module.

I don't know why these are missing memset. Of course memset is in the
kernel and nobody else misses it one bit! Yes, they do include at least
some header that incorporates memset (from linux/strings.h? Or in
asm-i386?), because I tried copying an inline memset.h definition into
their header files, and it produced a typical compiler error ("error
before '?' .." sic) from a memset macro clash. One of the component
sources of divas.o and eicon.o must be missing an #include
<asm/strings.h>.

Your mission is to find and eliminate that missing include.

Good luck.


---------------------------------------------------------------------
Peter T. Breuer                   MA CASM PhD (Ing.), Prof. Asoc.
Area de Ingenieria Telematica	  E-mail: ptb@it.uc3m.es
Dpto. Ingenieria		  Tel: +34 (9)1 624 87 81
Universidad Carlos III de Madrid  Fax: +34 (9)1 624 8749/9430
Butarque 15, Leganes/Madrid       URL: http://www.it.uc3m.es/~ptb
E-28911 Spain                     Mob: +34 69 666 7835
