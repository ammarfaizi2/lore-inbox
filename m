Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262787AbVAKCpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbVAKCpo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 21:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbVAKCmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 21:42:17 -0500
Received: from tim.rpsys.net ([194.106.48.114]:50650 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262633AbVAJVUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:20:43 -0500
Message-ID: <06ae01c4f759$c6036dc0$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <007e01c4ef30$f23ba3c0$0f01a8c0@max> <1104674725.14712.50.camel@localhost.localdomain> <067d01c4f69b$cb9d8b80$0f01a8c0@max> <1105314226.12054.57.camel@localhost.localdomain> <019201c4f711$67237c20$0f01a8c0@max> <1105382277.12054.94.camel@localhost.localdomain>
Subject: Re: Flaw in ide_unregister()
Date: Mon, 10 Jan 2005 21:17:11 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox:
> Currently there are four things in the -ac tree that use this feature
>
> 1. ISA PnP, where we don't support hotplug (and anyway the only maker of
> consumer hotpluggable ISA docking stations I know of - IBM - wont
> provide docs on them)
> 2. ide-cs
> 3. delkin (cardbus IDE)
> 4. PCI layer
>
> Of those the PCI one is a common shared function so I put the supporting
> logic in the IDE PCI helper function, The others need different handling
> at the PCMCIA or Cardbus level in order to free up resources and clean
> up.

PCI seems to use __ide_unregister_hwif() directly. Case 2 and 3 seem to need 
the "retry until the device is unregistered" behaviour and case 1 seems to 
be compatible with that.

That suggests ide_unregister_hwif() could call itself back via a work queue 
until the device unregisters successfully. Anything that doesn't want this 
behaviour can use __ide_unregister_hwif() directly as PCI does?

Richard 

