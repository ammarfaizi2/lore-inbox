Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932602AbWCGBqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbWCGBqF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbWCGBqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:46:05 -0500
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:19640 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932598AbWCGBqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:46:03 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] EDAC: core EDAC support code
Date: Mon, 6 Mar 2006 20:45:59 -0500
User-Agent: KMail/1.9.1
Cc: Al Viro <viro@ftp.linux.org.uk>, Dave Peterson <dsp@llnl.gov>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <20060306213203.GJ27946@ftp.linux.org.uk> <20060306215344.GB16825@kroah.com>
In-Reply-To: <20060306215344.GB16825@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603062046.00906.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 March 2006 16:53, Greg KH wrote:
> On Mon, Mar 06, 2006 at 09:32:03PM +0000, Al Viro wrote:
> > On Mon, Mar 06, 2006 at 01:01:37PM -0800, Dave Peterson wrote:
> > > Regarding the above problem with the kobject reference count, this
> > > was recently fixed in the -mm tree (see edac-kobject-sysfs-fixes.patch
> > > in 2.6.16-rc5-mm2).  The fix I implemented was to add a call to
> > > complete() in edac_memctrl_master_release() and then have the module
> > > cleanup code wait for the completion.  I think there were a few other
> > > instances of this type of problem that I also fixed in the
> > > above-mentioned patch.
> > 
> > This is not a fix, this is a goddamn deadlock.
> > 	rmmod your_turd </sys/spew/from/your_turd
> > and there you go.  rmmod can _NOT_ wait for sysfs references to go away.
> 
> To be fair, the only part of the kernel that supports the above process,
> is the network stack.  And they implemented a special kind of lock to
> handle just this kind of thing.
> 

Not so:

[root@core ~]# rmmod psmouse < /sys/bus/serio/devices/serio0/rate
ERROR: Module psmouse is in use
[root@core ~]# rmmod psmouse
[root@core ~]# modprobe psmouse
[root@core ~]# 

It would be nice if more subsystem could handle this, preferably without
"Waiting for blah to become free" messages (as in W1).

-- 
Dmitry
