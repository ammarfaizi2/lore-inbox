Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272623AbTHNQuv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 12:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272820AbTHNQuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 12:50:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:9441 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272623AbTHNQut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 12:50:49 -0400
Date: Thu, 14 Aug 2003 09:47:33 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: mochel@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] call drv->shutdown at rmmod
Message-Id: <20030814094733.024675ba.rddunlap@osdl.org>
In-Reply-To: <m13cg4yzlk.fsf@frodo.biederman.org>
References: <Pine.LNX.4.33.0308140854000.916-100000@localhost.localdomain>
	<m13cg4yzlk.fsf@frodo.biederman.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Aug 2003 10:26:47 -0600 ebiederm@xmission.com (Eric W. Biederman) wrote:

| Patrick Mochel <mochel@osdl.org> writes:
| 
| > > At the kexec BOF at OSDL there was some discussion on calling the
| > > device shutdown method at module remove time, in addition to calling
| > > it during reboot.  The driver was the observation that the primary
| > > source of problems in booting linux from linux are drivers with bad
| > > or missing drv->shutdown() routines.  The hope is this will increase
| > > the testing so people can get it right and kexec can become more
| > > useful.  In addition to making normal reboots more reliable.
| > > 
| > > The following patch is an implementation of that idea it calls drv->shutdown()
| > 
| > > before calling drv->remove().  If drv->shutdown() is implemented.
| > 
| > I like the idea behind the patch, but we shouldn't be calling it 
| > unconditionally. We're bound to run into some suprises that could really 
| > kill us this late in the 2.6 game. 
| > 
| > I do think it should go in, as long as there is a flag telling the core 
| > whether or not to call shutdown for that particular device. I think it 
| > could also be extended to include a power state, so the core could suspend 
| > the device before removing the module. 
| 
| Assuming the device driver can get a device out of the suspend state
| when the module is loaded.  This has been one of the biggest problem areas
| with the e100 driver.  It's init code cannot bring the device out of a low
| power state.
| 
| > The default would always be 'Do Nothing', but with a per-device sysfs 
| > file, a developer/user/gui app could be used to set the policy from user 
| > space. 
| 
| Possibly.  But this is getting complicated.  And while I do support things
| being complicated enough to handle the problem this part of the API feels
| like it is excessively complicated.  Which is why I was trying to simply
| it by always calling shutdown on a device before we remove it.

Can it just be a (kernel hacking/debug) CONFIG_DRIVER_SHUTDOWN build
option?

--
~Randy
