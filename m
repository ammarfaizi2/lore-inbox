Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030511AbWKOOsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030511AbWKOOsp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 09:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbWKOOso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 09:48:44 -0500
Received: from mga07.intel.com ([143.182.124.22]:62011 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030511AbWKOOsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 09:48:43 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,425,1157353200"; 
   d="scan'208"; a="146816745:sNHT71362585"
Message-ID: <455B28B2.4010707@linux.intel.com>
Date: Wed, 15 Nov 2006 17:48:18 +0300
From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Len Brown <lenb@kernel.org>
CC: David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: 2.6.19-rc5 nasty ACPI regression, AE_TIME errors
References: <200611142303.47325.david-b@pacbell.net> <200611150248.12578.len.brown@intel.com>
In-Reply-To: <200611150248.12578.len.brown@intel.com>
Content-Type: multipart/mixed;
 boundary="------------030109050807050601050305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030109050807050601050305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Could you try if attached patch helps?


Regards,
    Alex







--------------030109050807050601050305
Content-Type: text/plain;
 name="ec1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ec1.patch"

Always enable GPE after return from notify handler.

From:  Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>


---

 drivers/acpi/ec.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e6d4b08..937eafc 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -465,8 +465,6 @@ static u32 acpi_ec_gpe_handler(void *dat
 
 	if (value & ACPI_EC_FLAG_SCI) {
 		status = acpi_os_execute(OSL_EC_BURST_HANDLER, acpi_ec_gpe_query, ec);
-		return status == AE_OK ?
-		    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
 	}
 	acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
 	return status == AE_OK ?

--------------030109050807050601050305--
