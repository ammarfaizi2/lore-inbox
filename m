Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279524AbRJXKsM>; Wed, 24 Oct 2001 06:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279521AbRJXKsD>; Wed, 24 Oct 2001 06:48:03 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32005 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279534AbRJXKrv>; Wed, 24 Oct 2001 06:47:51 -0400
Subject: Re: [RFC] New Driver Model for 2.5
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 24 Oct 2001 11:54:07 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
        mochel@osdl.org (Patrick Mochel),
        jlundell@pobox.com (Jonathan Lundell)
In-Reply-To: <20011024103451.8099@smtp.adsl.oleane.com> from "Benjamin Herrenschmidt" at Oct 24, 2001 12:34:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wLfj-0001C8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> case, there's not much left to the controller, it isn't supposed to
> have any command in queue nor receive any new one once all it's child
> drivers have suspended.

scsi devices are children of the scsi subststem (sd, sg, sr, st, osst) not
of the controller. That is how the state flows anyway. Only sr/sd etc know
what the state is for a given device on power off as they may issue 
multiple requests per action true transaction. sg would have to simply
refuse any suspend if open (think about cd-burning or even worse firmware
download)

So the scsi devices hang off sd, sr etc which in turn hang off scsi and 
the controllers hang off scsi (and or the bus layers)

This one at least I think I do understand
