Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263467AbUGRJ5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbUGRJ5s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 05:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUGRJ5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 05:57:48 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:3295 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263467AbUGRJ5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 05:57:45 -0400
Message-ID: <40FA498D.7040309@t-online.de>
Date: Sun, 18 Jul 2004 11:57:33 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040717
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Harald Dunkel <harald.dunkel@t-online.de>
Subject: Re: amd64, 2.6.7: several problems
References: <40FA1A69.4090902@t-online.de>
In-Reply-To: <40FA1A69.4090902@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: bHhLtqZdgedJx7bwpA1bo1-Vqp36Ro42VHVSVrRhqUqm6xPDkmpkYt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:
> 
> Next powernow-k8 refuses to load on my PC:
> 
> # modprobe powernow-k8
> FATAL: Error inserting powernow_k8 
> (/lib/modules/2.6.7/kernel/arch/x86_64/kernel/cpufreq/powernow-k8.ko): 
> No such device
> 
> This is strange. AFAIK all amd64 CPUs do have Powernow.
> The ACPI modules (expecially processor), freq_table and cpuid
> were all loaded. Whats wrong here?
> 

PS: dmesg said

powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09b)
powernow-k8: BIOS error - no PSB

I found this in powernow-k8.c.

:
if (powernow_k8_cpu_init_acpi(data)) {
	/*
	 * Use the PSB BIOS structure. This is only availabe on
	 * an UP version, and is deprecated by AMD.
	 */

	if (pol->cpu != 0) {
:
:

i.e. PSB is deprecated. Only if some lookup via ACPI fails, then
the kernel tries PSB. If this fails, too, then it prints an error
message.

The problem is, why does the kernel print an error message
just about the deprecated PSB, if some ACPI stuff doesn't work
as expected?

Would it be possible to add a warning message to
powernow_k8_cpu_init_acpi(), saying something like

	powernow-k8: initialization via ACPI failed,
		trying deprecated PSB structure


Regards

Harri

