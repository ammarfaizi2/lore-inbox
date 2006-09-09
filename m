Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWIIGP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWIIGP2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 02:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWIIGP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 02:15:28 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:57258 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932311AbWIIGP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 02:15:27 -0400
Message-ID: <45025BD1.9020106@myri.com>
Date: Sat, 09 Sep 2006 02:14:41 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Brandon Philips <brandon@ifup.org>
CC: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Robert Love <rml@novell.com>
Subject: Re: 2.6.18-rc6-mm1 2.6.18-rc5-mm1 Kernel Panic on X60s
References: <20060908174437.GA5926@plankton.ifup.org> <20060908121319.11a5dbb0.akpm@osdl.org> <20060908194300.GA5901@plankton.ifup.org> <20060908125053.c31b76e9.akpm@osdl.org> <m1slj1iurx.fsf@ebiederm.dsl.xmission.com> <20060908222141.564e3b2a.akpm@osdl.org> <4502558B.1010103@myri.com> <20060909060106.GB6364@plankton.ifup.org>
In-Reply-To: <20060909060106.GB6364@plankton.ifup.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brandon Philips wrote:
> On 01:47 Sat 09 Sep 2006, Brice Goglin wrote:
>> Do we have Brandon lspci so that I can see if any of the MSI quirks is
>> involved?
>
> 00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT Express Memory Controller Hub (rev 03)
> 00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 02) (prog-if 00 [Normal decode])
> 00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 (rev 02) (prog-if 00 [Normal decode])
> 00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 3 (rev 02) (prog-if 00 [Normal decode])
> 00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 4 (rev 02) (prog-if 00 [Normal decode])
> 00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2) (prog-if 01 [Subtractive decode])
>   

There is no MSI quirk for these chipsets, MSI work fine on Intel.

Let me know if your dichotomy leads to one of the following patches:

1) gregkh-pci-msi-cleanup-existing-msi-quirks.patch
2) gregkh-pci-msi-factorize-common-code-in-pci_msi_supported.patch
3) gregkh-pci-msi-export-the-pci_bus_flags_no_msi-flag-in-sysfs.patch
4)
gregkh-pci-msi-blacklist-pci-e-chipsets-depending-on-hypertransport-msi-capability.patch
5)
fix-gregkh-pci-msi-blacklist-pci-e-chipsets-depending-on-hypertransport-msi-capability.patch

(only (1) and (2) should be relevant here)

thanks,
Brice

