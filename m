Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131441AbRA3AfN>; Mon, 29 Jan 2001 19:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbRA3AfD>; Mon, 29 Jan 2001 19:35:03 -0500
Received: from mail.mojomofo.com ([208.248.233.19]:11782 "EHLO mojomofo.com")
	by vger.kernel.org with ESMTP id <S131441AbRA3Aew>;
	Mon, 29 Jan 2001 19:34:52 -0500
Message-ID: <014001c08a54$70d24bd0$0300a8c0@methusela>
From: "Aaron Tiensivu" <mojomofo@mojomofo.com>
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10101291523470.9984-100000@penguin.transmeta.com>
Subject: Re: 2.4.0-test12: SiS pirq handling..
Date: Mon, 29 Jan 2001 19:34:42 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2403.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2403.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| > Problem still exists, diffed to last kernel:
| Yes. But everything works for you, no? Including USB?

Mmmhmm..

| The problem is that you have this routing table entry:
|
| 00:01 slot=00 0:62/1eb8 1:00/0000 2:00/0000 3:00/0000
|
| which is really for the USB chip (PCI id 00:01.2), and which the PCI code
| _does_ find for the USB chip. So it should set up the routing happily, and
| everything should be ok.

Leave it to me to have goofy hardware.. :)

| Basically, the way your chipset is laid out PCI-wise, they are
| subfunctions of the same device (subfunction 1 is IDE, subfunction 2 is
| USB. Because of this they share an irq routing entry, and if they were to
| NOT clash they should have been given separate "irq pin" numbers in their
| config space. So a _good_ routing entry might have looked like
|
| 00:01 slot=00 0:fe/4000 1:62/1eb8 2:00/0000 3:00/0000
|
| where the IDE device has "irqpin=1" and the USB device has "irqpin=2", and
| USB points to link 62, while IDE points to link fe (ie "hardcode to 14").

Does anyone know who to prod at ASUS to maybe update their BIOS with a
proper routing table?
Maybe even adding proper K6-2+/K6-3+ ids in the BIOS (we can dream I
suppose)..
This is a simple packet-pumping routing box so one of those chips would be
overkill anyway.

| Now, will the two people in the world who know the pirq black magic now
| stand up and confirm or deride my interpretation?

It sounds correct to me..


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
