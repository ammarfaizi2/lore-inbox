Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVCEV05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVCEV05 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 16:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVCEV05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 16:26:57 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:13253 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261175AbVCEV0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 16:26:54 -0500
Message-ID: <422A23FB.2010707@ens-lyon.org>
Date: Sat, 05 Mar 2005 22:26:19 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>, seife@suse.de,
       Len Brown <len.brown@intel.com>
Subject: Re: s4bios: does anyone use it?
References: <20050305191405.GA1463@elf.ucw.cz> <422A1FB6.3000504@ens-lyon.org> <20050305211747.GF1424@elf.ucw.cz>
In-Reply-To: <20050305211747.GF1424@elf.ucw.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek a écrit :
> Can you try cat /proc/acpi/sleep? If there's no difference between S4
> and S4bios, than you are probably just using plain S4...

puligny:~% cat /proc/acpi/sleep
S0 S1 S3 S4 S4bios S5

Where am I suppose to see a difference between S4 and S4Bios here ?


 From what I see in acpi_system_write_sleep in drivers/acpi/sleep/proc.c
4 uses software_suspend while 4b uses acpi_suspend(4)
(SOFTWARE_SUSPEND is set in my .config)
Is this code the right one ?

         /* Check for S4 bios request */
         if (!strcmp(str,"4b")) {
                 error = acpi_suspend(4);
                 goto Done;
         }
         state = simple_strtoul(str, NULL, 0);
#ifdef CONFIG_SOFTWARE_SUSPEND
         if (state == 4) {
                 error = software_suspend();
                 goto Done;
         }
#endif
         error = acpi_suspend(state);

> Yes, but it will take quite long to do it properly. pm_message_t
> framework needs to go in, first.

Ok, great! I'll be happy to test it soon :)

Brice
