Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVBQQQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVBQQQX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 11:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVBQQQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 11:16:23 -0500
Received: from mail.gmx.de ([213.165.64.20]:54403 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261153AbVBQQQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 11:16:11 -0500
X-Authenticated: #26200865
Message-ID: <4214C3B8.30502@gmx.net>
Date: Thu, 17 Feb 2005 17:18:00 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, seife@suse.de,
       rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
References: <20050214211105.GA12808@elf.ucw.cz>	 <1108621005.2096.412.camel@d845pe> <1108638021.4085.143.camel@tyrosine>
In-Reply-To: <1108638021.4085.143.camel@tyrosine>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett schrieb:
> On Thu, 2005-02-17 at 01:16 -0500, Len Brown wrote:
> 
>>I think that it is the BIOS' job on S3-suspend
>>to save the video mode.  On S3-resume the BIOS should
>>re-POST and restore the video mode.
> 
> I agree, but in the absence of spec requirement and some form of
> certification process, I don't see it happening in the near future.
> Given that vendors are still shipping invalid DSDTs, if Windows is able
> to reinitialise the graphics hardware, few are going to care about
> making life easier for Linux.

1. A first step towards better DSDTs would be to make the ASL compiler
complain about the same things which are complained about by the
in-kernel ACPI interpreter. An example would be the following:

acpi_processor-0496 [10] acpi_processor_get_inf: Invalid PBLK length [7]

The ASL compiler will not complain about it, yet the kernel will
refuse to do any processor throttling with a PBLK length of 7.

2. Urge/force vendors to use the latest ASL compiler available.
In most cases, this will result in a size reduction of the compiled
code, which should be in the interest of the vendors.

3. Get some shiny certification/label going that can be put on
fully conforming products as a sticker. Something like the old
"EPA pollution preventer" logo, but with a more appealing design.
Perhaps a "InstantOn/PowerSave" sticker, you get the idea.

4. Include a mandantory description of video bringup after resume
into the ACPI spec along the lines of "Conforming products SHOULD
make information about handling of the primary video device on
resume available to the ACPI interpreter during runtime. If video
state will be preserved over a suspend/resume cycle, the _WAK
method for said video device MUST be empty. If the video device
requires any actions by the operating system after resume to restore
the state it had before suspend, the _WAK method for said video
device MUST contain ALL the code needed to restore the state before
suspend. The _WAK method MAY call OS-supplied ACPI helper functions
like ACPI_EXECUTE_CODE_FROM_ROM to keep the _WAK method short.
If no _WAK method for a given video device is available, the OS
MUST be able to rely on the fact that video state is preserved
over suspend/resume.


Something like item 4 would be a major step forward and as a bonus,
it wouldn't require any hardware changes, only perhaps 3 or 4
additional lines of code in the DSDT. If the _WAK function for
my laptop graphics card existed and had the hypothetical commands
ACPI_EXECUTE_CODE_FROM_ROM_X86(VGA.ROM)
ACPI_RESTORE_VESA_STATE(VGA)
we wouldn't have this discussion in the first place.


Regards,
Carl-Daniel
--
http://www.hailfinger.org/
