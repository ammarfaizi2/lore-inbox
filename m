Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317949AbSFSRhk>; Wed, 19 Jun 2002 13:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317950AbSFSRhj>; Wed, 19 Jun 2002 13:37:39 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:28173 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317949AbSFSRhh>;
	Wed, 19 Jun 2002 13:37:37 -0400
Date: Wed, 19 Jun 2002 10:36:22 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Matthew Harrell 
	<mharrell-dated-1024798178.8a2594@bittwiddlers.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.22 fix for pci_hotplug
Message-ID: <20020619173622.GB26136@kroah.com>
References: <20020618215549.GG21229@kroah.com> <Pine.NEB.4.44.0206190101020.10290-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0206190101020.10290-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 22 May 2002 16:25:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 01:04:07AM +0200, Adrian Bunk wrote:
> On Tue, 18 Jun 2002, Greg KH wrote:
> 
> > On Mon, Jun 17, 2002 at 10:09:37PM -0400, Matthew Harrell wrote:
> > >
> > > --- linux/drivers/hotplug/pci_hotplug_core.c-ori	Mon Jun 17 22:01:17 2002
> > > +++ linux/drivers/hotplug/pci_hotplug_core.c	Mon Jun 17 22:03:33 2002
> > > @@ -183,13 +183,13 @@
> > >  /* default file operations */
> > >  static ssize_t default_read_file (struct file *file, char *buf, size_t count, loff_t *ppos)
> > >  {
> > > -	dbg ("\n");
> > > +	dbg ("%s", "\n");
> >
> > <snip>
> >
> > What problem does this fix?
> >...
> 
> He tries to fix the following compile error that is caused by Martin
> Dalecki's "[PATCH] 2.5.21 kill warnings 4/19" that is included in 2.5.22:

Yeah, it looks like Martin got it wrong :)

Can you try this patch instead and let me know if it fixes it or not?

thanks,

greg k-h


diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Wed Jun 19 10:36:21 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Wed Jun 19 10:36:21 2002
@@ -48,7 +48,7 @@
 	#define MY_NAME	THIS_MODULE->name
 #endif
 
-#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt, MY_NAME, __FUNCTION__, ## arg); } while (0)
+#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt , MY_NAME , __FUNCTION__ , ## arg); } while (0)
 #define err(format, arg...) printk(KERN_ERR "%s: " format , MY_NAME , ## arg)
 #define info(format, arg...) printk(KERN_INFO "%s: " format , MY_NAME , ## arg)
 #define warn(format, arg...) printk(KERN_WARNING "%s: " format , MY_NAME , ## arg)
