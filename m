Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423823AbWJaThI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423823AbWJaThI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423826AbWJaThI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:37:08 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:35445 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1423825AbWJaThF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:37:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=LiSUptQGbousxc57c5DwHvIknxTr4m3+vve3l2fvJSWRxGu2nQ9A2yZTOfCMnjHAYUYWWKwOJ64VWldLg70SvWEx03mKQ/+TdKLBv4KEgScSHyjdVW/Hpbw2reNcU1jnYnWzKe5TKu3DGOTwVxjASPHhXx8uzQs65Zj0SM42Rpo=  ;
From: David Brownell <david-b@pacbell.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [linux-usb-devel] [PATCH 2/2] usbnet: use MII hooks only if CONFIG_MII is enabled
Date: Tue, 31 Oct 2006 11:36:52 -0800
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net,
       Randy Dunlap <randy.dunlap@oracle.com>, akpm@osdl.org,
       zippel@linux-m68k.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, link@miggy.org,
       Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
       greg@kroah.com, toralf.foerster@gmx.de
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <200610310940.16619.david-b@pacbell.net> <20061031180712.GQ27968@stusta.de>
In-Reply-To: <20061031180712.GQ27968@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610311136.54058.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 		...
> > 		depends on MII if MII != n
> > 
> > except that Kconfig doesn't comprehend conditionals like that.
> 
> You can express this in Kconfig:
> 	depends MII || MII=n

Except that:

Warning! Found recursive dependency: USB_USBNET USB_NET_AX8817X MII USB_USBNET

I think this is another case where Kconfig gets in the way and forces
introduction of a pseudovariable.  I'll give that a try.


> But my suggestion was:
> #if defined(CONFIG_MII) || (defined(CONFIG_MII_MODULE) && defined(MODULE))
>
> Or simply select MII ...

Nope; those both prevent completely legit configurations.
MII is not required, except for those two adapter options.


