Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293122AbSBWOyU>; Sat, 23 Feb 2002 09:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293139AbSBWOyK>; Sat, 23 Feb 2002 09:54:10 -0500
Received: from [195.63.194.11] ([195.63.194.11]:3347 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S293122AbSBWOyF>;
	Sat, 23 Feb 2002 09:54:05 -0500
Message-ID: <3C77ACDA.8080608@evision-ventures.com>
Date: Sat, 23 Feb 2002 15:53:14 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Andre Hedrick <andre@linuxdiskcert.org>,
        =?ISO-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>,
        Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjanv@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <Pine.LNX.4.10.10202221210430.2519-100000@master.linux-ide.org> <3C76D873.FAA028E0@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Andre Hedrick wrote:
> 
>>On Fri, 22 Feb 2002, Jeff Garzik wrote:
>>
>>
>>>Andre Hedrick wrote:
>>>
>>>>Also not that ATA/IDE drivers were not using 2.4 PCI API and likewise was
>>>>stable for a while.
>>>>
>>>Stable?  Yes.  But it's not modular nor compatible with current efforts
>>>like 2.4 cardbus or 2.4 hotplug pci or 2.5 device mode.  If one cannot
>>>do
>>>      modprobe piix4_ide
>>>and have the right things happen automatically, the system is not
>>>modular.  If it doesn't use the PCI API, it's implementing CardBus
>>>support in a non-standard way if at all.
>>>
>>Now what happens if you have more than one HOST of the same kind or the
>>"SAME HOST" with multiple functions but are really one HOST?
>>
>>I do not see how this will handle the problem.
>>But obviously I have been to far down making sure the DATA got to platter
>>correct and most likely missed a few things. :-/
>>
>>
>>>>>This is need for transparented support for cardbus and hotplug PCI, not
>>>>>
>>>>This is HOST level operation not DEVICE, and you do not see the differenc.
>>>>
>>>I do.  I am talking about a HOST api here.
>>>
>>Okay we are getting some place now, cause what I was reading and seeing in
>>the changes registers a DRIVE to the PCI API and not a HOST.
>>
> 
> Yes... I think there was some earlier confusion.  PCI API is definitely
> an API for registering hosts.
> 
> If you have a C structure "struct drive", it may be useful to have a
> pointer to struct pci_dev.  That is just a reference from drive back to
> the host.  So you could do crazy references like this pseudocode:
> 
>   struct pci_dev *host_pci;
>   struct ata_host *host_ata;
>   struct ata_channel *channel;
> 
>   host_pci = cur_drive->pci_dev;
>   host_ata = pci_get_drvdata(host_pci);
>   channel = &host_ata->channels[cur_drive->channel_number];
> 
> These back-references are very useful, and use of a concept like this
> may be the source of confusion.

BTW.> The ATA driver is currently entierly confused about
hosts and channels. Usually a host has two channels on it but it
doesn't deal properly with this fact. (to ide_hwif_t instances... and a 
"mate" pointer)

