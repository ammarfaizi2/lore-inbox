Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWGQRhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWGQRhK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 13:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWGQRhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 13:37:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:56385 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751092AbWGQRhI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 13:37:08 -0400
X-IronPort-AV: i="4.06,251,1149490800"; 
   d="scan'208"; a="66331428:sNHT5289819339"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 10/45] Reduce ACPI verbosity on null handle condition
Date: Mon, 17 Jul 2006 10:33:58 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A49AF20D@orsmsx415.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 10/45] Reduce ACPI verbosity on null handle condition
thread-index: Acapv0iyKiGCfEjfS3qU1qwsdwbrzQAB7YKw
From: "Moore, Robert" <robert.moore@intel.com>
To: "Greg KH" <gregkh@suse.de>, <linux-kernel@vger.kernel.org>,
       <stable@kernel.org>
X-OriginalArrivalTime: 17 Jul 2006 17:33:59.0759 (UTC) FILETIME=[301F6DF0:01C6A9C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change was made in ACPICA version 20060210

> -----Original Message-----
> From: Greg KH [mailto:gregkh@suse.de]
> Sent: Monday, July 17, 2006 9:27 AM
> To: linux-kernel@vger.kernel.org; stable@kernel.org
> Cc: Justin Forbes; Zwane Mwaikambo; Theodore Ts'o; Randy Dunlap; Dave
> Jones; Chuck Wolber; Chris Wedgwood; torvalds@osdl.org; akpm@osdl.org;
> alan@lxorguk.ukuu.org.uk; Brown, Len; Moore, Robert; Daniel Drake;
Chris
> Wright; Greg Kroah-Hartman
> Subject: [patch 10/45] Reduce ACPI verbosity on null handle condition
> 
> -stable review patch.  If anyone has any objections, please let us
know.
> 
> ------------------
> From: Bob Moore <robert.moore@intel.com>
> 
> As detailed at http://bugs.gentoo.org/131534 :
> 
> 2.6.16 converted many ACPI debug messages into error or warning
> messages. One extraneous message was incorrectly converted, resulting
in
> logs being flooded by "Handle is NULL and Pathname is relative"
messages
> on some systems.
> 
> This patch (part of a larger ACPICA commit) converts the message back
to
> debug level.
> 
> Signed-off-by: Daniel Drake <dsd@gentoo.org>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
>  drivers/acpi/namespace/nsxfeval.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.17.3.orig/drivers/acpi/namespace/nsxfeval.c
> +++ linux-2.6.17.3/drivers/acpi/namespace/nsxfeval.c
> @@ -238,8 +238,9 @@ acpi_evaluate_object(acpi_handle handle,
>  			ACPI_ERROR((AE_INFO,
>  				    "Both Handle and Pathname are
NULL"));
>  		} else {
> -			ACPI_ERROR((AE_INFO,
> -				    "Handle is NULL and Pathname is
relative"));
> +			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> +					  "Null Handle with relative
pathname [%s]",
> +					  pathname));
>  		}
> 
>  		status = AE_BAD_PARAMETER;
> 
> --
