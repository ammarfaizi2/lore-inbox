Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751723AbWG0QmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbWG0QmN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 12:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbWG0QmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 12:42:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:29288 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751723AbWG0QmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 12:42:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EFeha3UJtjHBPDpLsJCnhoANvQ7heZutcVQpc8jpC7mbUaUogHwvjlMW4MFfHK/DUBCAjU4sTfHIQDK6d7nSYCGawKRxih0f3kq9k6KgX/W7RIxexUwDVwM9465FvoWpRtX3gePBDVERkiOMrsvWWHJY7Y4txDilOe/rUeAaGQM=
Message-ID: <41840b750607270942l7a53010du1fabcf2a4b492789@mail.gmail.com>
Date: Thu, 27 Jul 2006 19:42:10 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] DMI: Decode and save OEM String information
Cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Matt Domsch" <Matt_Domsch@dell.com>,
       "Brown, Len" <len.brown@intel.com>,
       "Henrique de Moraes Holschuh" <hmh@debian.org>
In-Reply-To: <200607271010.53489.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <41840b750607270647w5a05ad00r613dbaf42bf04771@mail.gmail.com>
	 <200607271010.53489.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/27/06, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> I always thought that ACPI was supposed to describe everything that
> (a) consumes resources or requires a driver and (b) is not enumerable
> by other hardware standards such as PCI.
>
> If that's true, isn't it a BIOS defect if this embedded controller isn't
> described via ACPI?

The ThinkPad ACPI tables do list the relevant IO ports (0x1600-0x161F)
as reserved, but provide no way to discern what's behind them. Other
machines have different hardware on the same ports.

BTW, I should clarify that this embedded controller interface (used by
hdaps and tp_smapi) is different than the standard ACPI EC interface,
and goes through different IO ports.


> it seems like the ideal way forward
> would be to get the BIOS fixed so you could claim the device with PNP
> for future ThinkPads, and the table of OEM strings would not require
> ongoing maintenance.

This is unrealistic. The hdaps and tp_smapi drivers support dozens of
ThinkPad models, each with a different BIOS.

For the tp_smapi driver, AFAIK the only completely safe alternative to
this patch is a frequently-updated whitelist of over a hundred models,
identified by the existing DMI attributes.

  Shem
