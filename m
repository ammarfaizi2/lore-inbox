Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbUKJWa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbUKJWa1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 17:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbUKJWa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 17:30:27 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19976 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262053AbUKJWaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 17:30:21 -0500
Date: Wed, 10 Nov 2004 22:30:16 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: Greg KH <greg@kroah.com>,
       Hotplug List <linux-hotplug-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kobject: fix double kobject_put in kobject_unregister()
Message-ID: <20041110223016.C26346@flint.arm.linux.org.uk>
Mail-Followup-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
	Greg KH <greg@kroah.com>,
	Hotplug List <linux-hotplug-devel@lists.sourceforge.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20041110141923.A13668@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041110141923.A13668@unix-os.sc.intel.com>; from anil.s.keshavamurthy@intel.com on Wed, Nov 10, 2004 at 02:19:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 02:19:23PM -0800, Keshavamurthy Anil S wrote:
> Hi Greg,
> 	
> This patch fixes the problem where in kobject resources were getting
> freed when those kobject were still in use due to double kobject_put()
> getting called in the kobject_unregister() code path.

Isn't it intended that, after an sysfs/kobject/device object is
unregistered that the thread doing the unregistering must not
dereference the memory associated with that object?

IOW, the sequence:

	allocate
	register	(refcount >= 2 after this completes)
	unregister

will automatically free the object once the last user has gone.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
