Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261631AbSJZWX1>; Sat, 26 Oct 2002 18:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSJZWX1>; Sat, 26 Oct 2002 18:23:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50694 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261631AbSJZWX0>;
	Sat, 26 Oct 2002 18:23:26 -0400
Message-ID: <3DBB1743.6060309@pobox.com>
Date: Sat, 26 Oct 2002 18:29:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Support PCI device sorting (Re: PCI device order problem)
References: <3DB88715.7070203@pobox.com> <20021024165631.A22676@lucon.org> <1035540031.13032.3.camel@irongate.swansea.linux.org.uk> <20021025091102.A15082@lucon.org> <20021025202600.A3293@lucon.org> <3DBB0553.5070805@pobox.com> <20021026142704.A13207@lucon.org> <3DBB0A81.6060909@pobox.com> <20021026144441.A13479@lucon.org> <3DBB1150.2030800@pobox.com> <20021026152043.A13850@lucon.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. J. Lu wrote:

>On Sat, Oct 26, 2002 at 06:04:00PM -0400, Jeff Garzik wrote:
>  
>
>>Which is the entire problem.  The kernel compiles and builds just fine 
>>right now, without your function.
>>
>>    
>>
>
>Without my patch or my function? My patched file has
>
>        if ((pci_probe & PCI_BUS_SORT) && !(pci_probe & PCI_NO_SORT))
>                pci_sort_by_bus_slot_func();
>#ifdef CONFIG_PCI_BIOS
>        else if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))
>                pcibios_sort();
>#endif
>
>That is pci_sort_by_bus_slot_func () will be called if PCI_BUS_SORT is
>set. It is independent of whether CONFIG_PCI_SORT_BY_BUS_SLOT_FUNC is
>set or not, which sets PCI_BUS_SORT. If pci_sort_by_bus_slot_func is
>not defined when CONFIG_PCI_SORT_BY_BUS_SLOT_FUNC is not set. How can
>kernel compile?
>
I am obviously not being understood / not communicating myself clearly.

Your patch unconditionally adds a new function.
Don't do that.  Wrap it in an ifdef, like you propose below.



>I added pci=nobussort since it might not be safe for all MBs. Then I
>added "pci=bussort". I have no problem taking out "pci=bussort". If you
>don't want "pci=bussort", please say so. I can provide a new patch which
>won't define pci_sort_by_bus_slot_func if CONFIG_PCI_SORT_BY_BUS_SLOT
>is not set and won't have "pci=bussort" either.
>  
>

You're still missing the point here too.

Your patch has the potential to suddenly make systems unbootable, to 
suddenly reverse people's ethX interface numbering, etc.  No command 
line options in the world will save lkml from being deluged by tons of 
"my system doesn't network anymore" bug reports.

The basic point is "let's proceed with caution, and test test test 
before applying this patch."

    Jeff



