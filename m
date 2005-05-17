Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVEQX16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVEQX16 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 19:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVEQX16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 19:27:58 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:65092 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261951AbVEQX1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 19:27:37 -0400
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:1(192.168.1.2):. Processed in 0.242305 secs Process 14687)
Subject: Re: [ACPI] [PATCH 1/2] IPMI and acpi=off|ht :
	acpi-get-firmware-failure.patch
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Yann Droneaud <ydroneaud@mandriva.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       "Moore, Robert" <robert.moore@intel.com>
In-Reply-To: <m23bsmzw35.fsf@firedrake.mandriva.com>
References: <m27jhyzwj6.fsf@firedrake.mandriva.com>
	 <m23bsmzw35.fsf@firedrake.mandriva.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 18 May 2005 00:27:31 +0100
Message-Id: <1116372451.14534.17.camel@bastov>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 May 2005 23:27:36.0251 (UTC) FILETIME=[0229B0B0:01C55B38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am CCing to Robert Moore because is about acpi/tables/tbxfroot.c. This
is code from ACPICA
http://developer.intel.com/technology/iapc/acpi/downloads.htm
So we have to wait for the next version of ACPICA, on dmesg we can find
it, for example:  

ACPI: Subsystem revision 20050211

thanks,

On Mon, 2005-05-16 at 23:42 +0200, Yann Droneaud wrote:
> This patch check that rsdt_info->pointer is not NULL before trying to
> unmap ACPI tables, which can happen if acpi_tb_get_rsdt_address() failed.
> 
> In my case, with ipmi_si_intf module and acpi=ht|off parameter, the call
> failed because acpi_gbl_table_flags is not initialised, so the
> address.pointer_type is not setup correctly, leading to message like:
> 
> May 16 11:18:29 localhost kernel:     ACPI-0166: *** Error: Invalid address flags 8
> 
> and rsdt_info->pointer equal to NULL leading to the Oops.
> 
> --- linux-2.6.11.9/drivers/acpi/tables/tbxfroot.c	2005-05-11 18:42:39.000000000 -0400
> +++ linux-2.6.11.9-fixes/drivers/acpi/tables/tbxfroot.c	2005-05-16 16:51:33.115768232 -0400
> @@ -313,7 +313,9 @@ acpi_get_firmware_table (
>  
> 
>  cleanup:
> -	acpi_os_unmap_memory (rsdt_info->pointer, (acpi_size) rsdt_info->pointer->length);
> +	if (rsdt_info->pointer) {
> +		acpi_os_unmap_memory (rsdt_info->pointer, (acpi_size) rsdt_info->pointer->length);
> +	}
>  	ACPI_MEM_FREE (rsdt_info);
>  
>  	if (header) {
> 
> 
> Signed-Off-by: ydroneaud@mandriva.com
> 
-- 
Sérgio M.B.

