Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSFQPrv>; Mon, 17 Jun 2002 11:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314491AbSFQPru>; Mon, 17 Jun 2002 11:47:50 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:4531 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S313571AbSFQPrt>; Mon, 17 Jun 2002 11:47:49 -0400
Date: Mon, 17 Jun 2002 17:47:46 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: isdn oops with 2.4.19-pre10
Message-Id: <20020617174746.0b8ec0a4.kristian.peters@korseby.net>
In-Reply-To: <Pine.LNX.4.44.0206171009550.22308-100000@chaos.physics.uiowa.edu>
References: <20020617092214.03789a68.kristian.peters@korseby.net>
	<Pine.LNX.4.44.0206171009550.22308-100000@chaos.physics.uiowa.edu>
X-Mailer: Sylpheed version 0.7.6claws (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: i686-redhat-linux 2.4.19-pre10-ac2
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
> Okay, I think I can see what is happening.
> 
> Can you confirm that you get the oops if you unload the modules in the 
> same order that you loaded them, but not if you use the reverse order?
> 
> I.e.
> 
> 	insmod capidrv; insmod hisax; rmmod hisax; rmmod capidrv
> 
> should be okay,
> 
> 	insmod capidrv; insmod hisax; rmmod capidrv; rmmod hisax
> 
> oopses?

No. ;-) But it's another issue. I'm loading the hisax drivers first:

hisax                 492836   1 
isdn                  119072   1  [hisax]
slhc                    4624   0  [isdn]
[...]

And after them (and the ippp-related programs..) the drivers for avmb1:

ppp_deflate            40928   0  (unused)
bsd_comp                4056   0  (unused)
ppp_synctty             4768   0  (unused)
ppp_generic            18240   0  [ppp_deflate bsd_comp ppp_synctty]
b1isa                   3740   1 
b1                     17152   0  [b1isa]
capidrv                25716   1 
capi                   17344   0 
capifs                  3712   1  [capi]
kernelcapi             29796   4  [b1isa capidrv capi]
capiutil               22368   0  [capidrv kernelcapi]
[...]

I'm connecting with the avmb1-card to a provider via pppd and starting my iptables firewall (with qos scheduling). While connected or after shutting down the connection unloading the hisax or isdn modules produces that oops. I haven't tried it without the sched-modules loaded. Should I ? It seems that they could be responsible too.

Please note that the avmb1 (b1isa) card is active and hisax a passive one.

Hope that helps.

*Kristian

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:
