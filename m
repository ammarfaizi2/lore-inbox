Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVERQWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVERQWt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVERQWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:22:12 -0400
Received: from fmr17.intel.com ([134.134.136.16]:13711 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262324AbVERQUE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 12:20:04 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] [PATCH 1/2] IPMI and acpi=off|ht :acpi-get-firmware-failure.patch
Date: Wed, 18 May 2005 09:19:44 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E01885400@orsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] [PATCH 1/2] IPMI and acpi=off|ht :acpi-get-firmware-failure.patch
Thread-Index: AcVbOEkwnA8L4vgcSRq4zbjJAwXhUgAjRHrg
From: "Moore, Robert" <robert.moore@intel.com>
To: <sergio@sergiomb.no-ip.org>, "Yann Droneaud" <ydroneaud@mandriva.com>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "ACPI Developers" <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 18 May 2005 16:19:45.0524 (UTC) FILETIME=[67A15B40:01C55BC5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I will look at this.
Bob


> -----Original Message-----
> From: acpi-devel-admin@lists.sourceforge.net [mailto:acpi-devel-
> admin@lists.sourceforge.net] On Behalf Of Sergio Monteiro Basto
> Sent: Tuesday, May 17, 2005 4:28 PM
> To: Yann Droneaud
> Cc: Kernel Mailing List; ACPI Developers; Moore, Robert
> Subject: Re: [ACPI] [PATCH 1/2] IPMI and acpi=off|ht :acpi-get-firmware-
> failure.patch
> 
> Hi,
> I am CCing to Robert Moore because is about acpi/tables/tbxfroot.c. This
> is code from ACPICA
> http://developer.intel.com/technology/iapc/acpi/downloads.htm
> So we have to wait for the next version of ACPICA, on dmesg we can find
> it, for example:
> 
> ACPI: Subsystem revision 20050211
> 
> thanks,
> 
> On Mon, 2005-05-16 at 23:42 +0200, Yann Droneaud wrote:
> > This patch check that rsdt_info->pointer is not NULL before trying to
> > unmap ACPI tables, which can happen if acpi_tb_get_rsdt_address()
> failed.
> >
> > In my case, with ipmi_si_intf module and acpi=ht|off parameter, the call
> > failed because acpi_gbl_table_flags is not initialised, so the
> > address.pointer_type is not setup correctly, leading to message like:
> >
> > May 16 11:18:29 localhost kernel:     ACPI-0166: *** Error: Invalid
> address flags 8
> >
> > and rsdt_info->pointer equal to NULL leading to the Oops.
> >
> > --- linux-2.6.11.9/drivers/acpi/tables/tbxfroot.c	2005-05-11
> 18:42:39.000000000 -0400
> > +++ linux-2.6.11.9-fixes/drivers/acpi/tables/tbxfroot.c	2005-05-16
> 16:51:33.115768232 -0400
> > @@ -313,7 +313,9 @@ acpi_get_firmware_table (
> >
> >
> >  cleanup:
> > -	acpi_os_unmap_memory (rsdt_info->pointer, (acpi_size) rsdt_info-
> >pointer->length);
> > +	if (rsdt_info->pointer) {
> > +		acpi_os_unmap_memory (rsdt_info->pointer, (acpi_size)
> rsdt_info->pointer->length);
> > +	}
> >  	ACPI_MEM_FREE (rsdt_info);
> >
> >  	if (header) {
> >
> >
> > Signed-Off-by: ydroneaud@mandriva.com
> >
> --
> Sérgio M.B.
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
