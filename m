Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbVBDUoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbVBDUoH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265831AbVBDUjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:39:11 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:21290 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261893AbVBDU3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:29:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=AA67w0jNjzBqvd/bLpsJeXBn0OfKsDmBaCRANXfCs/DxkKkm1vUUiww2MObE+NSLenM/mZQs6vQfeoLc+7aScg+7MC3T6bVhtXGGeJetbDN3guat2XJCMSfQGlgNkLl4X2EOIRLW0DDsarldiTE6EtQSCNP5Pm+CoNVMZXAyVSQ=
Message-ID: <9e473391050204122942da8aa7@mail.gmail.com>
Date: Fri, 4 Feb 2005 15:29:45 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: [RFC] Reliable video POSTing on resume
Cc: Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>
In-Reply-To: <200502041010.13220.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050122134205.GA9354@wsc-gmbh.de>
	 <20050204163019.GC1290@elf.ucw.cz>
	 <9e4733910502040931955f5a6@mail.gmail.com>
	 <200502041010.13220.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005 10:10:12 -0800, Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> Jon does your emulator sit on top of the new legacy I/O and memory APIs?  I
> added them for this very reason, though atm only ia64 supports them.  There's
> documentation in Documentation/filesystems/sysfs-pci.txt if you want to take

The link I am posting is to the original scitech code which is free to
use. I have a bunch of versions on my local machine but none are up to
using all of the new sysfs APIs. Looking at the sysfs calls it is
simple to convert the reset app to use them. The reset app is already
trapping the io/out instructions.

Instead I have been concentrating on feeding new babies and getting
the last two pieces of kernel support in. We still need a solution for
VGA routing (I posted on but the design needs work) and making the
initial user space call out.

I would prefer to use hotplug for the user space call out but when I
do I run into the framebuffer and DRM drivers. This having multiple
drivers for the same piece of hardware is a pain. So hotplug on the
standard device is not an option.

Other options would be to directly call_usermodehelper() or create a
temporary class device for each VGA card as it is found. The temp VGA
device would trigger the reset app. They would be temp since there may
be multiple ones.

-- 
Jon Smirl
jonsmirl@gmail.com
