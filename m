Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316238AbSEQO2A>; Fri, 17 May 2002 10:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316240AbSEQO17>; Fri, 17 May 2002 10:27:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15883 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id <S316238AbSEQO1q>;
	Fri, 17 May 2002 10:27:46 -0400
Date: Fri, 17 May 2002 09:27:40 -0500
From: Tommy Reynolds <reynolds@redhat.com>
To: "Ingo Oeser" <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can BUG() also be used "safely" in interrupts?
Message-Id: <20020517092740.62b4d60b.reynolds@redhat.com>
In-Reply-To: <20020517090139.G635@nightmaster.csn.tu-chemnitz.de>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.7.6cvs8 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uttered "Ingo Oeser" <ingo.oeser@informatik.tu-chemnitz.de>, spoke thus:

>  I have a routine to be used in an ISR or BH, where I like to use
>  BUG(), to flag real bugs the caller produces, if he uses it with
>  wrong arguments (namely: check for asserted interrupts according
>  to a mask and flag an BUG(), if the mask is bogus).
> 
>  So can BUG() be used in an ISR or BH?

BUG() is overkill here, since it breaks all existing spin locks trying to get
the error message printed by the kernel.  Instead, why not just:

	printk( KERN_WARN "spurious interrupt from my device\n" );

like everyone else does?  Keep in mind that if you are sharing an interrupt
vector, each and every interrupt handler gets called for each and every
interrupt, so having the device driver check that the device to which it is
attached is really generating an interrupt is simple good form.
