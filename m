Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267018AbSKLXQd>; Tue, 12 Nov 2002 18:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267012AbSKLXQd>; Tue, 12 Nov 2002 18:16:33 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:23976 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267018AbSKLXQb>; Tue, 12 Nov 2002 18:16:31 -0500
Subject: Re: 2.5 Problem Report Status for 10 Nov
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Thomas Molina <tmolina@cox.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <15825.26870.393595.356922@kim.it.uu.se>
References: <Pine.LNX.4.44.0211100834110.16968-100000@dad.molina> 
	<15825.26870.393595.356922@kim.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Nov 2002 23:47:25 +0000
Message-Id: <1037144845.10029.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-12 at 20:47, Mikael Pettersson wrote:
> Thomas Molina writes:
>  >    open   08 Oct 2002 IDE problems on prePCI
>  >    3. http://marc.theaimsgroup.com/?l=linux-kernel&m=103277899317468&w=2
> 
> No update since I haven't had time to do any qd65xx testing in a while.
> I strongly believe the bug is due to the fact that "ide=qd65xx" and
> similar IDE chipset selection options are processed very very early in
> the boot process, long before IDE's normal init.

Sort of half fixed in 2.5.47. 

>  >    open   17 Oct 2002 reboot kills Dell Latitude keyboard
>  >   38. http://marc.theaimsgroup.com/?l=linux-kernel&m=103484425027884&w=2
> 
> This bug is still present in 2.5.47.
> 
>  >    open   08 Nov 2002 piix driver oops
>  >   99. http://marc.theaimsgroup.com/?l=linux-kernel&m=103677362411873&w=2
> 
> That one is a duplicate of the ide-dma oops I reported:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103675019320066&w=2
> Alan stated he had IDE updates that would fix this.

I have updates that will fix some stuff, not this one. I know why this
occurs. Its trivial to make it go away, it requires some major work to
make it go away properly in the context of SATA and hotswap.

The latest patches split the ide registratio code from the ide i/o code.
Its now possible to read all the registration code in one place. I'm now
commenting it ready to rip it to shreds.

And yes now ide.c in 2.5.47-ac1 is basically just the registration code
it must qualify for some of the ugliest code in the kernel ;)

