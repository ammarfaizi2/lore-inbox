Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314612AbSDTMaO>; Sat, 20 Apr 2002 08:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314613AbSDTMaN>; Sat, 20 Apr 2002 08:30:13 -0400
Received: from Ptrillia.EUnet.sk ([193.87.242.40]:20353 "EHLO meduna.org")
	by vger.kernel.org with ESMTP id <S314612AbSDTMaM>;
	Sat, 20 Apr 2002 08:30:12 -0400
From: Stanislav Meduna <stano@meduna.org>
Message-Id: <200204201229.g3KCTq407352@meduna.org>
Subject: Re: Orinoco_plx, WEP and 0.7.6 fw
To: david@gibson.dropbear.id.au (David Gibson)
Date: Sat, 20 Apr 2002 14:29:52 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020415032853.GK24053@zax> from "David Gibson" at apr 15, 2002 01:28:53
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > I have the Siemens I-GATE 11M PCI card, which is a PrismII based
> > PCMCIA card in the PLX9052 PCI-PCMCIA adapter. This card has
> > firmware version 0.7.6 and definitely supports WEP - I am using
> > 128-bit WEP in Windows without problems.
> 
> The firmware supports WEP, but it is configured differently than
> version 0.8 and later, and I've never managed to work out how to
> properly activate it.

I looked at what does actually fail and have some interesting
datapoints. I used ethereal to watch two scenarios -

1. a communication between another client (a Pocket PC)
   and the access point/router and machines behind it

2. a communication between own machine and the AP

The failures seem to be connected with the data transmitted.
In the case 1 I had no problems to watch lengthy HTTP
communications. However I have never seen the POP request
going out (only answers).

Sometimes I got lenghty conversations also in the case 2, but
I also got a consistent failure mode - TCP checksum on the
receiving direction incorrect and exactly one byte garbled -
the last one. The resulting retry mostly had again the last byte
garbled, but to a different one. In one case the retry
succeeded and the following conversation was then flawless.

The failed packets were short (less than 256 bytes long), so this
is nothing that can be related to a fragment reassembling
or something like that.

That it is consistently the last byte that is garbled seems to
suggest some kind of off-by-one bug. Maybe in the driver,
maybe in the firmware...


What is the legal situation regarding RC4 now - can it be used
in the GPL software without risk, or is this still a grey area?
I think there is a possibility to do the WEP in software
(at least one source code I found does implement the encryption
to avoid the weak IVs) and I am probably going to set the
host en-/decrypt flags and give it a try. Would you accept
such (optional) patch?

Regards
-- 
                                   Stano

