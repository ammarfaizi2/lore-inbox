Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267437AbTBIUur>; Sun, 9 Feb 2003 15:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267441AbTBIUur>; Sun, 9 Feb 2003 15:50:47 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:56235
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267437AbTBIUup>; Sun, 9 Feb 2003 15:50:45 -0500
Subject: Re: 2.4.21-pre4 comparison bugs (Even More Again)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030209182251.GA21226@linuxhacker.ru>
References: <20030208171838.GA2230@linuxhacker.ru>
	 <1044752320.18908.18.camel@irongate.swansea.linux.org.uk>
	 <20030209175349.GA20635@linuxhacker.ru>
	 <20030209182251.GA21226@linuxhacker.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044827971.30767.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 09 Feb 2003 21:59:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-09 at 18:22, Oleg Drokin wrote:
> Hello!
> 
>     Ok. In addition to "unsigned_var < 0" kind of error checks that
>     never work, there is different non-working kind of checks:
>     "pointer < 0".
>     We can see these at:
> drivers/char/joystick/tmdc.c:318	if (tmdc->abs[i] < 0) continue;
> drivers/char/epca.c:3758		if (board.port <= 0)
> drivers/char/epca.c:3770		if (board.membase <= 0)
> drivers/media/radio/radio-cadet.c:541	if(request_region(io,2, "cadet-probe")>=0) {
> drivers/net/wan/dscc4.c:1760		if (dscc4_init_dummy_skb(dpriv) < 0)
> 
>      Given the fact that you seem not to like casts to signed int,
>      how do you propose to fix these?

By actually going and reading the drivers to see why the errors occur
and if they are meaningful. You need to know the possible returns and
the intent of those returns.

Eg radio-cadet request region appears not be a cast problem but a
complete misunderstanding of the return codes. Likewise epca it looks
like the board.port/board.membase are just overbroad checks and in fact
harmless.


