Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWEEUfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWEEUfT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 16:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbWEEUfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 16:35:19 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:42420 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751023AbWEEUfS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 16:35:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tv8Z8nz1taObrWq7DM+RVwd+xXeVs/qx8kP1ICnUaZWxvcDhHDEY1g7U/doVkJ0Dfed9Lc6pH6zdRMrC3/pxpq39+O5zipMpzM7dyULocGdd7LEknfoWqBRE5/8NmMbvDYf1zWLgsA4TaS3acfbX6xT5KCFuVGTbTwnDECMueU8=
Message-ID: <9e4733910605051335h7a98670ie8102666bbc4d7cd@mail.gmail.com>
Date: Fri, 5 May 2006 16:35:17 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Ian Romanick" <idr@us.ibm.com>, "Dave Airlie" <airlied@linux.ie>,
       "Arjan van de Ven" <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060505202603.GB6413@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605041326.36518.bjorn.helgaas@hp.com>
	 <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com>
	 <1146776736.27727.11.camel@localhost.localdomain>
	 <mj+md-20060504.211425.25445.atrey@ucw.cz>
	 <1146778197.27727.26.camel@localhost.localdomain>
	 <9e4733910605041438q5bf3569bs129bf2e8851b7190@mail.gmail.com>
	 <1146784923.4581.3.camel@localhost.localdomain>
	 <445BA584.40309@us.ibm.com>
	 <9e4733910605051314jb681476y4b2863918dfae1f8@mail.gmail.com>
	 <20060505202603.GB6413@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/06, Greg KH <greg@kroah.com> wrote:
> On Fri, May 05, 2006 at 04:14:00PM -0400, Jon Smirl wrote:
> > I would like to see other design alternatives considered on this
> > issue. The 'enable' attribute has a clear problem in that you can't
> > tell which user space program is trying to control the device.
> > Multiple programs accessing the video hardware with poor coordination
> > is already the source of many problems.
>
> Who cares who "enabled" the device.  Remember, the majority of PCI
> devices in the system are not video ones.  Lots of other types of
> devices want this ability to enable PCI devices from userspace.  I've
> been talking with some people about how to properly write PCI drivers in
> userspace, and this attribute is a needed part of it.

User space program enables the device.
Next I load a device driver
next I rmmod the device driver and it disables the device
user space program trys to use the device
No coordination and user space program faults

Don't say this can't happen, it is a current source of conflict
between X and fbdev.

Should we just remove the ability to disable hardware?
How would that interact with hotplug?

> And if X gets enabling the device wrong, again, who cares, it's not a
> kernel issue. :)
>
> thanks,
>
> greg k-h
>


--
Jon Smirl
jonsmirl@gmail.com
