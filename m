Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753882AbWKRVdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbWKRVdM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 16:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbWKRVdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 16:33:11 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:9862 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1753882AbWKRVdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 16:33:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=H0bfmYse+X294VOxX0mu7gD3OlYaD8/HSL2cnJJOokIKwbBO+sqpiSmUpEnz/ufaOheof0PwToR+hbIX0TCP4WbSX/4N408x+E+px1b8BXi3Qzo5USJBRaNYXCc9Hcjk+LY9N+er11xpgaQASeLQrByU07Tc8GewbeloxE/d+pQ=  ;
X-YMail-OSG: eCdA9ZgVM1k5gDxql4371dW6ceuemHwHC7FGfaTpqeMtH4H3QDI7wvg3sgiqYvofXsrwo.9Qtm8gk4uH58HNdwafDSksyWFTOsodo1UGPOHzGyPuLDypOW02awepii8bW2qkLOEXgB8l8LLZZwW1SXuQ1GHS4qF.31I-
From: David Brownell <david-b@pacbell.net>
To: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: Re: [patch 0/6] [RFC] Add MMC Password Protection (lock/unlock) support V6
Date: Sat, 18 Nov 2006 11:17:53 -0800
User-Agent: KMail/1.7.1
Cc: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
References: <455DB1FB.1060403@indt.org.br>
In-Reply-To: <455DB1FB.1060403@indt.org.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611181117.54242.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 November 2006 4:58 am, Anderson Briglia wrote:

> - Password caching: when inserting a locked card, the driver should try
>    to unlock it with the currently stored password (if any), and if it
>    fails, revoke the key containing it and fallback to the normal "no
>    password present" situation.

Is there some reason why the key isn't associated with the MMC/SD card
identifier(s)?  It should be practical to swap several cards in/out
without the kernel _needing_ to discard their keys.  What you're saying
is that you'll cache only one key at a time, and that it won't have
anything associating it with a particular card.  That's not at all how
the key retention service is designed to work...


> - Some cards have an incorrect behaviour (hardware bug?) regarding
>    password acceptance: if an affected card has password <pwd>, it
>    accepts <pwd><xxx> as the correct password too, where <xxx> is any
>    sequence of characters, of any length. In other words, on these cards
>    only the first <password length> bytes need to match the correct
>    password.

I thought the MMC vendors expected to see the actual user-typed
password get SHA1-hashed into a value which would take up the whole
buffer?  In general that's a good idea, since it promotes use of
longer passphrases (more information) over short ones (easy2crack).

Plus, such hashing would prevent this issue ... if vendor tests are
done with hashed passphrases, that would explain why this class of
hardware issue got past design validation.

- Dave
