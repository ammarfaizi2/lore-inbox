Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbVAJUfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVAJUfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbVAJUdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:33:05 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:16333 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262490AbVAJU2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:28:06 -0500
Subject: Re: Flaw in ide_unregister()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <019201c4f711$67237c20$0f01a8c0@max>
References: <007e01c4ef30$f23ba3c0$0f01a8c0@max>
	 <1104674725.14712.50.camel@localhost.localdomain>
	 <067d01c4f69b$cb9d8b80$0f01a8c0@max>
	 <1105314226.12054.57.camel@localhost.localdomain>
	 <019201c4f711$67237c20$0f01a8c0@max>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105382277.12054.94.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 10 Jan 2005 19:23:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-10 at 12:39, Richard Purdie wrote:
> Offloading this responsibility onto each and every driver seems rather 
> rather unwise and will result in a lot of code duplication. Are there any 
> circumstances where we need ide_unregister to abort on busy? Even if there 
> are would a flag to indicate what it should do with a busy drive be better?

Currently there are four things in the -ac tree that use this feature

1.	ISA PnP, where we don't support hotplug (and anyway the only maker of
consumer hotpluggable ISA docking stations I know of - IBM - wont
provide docs on them)
2.	ide-cs
3.	delkin (cardbus IDE)
4.	PCI layer

Of those the PCI one is a common shared function so I put the supporting
logic in the IDE PCI helper function, The others need different handling
at the PCMCIA or Cardbus level in order to free up resources and clean
up.

