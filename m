Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135615AbRDXNss>; Tue, 24 Apr 2001 09:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135616AbRDXNro>; Tue, 24 Apr 2001 09:47:44 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:21986 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135625AbRDXNqt>;
	Tue, 24 Apr 2001 09:46:49 -0400
Message-ID: <3AE583C7.F90D2753@mandrakesoft.com>
Date: Tue, 24 Apr 2001 09:46:47 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Steven Walter <srwalter@yahoo.com>, linux-kernel@vger.kernel.org,
        tytso@mit.edu
Subject: Re: serial driver not properly detecting modem
In-Reply-To: <E14s318-00023o-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I've fixed this here merely by adding an entry to the PCI table of
> > serial.c for PCI_CLASS_COMMUNICATION_OTHER.  Is this the best way to fix
> > this?  Is there some reason that this shouldn't be done in general?  If
> > not, I'd like to see it fix in the kernel proper.
> 
> Most class other devices wont be 16x50 compatible.

winmodems are class other

> > It should be noted that the modem is listed in serial.c's pci_boards,
> > perhaps it would be best for the serial driver to list PCI_ID_ANY for a
> > class, and only use pci_boards to further identify serial ports?  Or
> > would this be too inefficient to correct for a few misguided hardware
> > makers?
> 
> Probably serial.c should look for class serial || (class_other && in table)

no need to consider class other at all, since there are so many
exceptions.  Build the serial.c pci table like

	board 1
	board 2
	board 3
	class 1
	class 2
	class 3

Special cases go before the classes.  A 16x50 compatible class other is
definitely a special case...

On a side note, an outstanding to-do item for the serial driver is to
move its huge honkin' custom PCI table into the pci_device_id standard
table.  The pci_device_id::driver_data member would then become an index
into the smaller custom PCI table.

-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
