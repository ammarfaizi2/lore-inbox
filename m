Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbTBNQe6>; Fri, 14 Feb 2003 11:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbTBNQe6>; Fri, 14 Feb 2003 11:34:58 -0500
Received: from fmr02.intel.com ([192.55.52.25]:2499 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261354AbTBNQe4>; Fri, 14 Feb 2003 11:34:56 -0500
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matt Porter <porter@cox.net>, Scott Murray <scottm@somanetworks.com>,
       Patrick Mochel <mochel@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1045234137.7958.17.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.33.0302131317210.1133-100000@localhost.localdomain>
	<Pine.LNX.4.44.0302131603500.23407-100000@rancor.yyz.somanetworks.com>
	<20030213155817.B1738@home.com>  <1045173941.1009.4.camel@vmhack>
	<1045183679.1009.7.camel@vmhack> 
	<1045234137.7958.17.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Feb 2003 07:32:33 -0800
Message-Id: <1045236757.12974.14.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 06:48, Alan Cox wrote:
> On Fri, 2003-02-14 at 00:47, Rusty Lynch wrote:
> > Ok, I had to go and read the driver-model documentation a couple of more
> > times, but after I actually started writing some code it finally started
> > to make sense.  
> 
> The watchdog_ops is probably a good thing anyway. If you also use that
> same structure with the base watchdog module having the ioctl parser all
> the ioctl handling funnies and quirks in the drivers go away except
> for driver private stuff.
> 
> Two for the price of one
> 
> Alan
> 

Since only one driver can register as the /dev/watchdog (ie
major=10/minor=130 char device), would it be better if:

* the first watchdog driver to register with the base also gets
registered as the watchdog misc device, and when that driver unregisters
then the second watchdog to register now gets registered as the misc
device, etc.
* each watchdog driver gets an additional sysfs file named 'misc', where
writing a '1' to the file causes the driver to become the registered
misc watchdog device.
* something else

    --rustyl


