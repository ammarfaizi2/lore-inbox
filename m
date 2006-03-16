Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932732AbWCPV3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732AbWCPV3d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 16:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbWCPV3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 16:29:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61111 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932685AbWCPV3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 16:29:32 -0500
Date: Thu, 16 Mar 2006 13:26:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
Message-Id: <20060316132639.274691d6.akpm@osdl.org>
In-Reply-To: <20060316164932.GT27946@ftp.linux.org.uk>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
	<20060316164932.GT27946@ftp.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:
>
> On Thu, Mar 16, 2006 at 02:01:28AM -0800, akpm@osdl.org wrote:
>  > 
>  > From: Andrew Morton <akpm@osdl.org>
>  > 
>  > We have no less than 65 implementations of TRUE and FALSE in the tree, so the
>  > inevitable happened:
>  > 
>  > In file included from drivers/pci/hotplug/ibmphp_core.c:40:
>  > drivers/pci/hotplug/ibmphp.h:409:1: warning: "FALSE" redefined
>  > In file included from include/acpi/acpi.h:55,
>  >                  from drivers/pci/hotplug/pci_hotplug.h:187,
>  >                  from drivers/pci/hotplug/ibmphp.h:33,
>  >                  from drivers/pci/hotplug/ibmphp_core.c:40:
>  > include/acpi/actypes.h:336:1: warning: this is the location of the previous definition
>  > 
>  > The patch implements TRUE and FALSE in include/linux/kernel.h and removes all
>  > the private versions.
> 
>  NAK.  Simply remove those and be done with that.  It's bad style and we
>  certainly don't need to propagate that lossage.

No, it is not bad style.

It is bad that the C design failed to distinguish between booleans and
scalars.  These are quite different concepts and it is a gruesome kludge to
go and use a scalar when a boolean is what was intended.

There are readability (and hence maintainability) advantages in using
boolean types for boolean variables.

Yes, the use of scalars in this manner is an (ancient, old-fashioned) C
idiom.  But it is one which was forced on us by shortcomings in the
language.  Times change.  Just because something is idiomatic doesn't mean
that it is either good or right.  If C had had proper boolean support back
in the old days then using scalars as booleans would be frowned upon.

C99 does have boolean support, so the proper thing to do is to start
using it - implement stdbool.h, fix up fallout, start fixing subsystems. 
Given that, and as Greg has fixed up this particular build error I'll drop
the patch.

(It's a shame that the compiler doesn't preperly enforce boolean
typechecking, but sparse could do that).
