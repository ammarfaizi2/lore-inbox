Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSGYOhV>; Thu, 25 Jul 2002 10:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSGYOhU>; Thu, 25 Jul 2002 10:37:20 -0400
Received: from s1.relay.oleane.net ([195.25.12.48]:48364 "HELO
	s1.relay.oleane.net") by vger.kernel.org with SMTP
	id <S315178AbSGYOhU>; Thu, 25 Jul 2002 10:37:20 -0400
From: <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>, <martin@dalecki.de>,
       Vojtech Pavlik <vojtech@suse.cz>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: PCI config locking (WAS Re: [RFC/CFT] cmd640 irqlocking fixes)2
Date: Thu, 25 Jul 2002 16:40:05 +0200
Message-Id: <20020725144005.8706@smtp.adsl.oleane.com>
In-Reply-To: <1027611916.9488.79.camel@irongate.swansea.linux.org.uk>
References: <1027611916.9488.79.camel@irongate.swansea.linux.org.uk>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> So there seem to be a problem with your patch: pci_config_lock appears
>> to be an x86-only thing that lives deep inside arch/i386/xxx/pci-pc.c
>> (xxx beeing kernel or pci)
>> 
>> On the other hand, there is already such a lock provided by
>> drivers/pci/access.c (pci_lock). You should probably fix your patch
>> to use that one. (and eventually get rid of the pci_config_lock
>> in x86, provided I didn't miss something else). But does anybody
>> but x86 uses CMD640 ? :)
>
>Possibly. I don't know. The lock in question we want is the config lock.
>We are issuing configuration cycles so must lock against a parallel
>issue of I/O to the configuration ports.

Well, all config operations are going through the
pci_read/write_config_xxxx in drivers/pci/pci.c or access.c (2.5)
which will take the pci_lock already. Couldn't x86 use that instead
of stacking another lock ?

Ben.


