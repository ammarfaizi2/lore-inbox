Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280751AbRKOH4p>; Thu, 15 Nov 2001 02:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280768AbRKOH4Y>; Thu, 15 Nov 2001 02:56:24 -0500
Received: from mail311.mail.bellsouth.net ([205.152.58.171]:5277 "EHLO
	imf11bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280751AbRKOH4T>; Thu, 15 Nov 2001 02:56:19 -0500
Message-ID: <3BF37508.6EA78A85@mandrakesoft.com>
Date: Thu, 15 Nov 2001 02:55:52 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] races in access to pci_devices
In-Reply-To: <Pine.GSO.4.21.0111142257510.1095-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
>         Linus, as far as I can see there's no exclusion between
> the code that walks pci_devices and pci_insert_device().  It's
> not a big deal wrt security (not many laptops with remote access)
> but...
> 
>         What locking is supposed to be there?

alas, yes, that's been there since time began, and since the window was
so minimal nobody cared enough to do anything about it.  Even on the
larger hotplug PCI servers that Greg KH mentioned, the pci list really
isn't traversed much, much less updated.

I haven't looked at it in over a year, but from a quick look, all the
list access look like they can be protected by a simple spinlock. 
You'll need to grep the tree, though, because not all users of
pci_devices are in drivers/pci/pci.c.  [users outside of drivers/pci
should really be converted to use pci_find_xxx functions in any case]

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

