Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267963AbUIPNaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267963AbUIPNaS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 09:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268058AbUIPNaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 09:30:18 -0400
Received: from host62-24-231-115.dsl.vispa.com ([62.24.231.115]:1415 "EHLO
	orac.walrond.org") by vger.kernel.org with ESMTP id S267963AbUIPNaI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 09:30:08 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: lost memory on a 4GB amd64
Date: Thu, 16 Sep 2004 14:30:06 +0100
User-Agent: KMail/1.7
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
In-Reply-To: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409161430.06901.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei,

I have the same board with 4Gb ram running a 64bit 2.6.8.1 and solved it by 
changing something in the bios. Let me reboot and I'll take a note of what I 
did...

On Thursday 16 Sep 2004 05:48, Sergei Haller wrote:
> Hello,
>
> A friend of mine has a new Opteron based machine (Tyan Tiger K8W with two
> Opteron 24?) and 4GB main memory.
>
> the problem is that about 512 MB of that memory is lost (AGP aperture and
> stuff). Although everything is perfect otherwise.
> As far as I understand, all the PCI/AGP hardware uses the top end of the
> 4GB address range to access their memory and there is just an
> "overlapping" of the addresses. thus only the remaining 3.5 GB are
> available.
>
>
> Now there is an option in the BIOS called "Adjust Memory" which puts a
> certain amount of memory (several choices between 64MB and 2GB) above the
> 4GB address range. I tried the 2GB setting which results in 2GB main
> memory at addresses 0-2GB and 2GB memory at addresses 4GB-6GB.
>
> the problem is that the kernel (2.6.3-9mdksmp and vanilla 2.6.8.1) crashes
> if this option is enabled as soon as some memory expensive program is run
> (e.g. X)
>
> I've seen some postings on the net talking about some "kernel patch" for
> some "memory split", but nothing more specific. Do I just need a certain
> patch to get it working or is there more to it?
>
>
>
> BTW, the memory map displayed at boot is
>
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 00000000d3ff0000 (usable)
>  BIOS-e820: 00000000d3ff0000 - 00000000d3fff000 (ACPI data)
>  BIOS-e820: 00000000d3fff000 - 00000000d4000000 (ACPI NVS)
>  BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
>
> if I leave the 4GB memory in one chunk and
>
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
>  BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
>  BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
>  BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
>  BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
>
> if I enable the "adjust memory" option and split the memory in two 2GB
> blocks.
>
> Thanks in advance,
>
>         Sergei
