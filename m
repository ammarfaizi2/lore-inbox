Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbVBBW5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVBBW5V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 17:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVBBW5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 17:57:21 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:12163 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S262348AbVBBW5B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 17:57:01 -0500
Date: Wed, 2 Feb 2005 17:56:57 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: Greg Kroah-Hartman <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Please open sysfs symbols to proprietary modules
Message-ID: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm writing a module under a proprietary license.  I decided to use sysfs 
to do the configuration.  Unfortunately, all sysfs exports are available 
to GPL modules only because they are exported by EXPORT_SYMBOL_GPL.

I have found the original e-mail where this change was proposed:
http://www.ussg.iu.edu/hypermail/linux/kernel/0409.3/0345.html

Patrick writes:

"The users of these functions are all, in most cases, other subsystems, 
which provide a layer of abstraction for the downstream users (drivers, 
etc)."

Maybe it was true in September 2004, but it's not true in February 2005. 
sysfs has become a standard way to make configurable parameters available 
to userspace, just like sysctl and ioctl.

All I want to do is to have a module that would create subdirectories for 
some network interfaces under /sys/class/net/*/, which would contain 
additional parameters for those interfaces.  I'm not creating a new 
subsystem or anything like that.  sysctl is not good because the data is 
interface specific.  ioctl on a socket would be OK, although it wouldn't 
be easily scriptable.  The restriction on sysfs symbols would just force 
me to write a proprietary userspace utility to set those parameters 
instead of using a shell script.

My understanding is that EXPORT_SYMBOL_GPL is only useful for symbols so 
specific to the kernel that the modules that use them would be effectively 
based on GPL code.  But a module providing its internal state to the 
userspace doesn't need to be based on the kernel code in any way.

Please replace every EXPORT_SYMBOL_GPL with EXPORT_SYMBOL in fs/sysfs/*.c

-- 
Regards,
Pavel Roskin
