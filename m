Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264648AbRFPTyi>; Sat, 16 Jun 2001 15:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264649AbRFPTy2>; Sat, 16 Jun 2001 15:54:28 -0400
Received: from smtp-rt-14.wanadoo.fr ([193.252.19.224]:62709 "EHLO
	adansonia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264648AbRFPTyQ>; Sat, 16 Jun 2001 15:54:16 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: pci_disable_device() vs. arch
Date: Sat, 16 Jun 2001 21:53:31 +0200
Message-Id: <20010616195331.26754@smtp.wanadoo.fr>
In-Reply-To: <15147.35421.866268.67790@pizda.ninka.net>
In-Reply-To: <15147.35421.866268.67790@pizda.ninka.net>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Would it make sense to add a 

pcibios_disable_device(pci_dev*) called from the end of 
pci_disable_device() ?

I'm adding a call to it to sungem along with other pmac stuffs
so that the chip can be properly power down (actually it's not
really powered down but unclocked) after module removal.
Of course, the arch code must be able to catch it in order to
play with the various UniNorth control bits.

Note that my current gmac driver does shut the chip down when
the interface is down, which makes it a bit more useful for
laptops as most users currently compile the driver in the kernel.

I have nothing about changing the policy if you prefer so that
users will now have to rmmod the driver once done with the
interface to save power.

Ben.


