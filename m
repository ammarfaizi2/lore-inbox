Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266958AbTBNSw6>; Fri, 14 Feb 2003 13:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266991AbTBNSw6>; Fri, 14 Feb 2003 13:52:58 -0500
Received: from fmr02.intel.com ([192.55.52.25]:3815 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S266958AbTBNSw4>; Fri, 14 Feb 2003 13:52:56 -0500
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matt Porter <porter@cox.net>, Scott Murray <scottm@somanetworks.com>,
       Patrick Mochel <mochel@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1045245352.1353.35.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.33.0302131317210.1133-100000@localhost.localdomain>
	<Pine.LNX.4.44.0302131603500.23407-100000@rancor.yyz.somanetworks.com>
	<20030213155817.B1738@home.com>  <1045173941.1009.4.camel@vmhack>
	<1045183679.1009.7.camel@vmhack>
	<1045234137.7958.17.camel@irongate.swansea.linux.org.uk>
	<1045236757.12974.14.camel@vmhack> 
	<1045245352.1353.35.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Feb 2003 11:02:20 -0800
Message-Id: <1045249341.13262.10.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 09:55, Alan Cox wrote:
> On Fri, 2003-02-14 at 15:32, Rusty Lynch wrote:
> > Since only one driver can register as the /dev/watchdog (ie
> > major=10/minor=130 char device), would it be better if:
> > 
> > * the first watchdog driver to register with the base also gets
> > registered as the watchdog misc device, and when that driver unregisters
> > then the second watchdog to register now gets registered as the misc
> > device, etc.
> > * each watchdog driver gets an additional sysfs file named 'misc', where
> > writing a '1' to the file causes the driver to become the registered
> > misc watchdog device.
> > * something else
> 
> I had hoped we'd get some kind of sanity and 32bit dev_t by now at which
> point watchdogs belong on a major with /dev/watchdog0/1/2/3/... I dont
> think you need to care about that for now. Sysfs doesn't help here in
> the general case as it lacks persistant file permissions, but where it
> is used the user can simply make /dev/watchdog a link into sysfs and
> nothing has to be done by the driver
> 
> Alan
> 

If /dev/watchdog is a link to a sysfs file, then (at least in sysfs's
current state) you loose the ability to handle the documented watchdog
ioctl's.  That is why I assumed that the watchdog base.c could implement
a miscdev registered for the watchdog minor (130), and then translate
the documented ioctl's into the watchdog_ops calls for the the specific
driver that is currently associated with the miscdevice.

Or... are you suggesting the ioctl interface is deprecated and
/dev/watchdog/ is a symbolic link to a given watchdog driver directory
in syfs?

    --rustyl

