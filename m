Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132823AbRC2UBQ>; Thu, 29 Mar 2001 15:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132828AbRC2UA5>; Thu, 29 Mar 2001 15:00:57 -0500
Received: from malcolm.ailis.de ([62.159.58.30]:48395 "HELO malcolm.ailis.de")
	by vger.kernel.org with SMTP id <S132823AbRC2UAv>;
	Thu, 29 Mar 2001 15:00:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Klaus Reimer <k@ailis.de>
Organization: Ailis
To: Bill Nottingham <notting@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: opl3sa2 in 2.4.2 on Toshiba Tecra 8000
Date: Thu, 29 Mar 2001 21:57:12 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <01032910124007.00454@neo> <20010329133927.A9950@devserv.devel.redhat.com> <01032921132002.00483@neo>
In-Reply-To: <01032921132002.00483@neo>
MIME-Version: 1.0
Message-Id: <01032921571206.00483@neo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > Hm, OK, then never mind. :) I don't have an opl3sa2 here to test
> > how well the current driver works.
> I have the feeling that there is going something wrong with the parameters.
> I modified the opl3sa2 driver and manually set the hw_config->io_base
> variable to 0x538 and now THIS part of the sound card initialization is
> working. But now it says that there is an I/O conflict with MSS. Maybe this
> parameter is also 0x0 and not  0x530 as I specified with the mss_io
> parameter... I will investigate further...

Hm... I found this somewhere near line 920 in opl3sa2.c. I am not a kernel 
hacker and this is first time I took a look into a kernel source code but 
this first "if" statement is not looking right to me. The initialization of 
the cfg[card] struct is what I need to be executed, but it is never executed 
because the variable "io" is never -1. I have removed the io == -1 condition 
from the first if-statement and now the driver is working. But it's still not 
the same quality as the one in kernel 2.2.17: I have no access to the mixer 
settings "bass" and "treble". But better than nothing and better than the 
8Bit-Soundblaster emulation. I hope this is working better in the next 
release.

                if(!isapnp && io == -1 ) {
                        if(io == -1 || irq == -1 || dma == -1 ||
                           dma2 == -1 || mss_io == -1) {
                                printk(KERN_ERR
                                       "opl3sa2: io, mss_io, irq, dma,  [...]
                                return -EINVAL;
                        }
 
                        cfg[card].io_base = io;
                        cfg[card].irq     = 0;
                        cfg[card].dma     = -1;
                        cfg[card].dma2    = -1;
                        [....]

-- 
Bye, K
[a735 47ec d87b 1f15 c1e9 53d3 aa03 6173 a723 e391]
(Finger k@ailis.de to get public key)
