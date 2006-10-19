Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbWJSI1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbWJSI1O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 04:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWJSI1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 04:27:14 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:9350 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S1030314AbWJSI1N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 04:27:13 -0400
From: CIJOML <cijoml@volny.cz>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [Bug 185] Sometimes kernel freezes sometime lists OOPS - hostap_cs
Date: Thu, 19 Oct 2006 10:12:49 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200610171747.34177.cijoml@volny.cz> <20061018235604.47886be9.akpm@osdl.org>
In-Reply-To: <20061018235604.47886be9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610191012.49544.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it is nsc-ircc:

nsc-ircc, chip->init
nsc-ircc, Found chip at base=0x02e
nsc-ircc, driver loaded (Dag Brattli)
nsc-ircc, Using dongle: HP HSDL-2300, HP HSDL-3600/HSDL-3610

I tried udev also and problem is almost the same:

cijoml@notas:~$ dpkg -l|grep udev
ii  udev                            0.100-2                     /dev/ and
hotplug management daemon

dmesg:

pccard: PCMCIA card inserted into slot 1
pcmcia: registering new device pcmcia1.0
1.0: RequestIO: Resource in use
1.0: GetNextTuple: No more items
hostap_cs: probe of 1.0 failed with error 1
1.0: RequestIO: Resource in use
1.0: GetNextTuple: No more items
hostap_cs: probe of 1.0 failed with error 1

And after calling iwconfig I getts:
notas:/home/cijoml/# iwconfig
lo        no wireless extensions.

eth0      no wireless extensions.

wifi0     IEEE 802.11-DS  ESSID:"test"
          Mode:Master
          Encryption key:off

irda0     no wireless extensions.

ppp0      no wireless extensions.

which I have never seen before :(


Best regards
Michal

Dne ètvrtek 19 øíjen 2006 08:56 Andrew Morton napsal(a):
> On Tue, 17 Oct 2006 17:47:34 +0200
>
> CIJOML <cijoml@volny.cz> wrote:
> > can anybody take a look at this bug?
> >
> > http://hostap.epitest.fi/bugz/show_bug.cgi?id=185
> >
> > pccard: PCMCIA card inserted into slot 1
> > pcmcia: registering new device pcmcia1.0
> > ieee80211_crypt: registered algorithm 'NULL'
> > hostap_cs: 0.4.4-kernel (Jouni Malinen <jkmaline@cc.hut.fi>)
> > hostap_cs: Registered netdevice wifi0
> > IRQ handler type mismatch for IRQ 3
>
> Looks like whatever driver is driving irda0 is refusing to share
> interrupts.
>
> Which driver is that?
