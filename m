Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264365AbVBDXFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbVBDXFi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265766AbVBDXEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 18:04:52 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:3521 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266354AbVBDW7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:59:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Beo11n5E0WZkhm7WtDvX0xa9rUKGyBvPhzm6y9ERODdAFD2vCMjCV8mkYSZl6ZkLM2x61HgDwiJYYv/k8Q7OtQmrPcJvGj0tP4TC8/GYpoQasYIqwRRfF0sqVDgn4KOVeZbsXlmOKWmh05Azya9mVh0jqGEJyE+EuZQvR3J0TSk=
Message-ID: <9e4733910502041459500ae8d3@mail.gmail.com>
Date: Fri, 4 Feb 2005 17:59:47 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Legacy IO spaces (was Re: [RFC] Reliable video POSTing on resume)
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

Can you build a no-op version of these that will run on the x86? That
would allow a single user space API for x86, ia64. Maybe the ppc
people will join too.

Why does this appear in /sys/class/pci_bus/0000:17/? For example on my
x86 system I have a single legacy space but if I do a dir of
/sys/class/pci_bus I show three buses. You wouldn't want the
legacy_io/mem attributes on each of these three buses since that
implies three independent address spaces.

[jonsmirl@jonsmirl pci_bus]$ ls /sys/class/pci_bus
0000:00  0000:01  0000:02

How would things be sorted out so that legacy_io/mem attributes only
appear on my root bridge chip 0000:00 and not on the child buses. I
guess this also means the user space app has to search through the bus
entries.

In order to know how many VGA many simultaneous VGA devices you can
have there needs to be some way to count the number of legacy address
spaces. Maybe there should be a /sys/class/legacy to describe the
legacy spaces. Is it possible to have the same legacy space aliased at
two different addresses depending on which root bus is used to get to
it?

I need to know how to answer these questions:
1) how many legacy spaces are there
2) how many VGA devices are in each space
3) how do I do VGA bus routing to access the VGA device
4) how do I address each of the devices.

-- 
Jon Smirl
jonsmirl@gmail.com
