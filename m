Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQLTUA5>; Wed, 20 Dec 2000 15:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129819AbQLTUAr>; Wed, 20 Dec 2000 15:00:47 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:55058 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129352AbQLTUAa>;
	Wed, 20 Dec 2000 15:00:30 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Date: Wed, 20 Dec 2000 20:29:13 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Startup IPI (was: Re: test13-pre3)
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@chiara.elte.hu
X-mailer: Pegasus Mail v3.40
Message-ID: <103B2E14508A@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Dec 00 at 19:52, Maciej W. Rozycki wrote:
> > it kills machine; only problem is that 0x1300 wr-rd cycles to VGA apperture
> > take 3.48ms, and this does not correspond with needed 200us udelay.
> 
>  Hmm, how do you calculate the time?  Assuming AGP4x runs at 133MHz and a
> read or write cycle lasts for a single clock tick (I don't know exact AGP
> specs -- please correct me if I'm wrong), I find 0x1300 cycles to finish
> in about 73usecs.  The loop execution overhead may double the result and
> it will still fit within 300usecs. 

It is easy:
  int mfd;
  volatile unsigned long* memory;
  int i;
  
  mfd = open("/dev/mem", O_RDWR);
  memory = mmap(0, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, mfd, 0x000B8000);
  close(mfd); 
  for (i = 0; i < 0x1300 * 1000; i++) {
    *memory = i;
    *memory;
  }
  munmap(memory, 4096);

/usr/bin/time says that program runs for 3.40 - 3.56secs, so after dividing
by 1000 I get 3.4ms... Maybe I should complain to VIA or to Matrox that
it is piece of crap ?
  
> > Without VIA datasheet I cannot try to disable some PCI features to find
> > which one is culprit, so I'm sorry.
> 
>  But you may complain to the manufacturer and/or change hardware.  I'm
> still uncertain the delay should stay in...

My order was simple: no rambus memory, dual PIII at least on 800MHz
and UDMA66. Yes, maybe I should buy ServerWorks instead of VIA, but 
I hoped...
                                                    Best regards,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                        
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
