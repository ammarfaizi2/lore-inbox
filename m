Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbTFOSf4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbTFOSf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:35:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22285 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262589AbTFOSeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:34:50 -0400
Date: Sun, 15 Jun 2003 19:48:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>,
       Dominik Brodowski <linux@brodo.de>, torvalds@transmeta.com,
       cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [2.5 PATCH] bug if cpufreq driver initialization fails
Message-ID: <20030615194838.M5417@flint.arm.linux.org.uk>
Mail-Followup-To: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>,
	Dominik Brodowski <linux@brodo.de>, torvalds@transmeta.com,
	cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
References: <20021108092241.A1636@brodo.de> <20030614084611.GA10182@bouh.unh.edu> <20030614095646.GA1702@brodo.de> <20030614214943.GA4073@bouh.unh.edu> <20030615095044.GD2009@brodo.de> <20030615180435.GC686@bouh.unh.edu> <20030615191650.J5417@flint.arm.linux.org.uk> <20030615182507.GE686@bouh.unh.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030615182507.GE686@bouh.unh.edu>; from Samuel.Thibault@ens-lyon.fr on Sun, Jun 15, 2003 at 02:25:07PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 02:25:07PM -0400, Samuel Thibault wrote:
> Le dim 15 jun 2003 19:16:50 GMT, Russell King a tapoté sur son clavier :
> > On Sun, Jun 15, 2003 at 02:04:36PM -0400, Samuel Thibault wrote:
> > > I hence modified drivers/base/sys.c to have sysdev_driver_register()
> > > fail as well, and then I also had to modify kernel/cpufreq.c, because
> > > this failure did not imply a setting cpufreq_driver to NULL (preventing
> > > me from reinsmoding speedstep-ich: EBUSY)
> > 
> > Unfortunately, you created a by by doing so.  Eg:
> > 
> > - you have 3 devices on kset.list.
> > - you successfully register 2 of them with a driver.
> > - you fail one.
> > - sysdev_driver_register returns failure.
> > - module is unloaded while other parts of the kernel have references into
> >   the driver.
> > - the kernel oopses.
> Ok, that's what I was wondering, might an exit loop removing the already
> added driver be done?
> 
> (the second half of the patch might still be applied as soon as now)

Also, I think people need to consider whether "all devices failed"
or "any device failed" counts as overall failure.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

