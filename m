Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316187AbSG3Jm6>; Tue, 30 Jul 2002 05:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316586AbSG3Jm6>; Tue, 30 Jul 2002 05:42:58 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:62972 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316187AbSG3Jm5>; Tue, 30 Jul 2002 05:42:57 -0400
Subject: Re: [PATCH] 2.5.29 IDE 108
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin@dalecki.de
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D459710.3020405@evision.ag>
References: <Pine.LNX.4.33.0207262004550.1357-100000@penguin.transmeta.com>
	 <3D459710.3020405@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 Jul 2002 12:02:14 +0100
Message-Id: <1028026934.6726.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 20:27, Marcin Dalecki wrote:
> - Fixup cmd640 fix by LT.

The CMD640 fix is wrong. You must take pci_lock to protected the cmd640
pci access functions. You also need to check if conf1/conf2 is available
otherwise you will crash some systems when the driver init runs (found
by Justin Gibbs at Adaptec). I sent Linus the proper patch for this a
few days ago and cc'd the list.

Basically conf1/conf2 is protected elsewhere in the kernel via arch
specific locks and via a higher level config lock. Since the non x86
folks use CMD640 we have to take the higher level lock.

Alan

