Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbTKTPdT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 10:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbTKTPdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 10:33:19 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:52211 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261914AbTKTPdR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 10:33:17 -0500
Content-Type: text/plain;
  charset="utf-8"
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: Olaf Hering <olh@suse.de>, Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] udev 006 release
Date: Thu, 20 Nov 2003 07:25:34 -0800
User-Agent: KMail/1.4.1
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       christophe.varoqui@free.fr, patmans@us.ibm.com
References: <20031119162912.GA20835@kroah.com> <20031119234708.GC23529@kroah.com> <20031120065920.GC14930@suse.de>
In-Reply-To: <20031120065920.GC14930@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200311200725.34868.dsteklof@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 November 2003 10:59 pm, Olaf Hering wrote:
>  On Wed, Nov 19, Greg KH wrote:
> > 	- I've added two external programs to the udev tarball, under
> > 	  the extras/ directory.  They are the scsi-id program from Pat
> > 	  Mansfield, and the multipath program from Christophe Varoqui.
> > 	  Both of them can work as CALLOUT programs.  I don't think they
> > 	  currently build properly within the tree, by linking against
> > 	  klibc, but patches to their Makefiles to fix this would be
> > 	  gladly accepted :)
>
> There is no make install target for the headers and the libs. Both
> packages disgree on the location. I use the patch below. Can you make a
> decision where the headers should be located?


As a note, the package sysfsutils that contains libsysfs installs the headers 
into /usr/include/sysfs. Are we going to have conflicts since udev has its 
own private libsysfs statically included? Should the extra programs build off 
udev's libsysfs, since they are included with the package? Or, should they 
require a shared libsysfs from sysfsutils? If udev is to have its own static 
edition of libsysfs, perhaps it'd be best if it didn't install headers and 
the extras either used its static version or required the shared libsysfs to 
be installed.

Thanks,

Dan


> --- scsi_id/scsi_id.c
> +++ scsi_id/scsi_id.c	2003/11/19 21:25:38
> @@ -33,7 +33,7 @@
>  #include <stdarg.h>
>  #include <ctype.h>
>  #include <sys/stat.h>
> -#include <sys/libsysfs.h>
> +#include <libsysfs.h>
>  #include "scsi_id.h"
>
>  #ifndef VERSION
> --- scsi_id/scsi_serial.c
> +++ scsi_id/scsi_serial.c	2003/11/19 21:25:42
> @@ -31,7 +31,7 @@
>  #include <unistd.h>
>  #include <syslog.h>
>  #include <scsi/sg.h>
> -#include <sys/libsysfs.h>
> +#include <libsysfs.h>
>  #include "scsi_id.h"
>  #include "scsi.h"

