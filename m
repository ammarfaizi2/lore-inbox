Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757214AbWK0Hhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757214AbWK0Hhu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 02:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757265AbWK0Hhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 02:37:50 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:42140 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1757214AbWK0Hht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 02:37:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=pzzuPXf8bgtBAEj/zKtxc9FyNWCWuq4JOxxLefqLkU2FECFh4sP9ZvfJQxF0myNY/pEjFuoRDD8edccZ/Z4qvLcw8DHFvhLaNIH6v+5DGKM5SuMOrXi6gGzfXi8G1yqFZ/xbRXfWaTyniKBJ18k990DSO+kWws3vSKAOfqI65XE=
Message-ID: <86802c440611262337o76e5a90cye42602f6295d74a1@mail.gmail.com>
Date: Sun, 26 Nov 2006 23:37:47 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Len Brown" <lenb@kernel.org>
Subject: Re: [PATCH 3/3] x86: when acpi_noirq is set, use mptable instead of MADT
Cc: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200611270037.53964.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <86802c440611261524p6b170f50rf7db3eafd4f7602e@mail.gmail.com>
	 <200611270037.53964.len.brown@intel.com>
X-Google-Sender-Auth: 13a534d8f870a8fe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/06, Len Brown <len.brown@intel.com> wrote:
>
> So the bigger question is why you need these workarounds in the first place.

in the LinuxBIOS, acpi support is there including acpi tables and dsdt
for amd chipset.
but for other chipset, I can not put dsdt there. becase we need one
clean room implementation for dsdt with those chipset.

So I have all acpi tables (SRAT, SLIT, ...) but no dsdt.
We need to use mptable instead of MADT + dsdt for io apic irq routing.

I forget to remove MADT in one test, the kernel will skip the mptable.

After look at the kernel acpi code, it turns out that
acpi_process_madt will set acpi_lapic, and acpi_ioapic.  So
get_smp_config will skip the mptable.

With normal BIOS, if there is problem with DSDT, and you are trying
acpi=noirq, it means you are going to PIC mode instead of APIC mode if
you are skipping mptable.

YH
