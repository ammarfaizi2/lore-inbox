Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289749AbSBESgf>; Tue, 5 Feb 2002 13:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289750AbSBESg0>; Tue, 5 Feb 2002 13:36:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48398 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289749AbSBESgQ>;
	Tue, 5 Feb 2002 13:36:16 -0500
Message-ID: <3C60261D.2CECD6F4@mandrakesoft.com>
Date: Tue, 05 Feb 2002 13:36:13 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: kernel list <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@osdl.org>
Subject: Re: driverfs support for motherboard devices
In-Reply-To: <20020205173912.GA165@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> This patch adds support for motherboard devices, so that you can see
> them in driverfs.
> 
> Should ide be presented to driverfs as bus with two devices on it?

This is a tough one...  Since there is a typically a single PCI device
for IDE, a PCI or HOST bridge should register an IDE device.  The IDE
device would in turn register two IDE controllers, which would in turn
register up to two disks.

> What about "legacy" bus? It is not in this release, and I'm not 100%
> sure who should generate it. Many architectures will need such bus so
> maybe it belongs in drivers/base in order to avoid duplicate code?

I think one should have a conceptual "system bus" as a virtual parent,
when none is present.  For example my old 486 has PCI, but the only PCI
device is IDE.  There are the standard legacy devices like parallel and
serial, but they do not show up under an ISA bridge device.  This 486
system would be a candidate for this system bus.

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
