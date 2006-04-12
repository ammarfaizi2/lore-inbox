Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWDLW3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWDLW3Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 18:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWDLW3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 18:29:24 -0400
Received: from mail.suse.de ([195.135.220.2]:48778 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932363AbWDLW3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 18:29:23 -0400
Date: Wed, 12 Apr 2006 15:28:36 -0700
From: Greg KH <gregkh@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Greg KH <greg@kroah.com>,
       anton@samba.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix pciehp driver on non ACPI systems
Message-ID: <20060412222836.GD6314@suse.de>
References: <20060406101731.GA9989@krispykreme> <20060406160527.GA2965@kroah.com> <20060406104113.08311cdc.rdunlap@xenotime.net> <20060406174644.GD6598@mars.ravnborg.org> <20060406175704.GA30949@suse.de> <20060406181422.GA6998@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060406181422.GA6998@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 08:14:22PM +0200, Sam Ravnborg wrote:
> On Thu, Apr 06, 2006 at 10:57:04AM -0700, Greg KH wrote:
> > > > > >  #include "../pci.h"
> > > 
> > > When one introdues relative apths like the above this is a good sign
> > > that the header file ought to move to a common place somewhere in
> > > include/.
> > 
> > No, this is a pci-core only header file.  I really don't want to have
> > these in include/linux/pci.h as no one other than the pci core, or pci
> > hotplug drivers need to use it.
> 
> But that hold true for other stuff in include/* also.
> 
> The guideline is (my understanding):
> - Use .h files only when declarations are shared by more than one .c
>   file
> - Put the .h file in same dir as the .c files, iff the .c files are all
>   in same dir (and include using #include "file.h")
> - For bigger subsystems create an include/<subsystem> dir for shared .h
>   files (and include using #include <file.h>)
> - For smaller subsystems create an include/linux/<subsystem> dir for
>   shared .h files (and include using #include <file.h>)
> 
> And then we also have:
> - For Greg's pci-core keep the shared .h file with the .c files
>   (and include using #include "../file.h")

Ok, sometimes I feel special, but never that "special" :)  If you note,
USB also does this for its core files, so there is precidence...

Anyway, is include/linux/pci/pci.h really necessary for just one file?
I guess I could put the msi stuff in there, but again, I really don't
want any driver including it, like they have tried to do so in the
past...

thanks,

greg k-h
