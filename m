Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264959AbRGIVTr>; Mon, 9 Jul 2001 17:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264963AbRGIVTh>; Mon, 9 Jul 2001 17:19:37 -0400
Received: from pille1.addcom.de ([62.96.128.35]:8467 "HELO pille1.addcom.de")
	by vger.kernel.org with SMTP id <S264959AbRGIVTX>;
	Mon, 9 Jul 2001 17:19:23 -0400
Date: Mon, 9 Jul 2001 23:12:25 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Patrick Mochel <mochel@transmeta.com>
cc: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <saw@saw.sw.com.sg>
Subject: Re: 2.4.6.-ac2: Problems with eepro100
In-Reply-To: <Pine.LNX.4.10.10107090841550.1391-100000@nobelium.transmeta.com>
Message-ID: <Pine.LNX.4.33.0107092302450.2729-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2001, Patrick Mochel wrote:

> Can you do an 'lspci -vv' on the device? The current device state should
> be listed 2 lines after the Power Management Capabilities revision.

I already talked to Martin off list about this problem (since it's my 
patch which is causing trouble).

To summarize the results: His eepro100 does only survive one
D0-D2-D0 transition, after another D2 transition it's possible to place it 
back in D0, but it won't work.

It comes up in D0, eepro100 module load will place it in D2, first
ifconfig up will switch to D0, works. Another ifconfig down / up cycle 
will kill the network (same happens with the unpatched version).

If someone feels able to find out what's really happening, that'd be great
of course. To the question of what to do about this, the only thing I can
think of is adding a parameter/config option for eepro100 to supply the
power state when inactive (default would be D2, for Martin D0 will work).

Better ideas anyone?

--Kai


