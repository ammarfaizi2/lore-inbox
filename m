Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWDFSOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWDFSOk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 14:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWDFSOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 14:14:40 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:8209 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932204AbWDFSOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 14:14:40 -0400
Date: Thu, 6 Apr 2006 20:14:22 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg KH <gregkh@suse.de>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Greg KH <greg@kroah.com>,
       anton@samba.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix pciehp driver on non ACPI systems
Message-ID: <20060406181422.GA6998@mars.ravnborg.org>
References: <20060406101731.GA9989@krispykreme> <20060406160527.GA2965@kroah.com> <20060406104113.08311cdc.rdunlap@xenotime.net> <20060406174644.GD6598@mars.ravnborg.org> <20060406175704.GA30949@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060406175704.GA30949@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 10:57:04AM -0700, Greg KH wrote:
> > > > >  #include "../pci.h"
> > 
> > When one introdues relative apths like the above this is a good sign
> > that the header file ought to move to a common place somewhere in
> > include/.
> 
> No, this is a pci-core only header file.  I really don't want to have
> these in include/linux/pci.h as no one other than the pci core, or pci
> hotplug drivers need to use it.

But that hold true for other stuff in include/* also.

The guideline is (my understanding):
- Use .h files only when declarations are shared by more than one .c
  file
- Put the .h file in same dir as the .c files, iff the .c files are all
  in same dir (and include using #include "file.h")
- For bigger subsystems create an include/<subsystem> dir for shared .h
  files (and include using #include <file.h>)
- For smaller subsystems create an include/linux/<subsystem> dir for
  shared .h files (and include using #include <file.h>)

And then we also have:
- For Greg's pci-core keep the shared .h file with the .c files
  (and include using #include "../file.h")

See why this sticks out a bit.

Not that I imply the above guidlines are strictly followed - but thats
the best I have seen.

	Sam
