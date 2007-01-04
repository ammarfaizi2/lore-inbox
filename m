Return-Path: <linux-kernel-owner+w=401wt.eu-S1030199AbXADUr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbXADUr1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 15:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbXADUr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 15:47:26 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:4346 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030199AbXADUr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 15:47:26 -0500
Date: Thu, 4 Jan 2007 21:47:23 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, i2c@lm-sensors.org,
       linux-kernel@vger.kernel.org
Subject: Re: [i2c] Why to I2c drivers not autoload like other PCI devices?
Message-Id: <20070104214723.9f1053bd.khali@linux-fr.org>
In-Reply-To: <20070104193220.GA29541@kroah.com>
References: <20070103165020.4b277ebc@freekitty>
	<20070104005600.GA25712@kroah.com>
	<20070103172916.7f9ca11a@freekitty>
	<20070104055128.GA8115@kroah.com>
	<20070104175412.76ebce25.khali@linux-fr.org>
	<20070104095412.16ac9f53@localhost>
	<20070104193220.GA29541@kroah.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Stephen,

On Thu, 4 Jan 2007 11:32:20 -0800, Greg KH wrote:
> On Thu, Jan 04, 2007 at 09:54:12AM -0800, Stephen Hemminger wrote:
> > Ahak
> > $ modprobe --show-depends `cat /sys/bus/pci/devices/0000:00:1f.3/modalias`
> > WARNING: Not loading blacklisted module i2c_i801
> > FATAL: Module pci:v00008086d000027DAsv000010CFsd00001388bc0Csc05i00 not found.
> > 
> > And the blacklist entry is:
> > 
> > # causes failure to suspend on HP compaq nc6000 (Ubuntu: #10306)
> > blacklist i2c_i801
> > 
> > Looks like Ubuntu decided to wallpaper over a problem rather than fixing it
> 
> I figured it was something like that, not a kernel issue at all :)
> 
> good luck convincing ubuntu to remove the blacklist.

This is the same bug as:
http://bugzilla.kernel.org/show_bug.cgi?id=6449

Which should be "fixed" since 2.6.17 (and late 2.6.16.y), because the
SMBus unhiding quirk which this laptop needs was disabled when the
kernel is built with suspend support. The real fix was provided by Alan
Cox and will be in 2.6.20 if anyone could try the RCs and report.

So the blacklisting should no longer be necessary for any version of
Ubuntu which comes with a kernel >= 2.6.16.18.

-- 
Jean Delvare
