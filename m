Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUC1Re2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 12:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUC1Re1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 12:34:27 -0500
Received: from test.estpak.ee ([194.126.115.47]:63967 "EHLO arena.estpak.ee")
	by vger.kernel.org with ESMTP id S262213AbUC1Rd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 12:33:29 -0500
From: Hasso Tepper <hasso@estpak.ee>
To: Phil Oester <kernel@linuxace.com>
Subject: Re: Kernel panic in 2.4.25
Date: Sun, 28 Mar 2004 20:33:16 +0300
User-Agent: KMail/1.6.2
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, dlstevens@ibm.com
References: <200403260035.09821.hasso@estpak.ee> <20040328163210.GA21803@linuxace.com> <20040328164936.GA21839@linuxace.com>
In-Reply-To: <20040328164936.GA21839@linuxace.com>
MIME-Version: 1.0
Content-Disposition: inline
Organization: Elion Enterprises Ltd.
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403282033.16204.hasso@estpak.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Oester wrote:
> If you are using E100's, can you backout (patch -R) this patch from
> 2.4.25 vanilla:
>
> http://linux.bkbits.net:8080/linux-2.4/gnupatch@401f2442_DogKaCRsao
>MURrjvGCz4w
>
> if using E1000's, can you backout this patch:

Yes.

> http://linux.bkbits.net:8080/linux-2.4/gnupatch@402212c1G2hqO92c1xC
>HTWJ4AFBFPQ

But this patch isn't in 2.4.25-rc1 I have already problem with.

> And see if this stops the panics?

Now when linux.bkbits.net is working again, I walked through patches 
between 2.4.25-pre8 and 2.4.25-rc1 and reverted this patch -
http://linux.bkbits.net:8080/linux-2.4/cset%
401.1290.17.1?nav=index.html|ChangeSet@-9M

This solved problem for me, seems (tested only with 2.4.25-rc1 for 
now). I had feeling that it's related to multicast from the beginning 
because I couldn't reproduce panic when I hadn't ospfd daemon running 
(ospf uses multicast).

> Phil Oester

>
> > On Sun, Mar 28, 2004 at 07:11:06PM +0300, Hasso Tepper wrote:
> > > Hasso Tepper wrote:
> > > > It's almost 100% (sometimes it just hangs) reproducable for
> > > > me although in somewhat strange situation. I have to run
> > > > Quagga/Zebra routing suite with zebra and ospfd daemons
> > > > running. Networking restart script (removing 60 vlans,
> > > > creating them again and assigning IPs to them) leads to
> > > > panic. Process isn't always swapper, I have seen ip and
> > > > kupdated as well, but trace is always same. I can't reproduce
> > > > it with 2.4.20 kernel.
> > >
> > > It's introduced with 2.4.25-rc1 (2.4.25-pre8 is OK). And it's
> > > still there in 2.4.26-rc1.

-- 
Hasso Tepper
Elion Enterprises Ltd.
WAN administrator
