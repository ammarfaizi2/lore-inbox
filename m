Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270097AbTHLLcX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 07:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270222AbTHLLcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 07:32:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57348 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270097AbTHLLcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 07:32:20 -0400
Date: Tue, 12 Aug 2003 12:32:14 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Rob Landley <rob@landley.net>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, kernelbugzilla@kuntnet.org
Subject: Re: [Bug 1068] New: Errors when loading airo module
Message-ID: <20030812123214.B10895@flint.arm.linux.org.uk>
Mail-Followup-To: Rob Landley <rob@landley.net>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kernelbugzilla@kuntnet.org
References: <51060000.1060524422@[10.10.2.4]> <20030810163350.D32508@flint.arm.linux.org.uk> <200308120447.00105.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200308120447.00105.rob@landley.net>; from rob@landley.net on Tue, Aug 12, 2003 at 04:46:56AM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 04:46:56AM -0400, Rob Landley wrote:
> On Sunday 10 August 2003 11:33, Russell King wrote:
> > On Sun, Aug 10, 2003 at 07:07:02AM -0700, Martin J. Bligh wrote:
> > > http://bugme.osdl.org/show_bug.cgi?id=1068
> > >
> > >            Summary: Errors when loading airo module
> > >     Kernel Version: 2.6.0-test3
> > >             Status: NEW
> > >           Severity: normal
> > >              Owner: rmk@arm.linux.org.uk
> > >          Submitter: kernelbugzilla@kuntnet.org
> >
> > This needs to go to the airo maintainers, not me - the oops is caused
> > by buggy airo.c.
> >
> > The IRQ problem is the result of bad configuration - you must enable
> > CONFIG_ISA if you're going to use non-Cardbus PCMCIA cards.
> 
> Do you mean something like:

No.  Its legal to enable PCMCIA without ISA.

The patch below is wrong in any case - the SA11xx stuff should not depend
on ISA.

> --- linux-2.6.0-test3/drivers/pcmcia/Kconfig	2003-08-09 00:39:25.000000000 -0400
> +++ temp/drivers/pcmcia/Kconfig	2003-08-12 04:44:03.000000000 -0400
> @@ -86,7 +86,7 @@
>  
>  config PCMCIA_SA1100
>  	tristate "SA1100 support"
> -	depends on ARM && ARCH_SA1100 && PCMCIA
> +	depends on ARM && ARCH_SA1100 && PCMCIA && ISA
>  	help
>  	  Say Y here to include support for SA11x0-based PCMCIA or CF
>  	  sockets, found on HP iPAQs, Yopy, and other StrongARM(R)/
> @@ -96,7 +96,7 @@
>  
>  config PCMCIA_SA1111
>  	tristate "SA1111 support"
> -	depends on ARM && ARCH_SA1100 && SA1111 && PCMCIA
> +	depends on ARM && ARCH_SA1100 && SA1111 && PCMCIA && ISA
>  	help
>  	  Say Y  here to include support for SA1111-based PCMCIA or CF
>  	  sockets, found on the Jornada 720, Graphicsmaster and other
> 
> Rob
> 
> 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

