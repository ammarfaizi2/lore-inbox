Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267310AbUHaUUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267310AbUHaUUR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269130AbUHaUT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:19:59 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:34641 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267310AbUHaUQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:16:38 -0400
Message-ID: <2a4f155d04083113162c2759ea@mail.gmail.com>
Date: Tue, 31 Aug 2004 23:16:30 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Reply-To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: K3b and 2.6.9?
Cc: Tim Fairchild <tim@bcs4me.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408301917360.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200408301047.06780.tim@bcs4me.com> <1093871277.30082.7.camel@localhost.localdomain>
 <200408311151.25854.tim@bcs4me.com> <Pine.LNX.4.58.0408301917360.2295@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004 19:29:53 -0700 (PDT), Linus Torvalds
<torvalds@osdl.org> wrote:

> Which implies that the only way to fix it sanely is literally to have K3b
> open the device for writing, and then everything will be happy.
> 
> As far as I can tell, the fix should be a simple one-liner: make sure that
> K3b opens the device with O_RDWR | O_NONBLOCK instead of using O_RDONLY |
> O_NONBLOCK. The fix looks trivial, it's in
> 
>    src/device/k3bdevice.cpp:
>         int K3bCdDevice::openDevice( const char* name );
> 
> (two places).
> 

Checked k3b on CVS and it does this now :

  int flags = O_NONBLOCK;
  if( write )
    flags |= O_RDWR;
  else
    flags |= O_RDONLY;
.....
  fd = ::open( name, flags );

which already fixes the issue. Right?

Cheers,
ismail

-- 
Time is what you make of it
