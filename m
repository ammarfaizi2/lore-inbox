Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314571AbSD0DSW>; Fri, 26 Apr 2002 23:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314572AbSD0DSW>; Fri, 26 Apr 2002 23:18:22 -0400
Received: from ns.suse.de ([213.95.15.193]:5643 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314571AbSD0DSV>;
	Fri, 26 Apr 2002 23:18:21 -0400
Date: Sat, 27 Apr 2002 05:18:20 +0200
From: Dave Jones <davej@suse.de>
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH} SMBIOS support
Message-ID: <20020427051820.D14743@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Corey Minyard <minyard@acm.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3CCA1462.9010405@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2002 at 10:00:50PM -0500, Corey Minyard wrote:

Hi Corey,

 > --- ./arch/i386/kernel/pci-pc.c.smbios	Fri Apr 26 10:59:55 2002
 > +++ ./arch/i386/kernel/pci-pc.c	Fri Apr 26 11:00:13 2002
 > @@ -1293,6 +1293,10 @@
 >  	return;
 >  }
 >  
 > +#ifdef CONFIG_SMBIOS
 > +extern void smbios_init(void);
 > +#endif
 > +
 >  void __init pcibios_init(void)
 >  {
 >  	int quad;
 > @@ -1322,6 +1326,10 @@
 >  
 >  	pcibios_fixup_irqs();
 >  	pcibios_resource_survey();
 > +
 > +#ifdef CONFIG_SMBIOS
 > +	smbios_init();
 > +#endif
 >  
 >  #ifdef CONFIG_PCI_BIOS
 >  	if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))

Any reason for initialising it there instead of using a subsys_initcall
from smbios.c ?

 > +void __init hexdump (u8 *data, int len)

Something this generic sounding should be static.

 > +	char str[80];

Worth adding a if (len>80) return here in case of crap biosen?
Or am I overly paranoid?


    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
