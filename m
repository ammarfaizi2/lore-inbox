Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262746AbTCPUWh>; Sun, 16 Mar 2003 15:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262751AbTCPUWh>; Sun, 16 Mar 2003 15:22:37 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63454
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262746AbTCPUWg>; Sun, 16 Mar 2003 15:22:36 -0500
Subject: Re: bitmaps/bitops
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200303160131.h2G1V3B10636@devserv.devel.redhat.com>
References: <mailman.1047762781.3457.linux-kernel2news@redhat.com>
	 <200303160131.h2G1V3B10636@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047850976.21605.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 16 Mar 2003 21:42:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-16 at 01:31, Pete Zaitcev wrote:
> > but the prototype for test_and_set_bit() depends on $(ARCH), and it's
> > not consistent, with the second arg (bitmap address) being one of:
> >   volatile void *
> >   void *
> >   volatile unsigned long *
> 
> It should be unsigned long pointer. I have no idea why
> volatile is still alive. Perhaps Linus can remember why he
> left it in on is386. Other arch maintainers midnlessly ape him
> in this area. I think I even kept his e-mail where he explains
> why volatile has to go.

Several 2.4 drivers assume the test_and_set point is a memory
barrier for locking. Lots of

	if(test_and_set_bit(0, &foo))
	{
		x=foodev->blah

Since its inline code and not a memory barrier otherwise there
is little stop the compile doing

	x=foodev->blah

first

