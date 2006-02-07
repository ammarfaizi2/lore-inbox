Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWBGQee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWBGQee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWBGQee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:34:34 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:39504 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S932099AbWBGQed convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:34:33 -0500
X-IronPort-AV: i="4.02,95,1139205600"; 
   d="scan'208"; a="376986962:sNHT37903662"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] [RESEND] Add Dell laptop backlight brightness display
Date: Tue, 7 Feb 2006 10:34:31 -0600
Message-ID: <35C9A9D68AB3FA4AB63692802656D9EC9277C0@ausx3mps303.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [RESEND] Add Dell laptop backlight brightness display
Thread-Index: AcYrnFKhB4JavfwlSuKhChJ0EIQ9fgAZ1qMw
From: <Michael_E_Brown@Dell.com>
To: <mjg59@srcf.ucam.org>
Cc: <akpm@osdl.org>, <Matt_Domsch@Dell.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Feb 2006 16:34:32.0908 (UTC) FILETIME=[600528C0:01C62C04]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can get and set laptop brighness on Dell with the proper SMI call.

To do the proper SMI call requires parsing SMBIOS structure 0xDA, a
vendor-proprietary structure, and getting the SMI index and io port and
magic values. Then, you need to know how to setup the registers and
input/output buffers for the call. All of this is already present in
libsmbios.

Reading nvram is not a valid way to get brighness unless you also do
similar work (parse specific vendor-proprietary SMBIOS structures) to
ensure that you are reading the correct location. This location is
subject to change from BIOS to BIOS and machine to machine. The fact
that you may have observed it in the same location on a few laptops does
not change this fact.

In fact, I have the same objection to the I8K driver in the kernel. It
has hardcoded SMI calls, that are subject to change. There is a proper
way to get the correct IO ports to make this safe, but it is not
currently being done.
--
Michael

-----Original Message-----
From: Matthew Garrett [mailto:mjg59@srcf.ucam.org] 
Sent: Monday, February 06, 2006 10:10 PM
To: Brown, Michael E
Cc: Andrew Morton; Domsch, Matt; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] Add Dell laptop backlight brightness
display

On Mon, Feb 06, 2006 at 09:43:16PM -0600, Michael E Brown wrote:

> 	I would _strongly_ suggest that this patch _not_ go in. This
driver 
> uses hardcoded values that are subject to change without notice. It is

> perfectly legitimate for future versions of Dell BIOS to interpret 
> pokes to cmos location 0x99 as the command to format your hard drive.

I managed to send the wrong patch - the Dell one only reads from nvram. 
If nvram reads are likely to reformat your hard drive, I think Dell
needs to reconsider its BIOS design :)

More seriously, a quick scan of libsmbios hasn't revealed any method for
obtaining the screen brightness. It's possible that I'm blind (I'm
certainly slightly drunk), but can you give a pointer to the correct
mechanism for making this call?

Thanks,
--
Matthew Garrett | mjg59@srcf.ucam.org
