Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbVHVTnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVHVTnz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 15:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVHVTnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 15:43:55 -0400
Received: from smtp.istop.com ([66.11.167.126]:26556 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1750741AbVHVTny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 15:43:54 -0400
From: Daniel Phillips <phillips@istop.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] Permissions don't stick on ConfigFS attributes
Date: Mon, 22 Aug 2005 15:44:07 -0400
User-Agent: KMail/1.8
Cc: Greg KH <greg@kroah.com>, Joel Becker <Joel.Becker@oracle.com>,
       linux-kernel@vger.kernel.org
References: <200508201050.51982.phillips@istop.com> <20050820030117.GA775@kroah.com> <m18xyuvanj.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m18xyuvanj.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200508221544.07223.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 August 2005 00:49, Eric W. Biederman wrote:
> I am confused.  I am beginning to see shades of the devfs problems coming
> up again.  sysfs is built to be world readable by everyone who has it
> mounted in their namespace.  Writable files in sysfs I have never
> understood.

Sysfs is not like devfs by nature, it is more like procfs.  It exposes 
properties of a device, not the device itself.  It makes perfect sense that 
some of the properties should be writeable.

> Given that we now have files which do not conform to one uniform
> policy for everyone is there any reason why we do not want to allocate
> a character device major number for all config values and dynamically
> allocate a minor number for each config value?  Giving each config
> value its own unique entry under /dev.

/dev is already busy enough without adding masses of entries that are not 
devices.  I don't see that this would simplify the internal implementation 
either, the opposite actually.  The user certainly will not have any use for 
temporary device numbers in this context.

On the other hand, it is clunky to force an application to go through the same 
parse/format interface as the user just to get/set a simple integer.  Perhaps 
sysfs needs to be taught how to ioctl these properties.  I see exposing 
property names and operating on them as orthogonal issues that are currently 
joined at the hip in an unnatural, but fixable way.

> Device nodes for each writable config value trivially handles
> persistence and user policy and should be easy to implement in the
> kernel.  We already have a policy engine in userspace, udev to handle
> all of the chaos.
>
> Why do we need another mechanism?

We need the mechanism that exposes subsystem instance properties as they 
appear and disappear with changing configuration.  This is a new mechanism 
anyway, so implementing it using device nodes does not save anything, it only 
introduces a new requirement to allocate device numbers.

> Are device nodes out of fashion these days?

They are, at least for putting things in /dev that are not actual hardware.

Regards,

Daniel
