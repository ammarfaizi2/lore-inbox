Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279721AbRJYIET>; Thu, 25 Oct 2001 04:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279724AbRJYIEK>; Thu, 25 Oct 2001 04:04:10 -0400
Received: from smtp-rt-1.wanadoo.fr ([193.252.19.151]:6033 "EHLO
	anagyris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S279721AbRJYID7>; Thu, 25 Oct 2001 04:03:59 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Thu, 25 Oct 2001 10:03:42 +0200
Message-Id: <20011025080342.1865@smtp.wanadoo.fr>
In-Reply-To: <E15wWiC-0002uM-00@the-village.bc.nu>
In-Reply-To: <E15wWiC-0002uM-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I don't think it is a big problem. We can add virtual nodes. They way I
>see it we either
>	a) put in grungy subsystem hacks
>	b) register virtual device nodes for subsystems when needed
>
>b feels cleaner

Ok, provided that there is not one big "SCSI subsystem" virtual node,
that would screw up the entire dep. hierarchy, but rather virtual nodes
created by SCSI "clients" on the fly as childs of their devices. That
looks fine to me ;)

An example would be:

  * SCSI host
  |
  |
  * SCSI disk device
  |
  |
  * "sd" node

In this case, "sg" could add itself when opened, and eventually cause
sleep requests to be rejected for example.

Well, in fact, I don't think there is real need for the "SCSI disk device"
node, but that depends pretty much on the new SCSI architecture. 

Ben.


