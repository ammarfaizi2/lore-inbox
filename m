Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263886AbTDYLrA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 07:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263887AbTDYLrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 07:47:00 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35975
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263886AbTDYLq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 07:46:59 -0400
Subject: Re: problem with Serverworks CSB5 IDE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Duncan Laurie <duncan@sun.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Olivier Bornet <Olivier.Bornet@puck.ch>
In-Reply-To: <3EA85C5C.7060402@sun.com>
References: <20030423212713.GD21689@puck.ch>
	 <1051136469.2062.108.camel@dhcp22.swansea.linux.org.uk>
	 <20030423232909.GE21689@puck.ch> <20030423232909.GE21689@puck.ch>
	 <20030424080023.GG21689@puck.ch>  <3EA85C5C.7060402@sun.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051268422.5573.25.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Apr 2003 12:00:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually UDMA mode detection is not working at all for CSB5 in
> 2.4.21-rc1 because svwks_revision variable is set in __init function
> so was reading as 0 in svwks_ratemask().  This made it think UDMA
> mode 2 was the max supported, when in reality new revisions do UDMA
> mode 5 and old revisions are mode 4 max.

The revision id is read when we init_chipset_svwks, which comes from the
PCI setup. If the chip is in legacy mode we call init chipset early on
regardless. If it is in native mode it gets called too and we ignore
its view of the IRQ (since thats now PCI defined).

>  		/* Check the OSB4 DMA33 enable bit */
>  		return ((reg & 0x00004000) == 0x00004000) ? 1 : 0;
>  	} else if (svwks_revision < SVWKS_CSB5_REVISION_NEW) {
> -		return 1;
> +		return 2;

Why this change ?


