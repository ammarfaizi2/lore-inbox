Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWCVQHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWCVQHM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWCVQHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:07:12 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:59276 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1750837AbWCVQHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:07:10 -0500
In-Reply-To: <442174B9.4050309@us.ibm.com>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063804.956561000@sorel.sous-sol.org> <442174B9.4050309@us.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <048b633179d2ecffd95c58eada4313fc@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 29/35] Add the Xen virtual console driver.
Date: Wed, 22 Mar 2006 16:07:28 +0000
To: Anthony Liguori <aliguori@us.ibm.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Mar 2006, at 16:00, Anthony Liguori wrote:

> This has always seemed a bit wrong to me and makes a number of things 
> kind of awkward (like a virtual video driver).
>
> It would seem better me to treat this driver as what it really is, a 
> virtual serial device.  It adds a little bit of additional work to the 
> userspace tools (they just have to make sure to pass console=ttyS0) 
> but it seems worth it.

That already works pretty much (userspace tools have to pass 
xencons=ttyS as well as console=ttyS0).

> We could also solve the tty[0-9] problem by implementing a proper 
> console driver that could use multiple virtual serial devices if we 
> wanted to go that route.

Yes, that could live alongside this driver.

> Another option would be to just emulate a serial driver.  The console 
> driver isn't really performance critical.  It seems to me that it's a 
> bit unnecessary to even bother paravirtualizing the console device 
> when it's so easy to emulate.

Easy except that Xen can't implement the 'console backend', or at least 
not easily. The console bits need to end up in management virtual 
machine's user space. We'd have to do something skanky like the current 
HVM qemu model.

  -- Keir

