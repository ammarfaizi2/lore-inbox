Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSHIQNn>; Fri, 9 Aug 2002 12:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSHIQNn>; Fri, 9 Aug 2002 12:13:43 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:65413 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S314459AbSHIQNn>;
	Fri, 9 Aug 2002 12:13:43 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200208091616.UAA05120@sex.inr.ac.ru>
Subject: Re: Unix-domain sockets - abstract addresses
To: lkml@procter-collective.org.uk (Michael Procter)
Date: Fri, 9 Aug 2002 20:15:56 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020809145212.B1244@cad.citel.com> from "Michael Procter" at Aug 9, 2 02:52:13 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Why is the address not generated for 'security & compatibility' reasons? 

Compatibility: traditional unix domain sockets are not autobound.
So request for binding must be explicit. SO_RECVCRED, being not present
in traditional api, is consifered as such request, at least it indicates
that you are going to receive something.

Security: interlopers are not able to send to socket which has no address,
except for case when peering was established explicitly f.e. with socketpair().
Actually, (almost) simultaneously with possibility to autobind another
check was added which relieves this security issue: namely, if socket
A is connected to B, we reject all the sends to A from anywhere except for B.
However the problem remains f.e. for the case when socket A was disconnected
due to temporary shutdown of B.


> PF_INET/SOCK_DGRAM.  From an interface point of view, they are very similar

The difference is that UDP does not provide any kind of security at all.
Unix domain sockets do and used exactly in circumstances when it is important.


> However, there is still an inconsistency.

Yes. I am not sure, what is right. Most likely, my patchlet was wrong.
Need to compare with another OSes.

Alexey

