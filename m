Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWEBQiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWEBQiN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWEBQiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:38:12 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:33784 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964921AbWEBQiL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:38:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N6t0GNxIWXFJnQYXAWum81c++leRS1dfo5VgZ2OFjHPuLwC3TfPF6oUaIuvDll0lolZAxaZhRsKMbfn5xqnryN2cWDppeL0ZVYVfqqLhEcugwGwhiewvn51T73007gdtQBwvjiu1IpzEJhXQl5IotbdeVZg8bbbnLgkySP3IC0U=
Message-ID: <9e4733910605020938h6a9829c0vc70dac326c0cdf46@mail.gmail.com>
Date: Tue, 2 May 2006 12:38:11 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Arjan van de Ven" <arjan@linux.intel.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, airlied@linux.ie, pjones@redhat.com,
       akpm@osdl.org
In-Reply-To: <1146300385.3125.3.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/06, Arjan van de Ven <arjan@linux.intel.com> wrote:
> This patch adds an "enable" sysfs attribute to each PCI device. When read it
> shows the "enabled-ness" of the device, but you can write a "0" into it to
> disable a device, and a "1" to enable it.

What is the rationale for this? Doing this encourages people to write
device drivers in user space that probably should be a kernel driver.
What are you going to do if two competing apps want to set it to two
different states?

An alternate way to fix this problem is to write a device driver that
attaches to hardware with PCI class VGA. The driver could then provide
a device for each card found. By opening the device you can control
who owns and enables it.

We already have a lot of problems with multiple drivers trying to
control a single piece of hardware. Adding an "enable" attribute makes
it even easier to build conflicting drivers.

--
Jon Smirl
jonsmirl@gmail.com
