Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030671AbWFOPWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030671AbWFOPWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 11:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030672AbWFOPWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 11:22:50 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:33432 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1030671AbWFOPWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 11:22:50 -0400
Message-ID: <44917B30.9010904@cmu.edu>
Date: Thu, 15 Jun 2006 11:22:24 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: cdrom support with thinkpad x6 ultrabay
References: <4490E776.7080000@cmu.edu> <4490F4BC.1040300@goop.org> <44910B54.8000408@cmu.edu> <44910E2A.5090205@goop.org>
In-Reply-To: <44910E2A.5090205@goop.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I applied the acpi-dock patch that I specified, and that patch only, and
i'm getting errors building:

drivers/acpi/dock.c: In function 'dock_notify':
drivers/acpi/dock.c:543: error: 'KOBJ_DOCK' undeclared (first use in
this function)
drivers/acpi/dock.c:543: error: (Each undeclared identifier is reported
only once
drivers/acpi/dock.c:543: error: for each function it appears in.)
drivers/acpi/dock.c:562: error: 'KOBJ_UNDOCK' undeclared (first use in
this function)

Is there something else I need to apply that I am missing?

Thanks!
George


Jeremy Fitzhardinge wrote:
> George Nychis wrote:
>> it successfully is applied, and i notice that CONFIG_ACPI_DOCK needs to
>> be set, so I did a "make oldconfig" after applying the patch, expecting
>> it to ask me whether or not i wanted to support it... it didn't.  So
>> then I manually added "CONFIG_ACPI_DOCK=y" to the .config and built the
>> kernel, but dock.o is never built... what else do i need to do?
>>   
> 
> Make sure you disable the (obsolete?) ACPI_IBM_DOCK stuff.
> 
>> If i can't get hot swappable support yet, I might as well get what is
>> supported for now so I can atleast use it sometimes :)
>>
>> Maybe this cry for help will spark someone to finish off the work on hot
>> swapping the optical drive.
>>   
> 
> Yeah, I'm hoping all the work on power management in libata will make
> things "just work" soon, but I think there's more to it.  When you press
> the dock eject button, it really needs to go out to acpid, activate a
> script to unmount any filesystems mounted off the device, and then poke
> the ata layer to remove the device, before OKing the dock eject so the
> hardware's "don't do that" light goes out.
> 
> But in the meantime I'm having enough trouble getting plain old
> suspend/resume reliable.
> 
>    J
> 
