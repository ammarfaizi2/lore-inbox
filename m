Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318377AbSGYI6v>; Thu, 25 Jul 2002 04:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318375AbSGYI6r>; Thu, 25 Jul 2002 04:58:47 -0400
Received: from [195.63.194.11] ([195.63.194.11]:23814 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318372AbSGYI6S>; Thu, 25 Jul 2002 04:58:18 -0400
Message-ID: <3D3FBD21.2020607@evision.ag>
Date: Thu, 25 Jul 2002 10:56:01 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: martin@dalecki.de, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/CFT] cmd640 irqlocking fixes
References: <20020724225826.GF25038@holomorphy.com> <1027559111.6456.34.camel@irongate.swansea.linux.org.uk> <20020725095448.B21541@ucw.cz> <3D3FB6C8.1070409@evision.ag> <20020725105538.B21927@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Thu, Jul 25, 2002 at 10:28:56AM +0200, Marcin Dalecki wrote:
> 
>>Vojtech Pavlik wrote:
>>
>>
>>>The kernel functions are OK. The problem is that the kernel can use
>>>PCIBIOS calls to set the registers. And certain old buggy BIOSes which
>>>violate the PCI spec can use wrong size data transfers to set the
>>>registers, which the CMD640 doesn't like.
>>>
>>>IMHO the best workaround here would be either to disable PCIBIOS calls
>>>and revert to conf1 or conf2 in the PCI code if a CMD640 is present, or
>>>just panic() in the CMD640 code and suggest to the user to use
>>>"pci=nobios" on the kernel command line. I'd actually prefer the later.
>>>
>>
>> From a long long time ago during the first days of this driver I 
>>remember that those chips could be wired to both PCI and VLB(ISA) bus.
>>And this is the main reaons why the functions is question exist in first 
>>place -> "emulating" PCI configuration space access on VLB.
> 
> 
> No. For VLB the CMD640 has a somewhat different configuration method.
> See the source. ;) We really should be using pci_write_config_* and
> create vlb_write_config_* in CMD640 for the VLB accesses, panic() in
> case we have a PCI system that uses BIOS and we found a CMD640, and
> remove the duplicate PCI conf1 and PCI conf2 code from cmd640.c

OK. Right. We have to touch this code anyway. Do you know first hand how
to detect programmatically which configuration method is in charge? If 
not I can look it up on my own..

