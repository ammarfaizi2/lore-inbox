Return-Path: <linux-kernel-owner+w=401wt.eu-S932371AbXAONzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbXAONzU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 08:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbXAONzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 08:55:20 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:57353 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932356AbXAONzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 08:55:18 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=bmhnXVhBKe3/k4bL7VRBUttDDy3juizvrbHSw816VK9gsnO/sgB4UZ7VaEIYkIuBfwLhBqxOZnQ9Sey9l1RCKz1mEzXgfdSOby1qIJGaKT81XKyRGTXXyVDJ3F3LdDJCD2qQ/n38nGJRSo7zEydKSBiqoF1F5fP00L9x0Ng/udY=
Message-ID: <45AB87BE.9060304@gmail.com>
Date: Mon, 15 Jan 2007 22:55:10 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Arjan van de Ven <arjan@infradead.org>, Faik Uygur <faik@pardus.org.tr>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ahci_softreset prevents acpi_power_off
References: <fa.enjQgtLFPdSkeJjKv6eOjULTovQ@ifi.uio.no>	 <fa.kpxGqupQMKJxBBFrktFUzuoKc7c@ifi.uio.no> <45A9860D.5080506@shaw.ca>	 <200701141959.40673.faik@pardus.org.tr> <1168797978.3123.997.camel@laptopd505.fenrus.org> <45AAFCC6.9000700@gmail.com> <45AB8553.10301@garzik.org>
In-Reply-To: <45AB8553.10301@garzik.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Arjan van de Ven wrote:
>>> I'd be interested in finding out how to best test this; if the bios is
>>> really broken I'd love to add a test to the Linux-ready Firmware
>>> Developer Kit for this, so that BIOS developers can make sure future
>>> bioses do not suffer from this bug...
>>
>> As reported, this is almost a butterfly effect.  ->softreset method is
>> only used during initialization and error recovery of ATA devices which
>> has almost nothing to do with the rest of the system.  This is almost
>> like 'changing my mixer input to line-in makes power off fail'.  (it's
>> more related due to ATA ACPI stuff and maybe that's why this happens but
>> I'm trying to make a point here.)
> 
> It's quite possible that the BIOS in question wants AHCI in some
> specific state at poweroff.

I would be surprised if this weren't an accident.  We reset the
controller during initialization, so whether softreset or hardreset is
used, the end status cannot be much different.  And, I really don't
wanna change ahci and/or libata for this.

-- 
tejun
