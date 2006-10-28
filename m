Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWJ1VNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWJ1VNt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 17:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWJ1VNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 17:13:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22186 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964850AbWJ1VNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 17:13:48 -0400
Date: Sat, 28 Oct 2006 22:13:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Brownell <david-b@pacbell.net>
Cc: Christoph Hellwig <hch@infradead.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, toralf.foerster@gmx.de,
       netdev@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       link@miggy.org, greg@kroah.com, akpm@osdl.org, zippel@linux-m68k.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usbnet: use MII hooks only if CONFIG_MII is enabled
Message-ID: <20061028211342.GA23360@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Brownell <david-b@pacbell.net>,
	Randy Dunlap <randy.dunlap@oracle.com>, toralf.foerster@gmx.de,
	netdev@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
	link@miggy.org, greg@kroah.com, akpm@osdl.org,
	zippel@linux-m68k.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <20061025165858.b76b4fd8.randy.dunlap@oracle.com> <20061028112122.GA14316@infradead.org> <200610281410.13679.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610281410.13679.david-b@pacbell.net>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 02:10:09PM -0700, David Brownell wrote:
> On Saturday 28 October 2006 4:21 am, Christoph Hellwig wrote:
> 
> > This is really awkward and against what we do in any other driver.
> 
> Awkward, yes -- which is why I posted the non-awkward version,
> which is repeated below.  (No thanks to "diff" for making the
> patch ugly though; the resulting code is clean and non-awkward,
> moving that function helped.)
> 
> Against what other drivers do?  Since "usbnet.c" is infrastructure
> code, not a driver, your comment can't apply.  Infrastructure uses
> conditional compilation routinely in such cases.
> 
> But remember that the actual drivers follow the standard convention
> ("select MII") given Randy's patch #1 of 2.

Ah sorry - I missed that.

I still don't quite like the approach.  What about simply putting
the mii using functions into usbnet-mii.c and let makefile doing
all the work?  This would require a second set of ethtool ops,
but I'd actually consider that a cleanup, as it makes clear which
one we're using and allows to kill all the checks for non-mii
hardware in the methods.

