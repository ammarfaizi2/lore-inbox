Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbTJZCej (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 22:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTJZCej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 22:34:39 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:36980 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262784AbTJZCeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 22:34:36 -0400
From: xcytame <xcytame@yahoo.es>
Reply-To: xcytame@yahoo.es
To: Martin Willemoes Hansen <mwh@sysrq.dk>
Subject: Re: Airo Net 340 PCMCIA WiFi Card trouble
Date: Sun, 26 Oct 2003 03:34:31 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <1062498150.356.9.camel@spiril.sysrq.dk> <3F55FC69.7050404@terra.es> <1067096661.214.35.camel@hugoboss.sysrq.dk>
In-Reply-To: <1067096661.214.35.camel@hugoboss.sysrq.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310260334.31185.xcytame@yahoo.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, we had some advance :-)

I have really no clue about what can cause your system getting no interrupt 
free for pcmcia. 

>>airo: register interrupt 0 failed, rc -16

Googling for "pcmcia-cs register interrupt 0 failed" i found this:
http://www.linuxquestions.org/questions/archive/3/2003/07/4/48965 where it 
points to a ISA related issue.

>Possable sollution.
>
>I had a similar problem.
>
>It seems the Aironet cards is 16bit (not Cardbus) you must sellect ISA 
>support in the kernel for the cards to be recognized.
>(Under General setup)
>
>Hope it helps.
>
>Regards,
>Pieter

If it does not help you, i  can only point you to the pcmcia-cs documentation 
about interrupts at

 http://pcmcia-cs.sourceforge.net/ftp/doc/PCMCIA-HOWTO-5.html#ss5.2

hope it helps. ( tell us please :-)  )

On Saturday 25 October 2003 17:44, Martin Willemoes Hansen wrote:
> On Wed, 2003-09-03 at 16:36, tonildg wrote:
> > >> I solved it testing with memory ranges in the config.opts file that
> > >>comes with your pcmcia_cs version.
> > >>
> > >>   You have to play with them until one fits and boots. "I had to use
> > >>windows to see the memory adresses my cardbus used."
> >
> > < Umh can I check it out on Linux as well? And how? I can boot correctly
> >
> > > with 2.4.19.
> >
> >   I had to look to the windows cardbus device properties to get it work,
> > but i think that by playing with some values you can get it working too
> > without needing that crappy OS.
>
> Hmm after changing the memory address I seem to get a new problem :(
> Hope you can point me in the right direction.
>
> Settings in config.opts
> I changed the first include memory
> to the address I found in win98
> ----------------------------------
>
> # System resources available for PCMCIA devices
>
> include port 0x100-0x4ff, port 0x800-0x8ff, port 0xc00-0xcff
> include memory 0xc0030000-0xc003ffff
> include memory 0xa0000000-0xa0ffffff, memory 0x60000000-0x60ffffff
>
> # High port numbers do not always work...
> # include port 0x1000-0x17ff
>
> # Extra port range for IBM Token Ring
> include port 0xa00-0xaff
>
> # Resources we should not use, even if they appear to be available
>
> # First built-in serial port
> exclude irq 4
> # Second built-in serial port
> #exclude irq 3
> # First built-in parallel port
> exclude irq 7
>
> =====================================================================
>
> dmesg from: 2.4.19 (everything is okay here :o))
> ----------------------------------------------------------------
>
> cs: IO port probe 0x0c00-0x0cff: clean.
> cs: IO port probe 0x0800-0x08ff: clean.
> cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x398-0x39f
> 0x4d0-0x4d7
> cs: IO port probe 0x0a00-0x0aff: clean.
> cs: memory probe 0xc0030000-0xc003ffff: clean.
> airo:  Probing for PCI adapters
> airo:  Finished probing for PCI adapters
> airo: Doing fast bap_reads
> airo: MAC enabled eth0 0:40:96:45:75:51
> eth0: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
>
> dmesg from: 2.4.22 (seems like IO port probe is missing here)
> ---------------------------------------------------------------------------
>-------
>
> cs: memory probe 0x60000000-0x60ffffff: clean.
> airo:  Probing for PCI adapters
> airo:  Finished probing for PCI adapters
> airo: register interrupt 0 failed, rc -16
> airo_cs: RequestConfiguration: Operation succeeded
>
>
> Anyone have an idea of what I might do to get the card going in 2.4.22?

