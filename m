Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWBUXO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWBUXO3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWBUXO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:14:29 -0500
Received: from fmr20.intel.com ([134.134.136.19]:26080 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750749AbWBUXO2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:14:28 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC: 2.6 patch] drivers/acpi/utilities/utmisc.c: remove 3 unused global functions
Date: Tue, 21 Feb 2006 15:14:20 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E046E49C8@orsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC: 2.6 patch] drivers/acpi/utilities/utmisc.c: remove 3 unused global functions
Thread-Index: AcY2bnO9dMuTM7ZdS0WtWlZV/nxzlAAzZnIQ
From: "Moore, Robert" <robert.moore@intel.com>
To: "Adrian Bunk" <bunk@stusta.de>, "Brown, Len" <len.brown@intel.com>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Feb 2006 23:14:21.0716 (UTC) FILETIME=[8C3F4540:01C6373C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Acpi_ut_strupr is used by the iASL compiler. I am probably going to put
a conditional compile around it.

The two report functions are obsolete, but may still be used by some of
the drivers. They will be removed soon.

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Adrian Bunk
> Sent: Monday, February 20, 2006 2:36 PM
> To: Brown, Len
> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [RFC: 2.6 patch] drivers/acpi/utilities/utmisc.c: remove 3
unused
> global functions
> 
> This patch removes the following four unused global functions from
> drivers/acpi/utilities/utmisc.c:
> - acpi_ut_strupr()
> - acpi_ut_report_warning()
> - acpi_ut_report_info()
> 
> Is this patch OK or is future usage planned or are they still used on
> other operating systems?
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/acpi/utilities/utmisc.c |   44
--------------------------------
>  include/acpi/acutils.h          |    6 ----
>  2 files changed, 50 deletions(-)
> 
> --- linux-2.6.16-rc1-mm5-full/include/acpi/acutils.h.old
2006-02-03
> 19:28:37.000000000 +0100
> +++ linux-2.6.16-rc1-mm5-full/include/acpi/acutils.h	2006-02-03
> 19:29:42.000000000 +0100
> @@ -279,10 +279,6 @@
> 
>  void acpi_ut_report_error(char *module_name, u32 line_number);
> 
> -void acpi_ut_report_info(char *module_name, u32 line_number);
> -
> -void acpi_ut_report_warning(char *module_name, u32 line_number);
> -
>  /* Error and message reporting interfaces */
> 
>  void ACPI_INTERNAL_VAR_XFACE
> @@ -454,8 +450,6 @@
>  			  void *target_object,
>  			  acpi_pkg_callback walk_callback, void
*context);
> 
> -void acpi_ut_strupr(char *src_string);
> -
>  void acpi_ut_print_string(char *string, u8 max_length);
> 
>  u8 acpi_ut_valid_acpi_name(u32 name);
> --- linux-2.6.16-rc1-mm5-full/drivers/acpi/utilities/utmisc.c.old
2006-02-
> 03 19:28:53.000000000 +0100
> +++ linux-2.6.16-rc1-mm5-full/drivers/acpi/utilities/utmisc.c	2006-02-
> 03 19:30:04.000000000 +0100
> @@ -217,39 +217,6 @@
> 
> 
>
/***********************************************************************
**
> ******
>   *
> - * FUNCTION:    acpi_ut_strupr (strupr)
> - *
> - * PARAMETERS:  src_string      - The source string to convert
> - *
> - * RETURN:      None
> - *
> - * DESCRIPTION: Convert string to uppercase
> - *
> - * NOTE: This is not a POSIX function, so it appears here, not in
> utclib.c
> - *
> -
>
************************************************************************
**
> ****/
> -
> -void acpi_ut_strupr(char *src_string)
> -{
> -	char *string;
> -
> -	ACPI_FUNCTION_ENTRY();
> -
> -	if (!src_string) {
> -		return;
> -	}
> -
> -	/* Walk entire string, uppercasing the letters */
> -
> -	for (string = src_string; *string; string++) {
> -		*string = (char)ACPI_TOUPPER(*string);
> -	}
> -
> -	return;
> -}
> -
> -
>
/***********************************************************************
**
> ******
> - *
>   * FUNCTION:    acpi_ut_print_string
>   *
>   * PARAMETERS:  String          - Null terminated ASCII string
> @@ -922,14 +864,3 @@
>  	acpi_os_printf("ACPI Error (%s-%04d): ", module_name,
line_number);
>  }
> 
> -void acpi_ut_report_warning(char *module_name, u32 line_number)
> -{
> -
> -	acpi_os_printf("ACPI Warning (%s-%04d): ", module_name,
> line_number);
> -}
> -
> -void acpi_ut_report_info(char *module_name, u32 line_number)
> -{
> -
> -	acpi_os_printf("ACPI (%s-%04d): ", module_name, line_number);
> -}
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
