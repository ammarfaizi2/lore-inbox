Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136035AbREJCyc>; Wed, 9 May 2001 22:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136044AbREJCyL>; Wed, 9 May 2001 22:54:11 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:2820 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S136035AbREJCyC>;
	Wed, 9 May 2001 22:54:02 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105100253.f4A2rsK305959@saturn.cs.uml.edu>
Subject: Re: Patch to make ymfpci legacy address 16 bits
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Wed, 9 May 2001 22:53:53 -0400 (EDT)
Cc: proski@gnu.org (Pavel Roskin), zaitcev@redhat.com (Pete Zaitcev),
        linux-kernel@vger.kernel.org
In-Reply-To: <3AF9A726.BF819B30@mandrakesoft.com> from "Jeff Garzik" at May 09, 2001 04:23:02 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> Pavel Roskin wrote:

>> You may need to save some data in memory when the system goes
>> to suspend and restore them afterwards. I believe that the PCI
>> config space should be saved by BIOS. Everything else is the
>> responsibility of the driver.
>
> In ACPI land the kernel should save and restore the PCI device
> config space and the PCI bus config space.  It is probably that
> similar is necessary under APM.

When you write "the kernel", do you mean the driver or generic
code? I hope you mean the driver, because I have this:

1. the device looks normal at power on
2. the driver pokes a device-specific config register
3. the config space header changes from type 0 to type 1

(The class code does NOT indicate PCI-to-PCI bridge.
You could say this is like CardBus but much weirder)

If the kernel saves type 1 header data, cuts power using
motherboard features, restores power, and then tries to
restore type 1 header data into a type 0 header... the
system will be well and truly screwed IMHO.

