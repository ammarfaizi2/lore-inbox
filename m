Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbVLMSK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbVLMSK6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbVLMSK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:10:57 -0500
Received: from fmr20.intel.com ([134.134.136.19]:7903 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932523AbVLMSK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:10:56 -0500
Date: Tue, 13 Dec 2005 10:14:17 -0800
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-Id: <20051213101417.13fdb14c.randy_d_dunlap@linux.intel.com>
In-Reply-To: <20051208030242.GA19923@srcf.ucam.org>
References: <20051208030242.GA19923@srcf.ucam.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
X-Face: "}I"O`t9.W]b]8SycP0Jap#<FU!b:16h{lR\#aFEpEf\3c]wtAL|,'>)%JR<P#Yg.88}`$#
 A#bhRMP(=%<w07"0#EoCxXWD%UDdeU]>,H)Eg(FP)?S1qh0ZJRu|mz*%SKpL7rcKI3(OwmK2@uo\b2
 GB:7w&?a,*<8v[ldN`5)MXFcm'cjwRs5)ui)j
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

I have a few comments and a question on this patch, please.
(Yes, I know it won't be merged.)
Most of these are general patch process comments.
However, the last comment is the important one.

1.  I had problems applying it.  What tree is it against?
    Say so in the description.

2.  use diff -p (in SubmittingPatches)

3.  use diffstat

4.  Why 2 diffs against include/linux/libata.h ?
    I was hoping that diffstat would show this, but it just merges
    the 2 libata.h patches together.  'lsdiff' does show this,
    however.

5.  #includes in alpha order as much as possible.

6.  Patch had some trailing whitespace (usually tabs).
    Some tools detect this and warn about it.

7.  Most important:  What good does the ACPI interface do/add?
    What I mean is that acpi_get_child() in scsi_acpi_find_channel()
    always returns a handle value of 0, so it doesn't get us
    any closer to determining the ACPI address (_ADR) of the SATA
    devices.  The acpi_get_devices() technique in my patch (basically
    walking the ACPI namespace, looking at all "devices") is the
    only way that I know of doing this, but I would certainly
    like to find a better way.


On Thu, 8 Dec 2005 03:02:42 +0000
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> Hi!
> 
> The included patch does three things:
> 
> 1) It adds basic support for binding SCSI and SATA devices to ACPI 
> device handles. At the moment this is limited to hosts, and in practice 
> it's probably limited to SATA ones (ACPI doesn't spec how SCSI devices 
> should appear in the DSDT, so I'm guessing that in general they don't). 
> Given a host, you can DEVICE_ACPI_HANDLE(dev) it to get the handle to 
> the ACPI device - this should be handy for implementing suspend 
> functions, since the methods should be in a standard location underneath 
> this.

[snip]

Thanks,
---
~Randy
