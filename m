Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264563AbRFOX0H>; Fri, 15 Jun 2001 19:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264568AbRFOXZ4>; Fri, 15 Jun 2001 19:25:56 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:30400 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264563AbRFOXZr>;
	Fri, 15 Jun 2001 19:25:47 -0400
Message-ID: <3B2A9975.D648D55B@mandrakesoft.com>
Date: Fri, 15 Jun 2001 19:25:41 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Smith <eric@brouhaha.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, arjanv@redhat.com, mj@ucw.cz
Subject: Re: 2.4.2 yenta_socket problems on ThinkPad 240
In-Reply-To: <20010615231413.17697.qmail@brouhaha.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Smith wrote:
> 
> On 6-Jun-2001, I reported:
> > I upgraded my IBM ThinkPad 240 (Type 2609-31U) from Red Hat 7.0 to
> > Red Hat 7.1, which uses the 2.4.2 kernel and the kernel PCMCIA drivers.
> > Before the upgrade, all my CardBus and PCMCIA devices were working fine.
> > Now the yenta_socket module seems to be causing problems, and none of
> > the cards work.
> 
> Arjan van de Ven of Red Hat tracked my problem down to a broken BIOS,
> which is not configuring the TI PC1211 CardBus bridge correctly.  Even
> IBM's latest BIOS for the ThinkPad 240, IRET75WW released 17-May-2001,
> has this problem.  Apparently IBM has issued fixes for other ThinkPads
> because the problem occurs with Windows 2000, but since Windows 2000 is
> not supported on the ThinkPad 240, it is unlikely that they will fix it.
> 
> A one line change to linux/include/asm-i386/pci.h fixes it:
> 
> -#define pcibios_assign_all_busses()    0
> +#define pcibios_assign_all_busses()    1
> 
> Given that this macro exists, I surmise that other people have been
> bitten by similar problems.  So now my question is:
> 
> Does it make sense to turn pcibios_assign_all_busses into a variable
> with a default value of zero, and implement a kernel argument to set it?

I believe Alan had mentioned something on IRC about seeing a case where
the CardBus bridge's secondary and subordinate bridge numbers were 1 on
bootup, but 0 after the yenta driver got ahold of it.  So, there is the
potential that the yenta driver is not setting things up quite
correctly.

To answer your question, I wouldn't mind at all having a kernel command
line setting that turned the above into a variable...

I would love to just define it unconditionally for x86, but I believe
Martin said that causes problems with some hardware, and the way the
BIOS has set up that hardware.  (details anyone?)

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
