Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbTENQno (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbTENQno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:43:44 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:35567 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262620AbTENQnl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:43:41 -0400
Date: Wed, 14 May 2003 09:57:57 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v3
Message-ID: <20030514165757.GA2378@kroah.com>
References: <20030514032712.0c7fa0d1.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514032712.0c7fa0d1.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 03:27:12AM -0700, Andrew Morton wrote:
> 
> Quite a lot of changes here.  Mostly additions, but some things have been
> crossed off.
> 
> Also at ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix

Here's a patch against must-fix-3.txt that consolodates the 4 different
places people are complaining about a lack of PCI device locking, and
put the bugzilla bug number for it.

As soon as I finish this OLS paper, I'm going to work on finally fixing
this...

thanks,

greg k-h

--- must-fix-3.txt.original	Wed May 14 09:46:43 2003
+++ must-fix-3.txt	Wed May 14 09:52:47 2003
@@ -115,7 +115,11 @@
 
 - alan: Some cardbus crashes the system
 
-- alan: Hotplug locking is hosed
+- We have multiple drivers walking the pci device lists and also using
+  things like pci_find_device in unsafe ways with no refcounting.  I think
+  we have to make pci_find_device etc refcount somewhere and add
+  pci_device_put as was done with networking.
+  http://bugzilla.kernel.org/show_bug.cgi?id=709
 
 drivers/pcmcia/
 ---------------
@@ -567,17 +571,8 @@
 drivers
 =======
 
-- Alan: We have multiple drivers walking the pci device lists and also
-  using things like pci_find_device in unsafe ways with no refcounting.  I
-  think we have to make pci_find_device etc refcount somewhere and add
-  pci_device_put as was done with networking.
-
 - Some network drivers don't even build
 
-- Alan: PCI hotplug is unsafe (locking is totally screwed)
-
-- Ditto cardbus
-
 - Alan: Cardbus/PCMCIA requires all Russell's stuff is merged to do
   multiheader right and so on
 
