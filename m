Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161186AbWATFyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161186AbWATFyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 00:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWATFyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 00:54:46 -0500
Received: from xenotime.net ([66.160.160.81]:37079 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030311AbWATFyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 00:54:45 -0500
Date: Thu, 19 Jan 2006 21:54:46 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, kjhall@us.ibm.com, serue@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: + tpm_bios-needs-more-securityfs_-functions.patch added to -mm
 tree
Message-Id: <20060119215446.0f75cc15.rdunlap@xenotime.net>
In-Reply-To: <20060120045115.GA9027@kroah.com>
References: <200601200440.k0K4ecFH014619@shell0.pdx.osdl.net>
	<20060120045115.GA9027@kroah.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2006 20:51:15 -0800 Greg KH wrote:

> On Thu, Jan 19, 2006 at 08:40:23PM -0800, akpm@osdl.org wrote:
> > 
> > The patch titled
> > 
> >      tpm_bios: needs more securityfs_ functions
> > 
> > has been added to the -mm tree.  Its filename is
> > 
> >      tpm_bios-needs-more-securityfs_-functions.patch
> > 
> > See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> > out what to do about this
> > 
> > 
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > tpm_bios.c needs securityfs_xyz() functions.
> > 
> > Does include/linux/security.h need stubs for these, or should
> > char/tpm/Makefile just be modified to say:
> > 
> > ifdef CONFIG_ACPI
> > ifdef CONFIG_SECURITY
> > 	obj-$(CONFIG_TCG_TPM) += tpm_bios.o
> > endif
> > endif
> > 
> > drivers/char/tpm/tpm_bios.c:494: warning: implicit declaration of function 'securityfs_create_dir'
> > drivers/char/tpm/tpm_bios.c:494: warning: assignment makes pointer from integer without a cast
> > drivers/char/tpm/tpm_bios.c:499: warning: implicit declaration of function 'securityfs_create_file'
> > drivers/char/tpm/tpm_bios.c:501: warning: assignment makes pointer from integer without a cast
> > drivers/char/tpm/tpm_bios.c:508: warning: assignment makes pointer from integer without a cast
> > drivers/char/tpm/tpm_bios.c:523: warning: implicit declaration of function 'securityfs_remove'
> > *** Warning: "securityfs_create_file" [drivers/char/tpm/tpm_bios.ko] undefined!
> > *** Warning: "securityfs_create_dir" [drivers/char/tpm/tpm_bios.ko] undefined!
> > *** Warning: "securityfs_remove" [drivers/char/tpm/tpm_bios.ko] undefined!
> > 
> > There are also some gcc and sparse warnings that could be fixed.
> > (see http://www.xenotime.net/linux/doc/build-tpm.out)
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > Cc: Serge Hallyn <serue@us.ibm.com>
> > Cc: Greg KH <greg@kroah.com>
> > Cc: Kylene Jo Hall <kjhall@us.ibm.com>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > ---
> > 
> >  include/linux/security.h |   19 +++++++++++++++++++
> >  1 files changed, 19 insertions(+)
> > 
> > diff -puN include/linux/security.h~tpm_bios-needs-more-securityfs_-functions include/linux/security.h
> > --- devel/include/linux/security.h~tpm_bios-needs-more-securityfs_-functions	2006-01-19 20:38:50.000000000 -0800
> > +++ devel-akpm/include/linux/security.h	2006-01-19 20:38:50.000000000 -0800
> > @@ -2617,6 +2617,25 @@ static inline int security_netlink_recv 
> >  	return cap_netlink_recv (skb);
> >  }
> >  
> > +static inline struct dentry *securityfs_create_dir(const char *name,
> > +					struct dentry *parent)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static inline struct dentry *securityfs_create_file(const char *name,
> > +						mode_t mode,
> > +						struct dentry *parent,
> > +						void *data,
> > +						struct file_operations *fops)
> > +{
> > +	return NULL;
> > +}
> 
> No, these should return ERR_PTR(-ENODEV) so that you can actually test
> for a real error in the code, and not have to #ifdef if SECURITY is
> enabled or not (meaning that you can check for NULL for a real error.)

Now that Andrew has changed that (thanks!), the callers in
tpm_bios.c look incorrect.  They only check for 0/non-zero.

Too late for me to fix that tonight.  Maybe *@us.ibm.com can do that.

---
~Randy
