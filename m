Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265058AbSLMQJl>; Fri, 13 Dec 2002 11:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265063AbSLMQJl>; Fri, 13 Dec 2002 11:09:41 -0500
Received: from relay.muni.cz ([147.251.4.35]:38282 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S265058AbSLMQJk>;
	Fri, 13 Dec 2002 11:09:40 -0500
To: "Valdis.Kletnieks@vt.edu" <1039774224.1449.0.camel@laptop.fenrus.com>
Cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.5[01]]: Xircom Cardbus broken (PCI resource collisions)
References: <200212131345.gBDDjw27002677@turing-police.cc.vt.edu>
X-URL: http://www.fi.muni.cz/~pekon/
From: Petr Konecny <pekon@informatics.muni.cz>
Date: 13 Dec 2002 17:17:14 +0100
In-Reply-To: <200212131345.gBDDjw27002677@turing-police.cc.vt.edu>
Message-ID: <qww65tx3ncl.fsf@decibel.fi.muni.cz>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Military Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Arjan> interesting. BUT aren't we writing to the device 3 lines before
 Arjan> where you add the pci_enable_device()? That sounds like a bad
 Arjan> plan to me ;(

 Valdis> I see why the if/continue was added - you don't want to be
 Valdis> calling device_register()/pci_insert_device() if
 Valdis> pci_enable_device() loses.  I don't see why 2.5.50 moved the
 Valdis> code up after pci_setup_device(). There's an outside chance
 Valdis> that the concept of moving the call was correct, but that it
 Valdis> should have been moved to between the calls to
 Valdis> pci_assign_resource() and pci_readb().  If that's the case,
 Valdis> then you're correct as well....
I can confirm that this indeed works. I moved the two lines before
pci_readb and the card works (every character you now read went through
it). Who shall submit a patch to Linus ?

Now I have to figure out, how to make it load without manual modprobe
xircom_cb. Oh the joys of new module loader.

                                                Petr
-- 
Computers are like air conditioners.  Both stop working, if you open
windows.
        -- Adam Heath

