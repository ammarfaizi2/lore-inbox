Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132950AbRAQSTl>; Wed, 17 Jan 2001 13:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135444AbRAQSTc>; Wed, 17 Jan 2001 13:19:32 -0500
Received: from heffalump.fnal.gov ([131.225.9.20]:7852 "EHLO fnal.gov")
	by vger.kernel.org with ESMTP id <S132950AbRAQSTW>;
	Wed, 17 Jan 2001 13:19:22 -0500
Date: Wed, 17 Jan 2001 12:19:16 -0600
From: Paul Hubbard <phubbard@fnal.gov>
Subject: Re: 4G SGI quad Xeon -memory-related slowdowns
Cc: linux-kernel@vger.kernel.org
Message-id: <3A65E224.72826E01@fnal.gov>
Organization: Fermilab
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <ut24rz074jw.fsf@lydia.adaptive.net>
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Sounds like a true-to-God bug. Possibly in the form of incorrect MTRR
> settings. Make sure you enable MTRR support.

MTRR is enabled - here's the dump from /proc/mtrr:

reg00: base=0xc0000000 (3072MB), size=1024MB: uncachable, count=1
reg01: base=0x00000000 (   0MB), size=4096MB: write-back, count=1
reg02: base=0x100000000 (4096MB), size=1024MB: write-back, count=1

Note that the sizes sum to six gigabytes, and we only have four in the
box. 

We've discovered that if we turn off PCI hotplug support and resource
remapping in the BIOS, then /proc/mtrr looks more sensible:

reg00: base=0xfc000000 (4032MB), size=  64MB: uncachable, count=1
reg01: base=0x00000000 (   0MB), size=4096MB: write-back, count=1

However, the 64G-compiled kernel still hangs. 

The complete task dump is at http://quirk.fnal.gov/xeon/ 
It looks like everything is blocked on lock_get_status.

> I do need more information on what seems to hang, and how it hangs. One
> of the pre-kernels will give you a nice stack backtrace for each process
> if you press control-scrolllock, and that might be useful.

Sysreq dump, plus meminfo and MTRR are at the above URL. Please let me
know if you need any other information.

FYI, with the revised BIOS settings, even the 4G-compiled kernel sees
and uses the full 4G. So if this problem turns out to take time to fix,
we can still get full use from the machine in the interim. 

Many thanks for the help!

-Paul

-- 
Paul Hubbard  phubbard@fnal.gov
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
