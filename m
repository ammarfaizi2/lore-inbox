Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267354AbUI0Ue6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUI0Ue6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267352AbUI0Ue4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:34:56 -0400
Received: from mailin.studentenwerk.mhn.de ([141.84.225.229]:47307 "EHLO
	email.studentenwerk.mhn.de") by vger.kernel.org with ESMTP
	id S267301AbUI0Uco convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:32:44 -0400
From: Wolfgang Walter <ml-linux-kernel@studentenwerk.mhn.de>
Organization: Studentenwerk =?iso-8859-1?q?M=FCnchen?=
To: Andrea Arcangeli <andrea@novell.com>
Subject: Re: mlock(1)
Date: Mon, 27 Sep 2004 22:32:38 +0200
User-Agent: KMail/1.7
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Stefan Seyfried <seife@suse.de>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <E1CAzyM-0008DI-00@calista.eckenfels.6bone.ka-ip.net> <1096281162.6485.19.camel@laptop.cunninghams> <20040927142946.GG28865@dualathlon.random>
In-Reply-To: <20040927142946.GG28865@dualathlon.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200409272232.38952.ml-linux-kernel@studentenwerk.mhn.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Basically to avoid to type the password during suspend, we'd need an
> algorihtm that encrypts with a public key stored on the harddisk and
> restore with the private key that sits only on a human brain.  The
> public key would be stored on the harddisk and it would be used by
> suspend to write to the swap partition. the resume password would be
> asked to the user and used to decrypt the data. I think it should work
> fine in theory.
>
> However AFIK those public/private key algorithms only works securely with
> tons of bits (a lot more than with a symmetic encryption), so I don't see
> how can an human could possibly remeber such a long private key by memory.
> I guess to make it work you'd need an USB pen to store it and unplug it
> (then you'd have to be careful not to lose the USB pen). So I think it's
> much simpler to use symmetric crypto (like cryptoloop) and to ask the
> password during suspend too.

You may do it like ssh: encrypt the private key with a symmetric cypher using 
a key based on a passphrase and store it on disk (of course this is only as 
secure as your passphrase).

On suspend: generate a symmetric-key KS, save memory to harddisk encrypted 
with KS, append the KS enrypted with the public key A_PUB. append the private 
encrypted key A_PRIV_ENCR_BASED_ON_PASSPHRASE  (which is stored on the 
harddisk). On resume user must type in passphrase, then we can decrypt 
A_PRIV_ENCR_BASED_ON_PASSPHRASE and get A_PRIV, decrypt KS and so decrypt 
saved memory.

Greetings,

Wolfgang Walter
-- 
Wolfgang Walter
Studentenwerk München
Anstalt des öffentlichen Rechts
EDV
Leopoldstraße 15
80802 München
