Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262937AbSKTWz6>; Wed, 20 Nov 2002 17:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSKTWz6>; Wed, 20 Nov 2002 17:55:58 -0500
Received: from magic.adaptec.com ([208.236.45.80]:17301 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S262937AbSKTWzb>; Wed, 20 Nov 2002 17:55:31 -0500
Date: Wed, 20 Nov 2002 16:02:17 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AIC7xxx driver build failure
Message-ID: <2111410000.1037833337@aslan.btc.adaptec.com>
In-Reply-To: <1035202558.27309.64.camel@irongate.swansea.linux.org.uk>
References: <15794.7193.525850.601506@milikk.co.intel.com>
 	<671452704.1035095402@aslan.scsiguy.com>
 <1035202558.27309.64.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/3.0.0a5 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 2002-10-20 at 07:30, Justin T. Gibbs wrote:
>> > The AIC 7xxx driver fails to build because the Makefile fails to
>> > specify the correct include path to aicasm.
>> > 
>> > Justin, are you getting this?
>> 
>> No, because this bug doesn't exist in the latest version of the driver
>> in my tree or the last set of patches I sent to Linus (a month ago??).
> 
> Care to send me the stuff Linus has dropped ?

Updated aic7xxx and aic79xx drivers for 2.4 and 2.5 can be found here:

http://people.FreeBSD.org/~gibbs/linux/tarballs

Notable changes:

o Both drivers support Domain Validation
o Memory mapped I/O is now a config option
o New memory mapped I/O register test that will hopefully
  weed out broken VIA chipsets
o The reboot notifier hook has been disabled.  The driver wants
  to shut itself down prior to reboot, but the reboot notifier is
  now called too early in 2.5.X for this to be effective.  It looks
  like it might be possible for the driver to grow a device shutdown
  routine, but it was not obvious with a quick look at this new feature
  how to ensure that the [sd, sr, etc.] driver's shutdown routines
  would be called prior to the aic7xxx driver's routine.  Some guidance
  in this area would be appreciated.
o Tag depth changes are now communicated to the midlayer.
 
--
Justin
