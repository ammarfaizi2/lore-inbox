Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273170AbRIPHZS>; Sun, 16 Sep 2001 03:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273172AbRIPHZJ>; Sun, 16 Sep 2001 03:25:09 -0400
Received: from elin.scali.no ([62.70.89.10]:26375 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S273170AbRIPHZB>;
	Sun, 16 Sep 2001 03:25:01 -0400
Message-ID: <3BA4530D.A3378F41@scali.no>
Date: Sun, 16 Sep 2001 09:21:49 +0200
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org, VDA@port.imtp.ilyichevsk.odessa.ua,
        alan@lxorguk.ukuu.org.uk
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
In-Reply-To: <1292125035.20010914214303@port.imtp.ilyichevsk.odessa.ua> <E15i2Bp-00017m-00@the-village.bc.nu> <20010916035207.C7542@ppc.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> 
> > +static void __init pci_fixup_athlon_bug(struct pci_dev *d)
> > +{
> > +       u8 v;
> > +       pci_read_config_byte(d, 0x55, &v);
> > +       if(v & 0x80) {
> > +               printk(KERN_NOTICE "Stomping on Athlon bug.\n");
> > +               v &= 0x7f; /* clear bit 55.7 */
> > +               pci_write_config_byte(d, 0x55, v);
> > +       }
> > +}
> >
> > Well, these are cosmetic changes anyway...
> > What is more important now:
> > 1) Do we have people who still see Athlon bug with the patch?
> 
> Just by any chance - does anybody have KT133 (not KT133A)
> datasheet? I just noticed at home that my KT133 has reg 55 set
> to 0x89 and it happilly lives... So maybe some BIOS vendors
> used KT133 instead of KT133A BIOS image?

Hmm, I have a "KT133 Athlon Norbridge, Preliminary Revision 1.0 May 12, 2000"
PDF. Register 55 is described like this :

Device 0 Offset 55  Debug .............................................. RW
	7-5	Reserved (do not program)...................... default = 0
	4	Write Policy for CPU Write to DRAM
		0	Issue DRAM write when FIFO holds more
			than two requests of DRAM controller idle . def
		1	Disable Write Policy
	3-0	Reserved (do not program)...................... default = 0

Which doesn't explain things much more since the bits in question (7, 3, 0) is
marked as "Reserved".

I also have a question; if "movntq; sfence" type of memory copy can cause data
corruption in kernel space, it can in theory also do so in user space right ?
So, if I'm right this bug could also be on machines running a 2.2 kernel with
userspace programs using 3DNow (or SSE even) instructions.

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best   
 mailto:sp@scali.no  |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.12.2 -         
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >300MBytes/s and <4uS latency
