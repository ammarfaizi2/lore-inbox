Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbTFXW6o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 18:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTFXW6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 18:58:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:33277 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263163AbTFXW6j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 18:58:39 -0400
Message-ID: <3EF8D960.6060002@us.ibm.com>
Date: Tue, 24 Jun 2003 16:06:08 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: swsusp@lister.fornax.hu, linux-kernel@vger.kernel.org
CC: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: [patch] incorrect state check?
Content-Type: multipart/mixed;
 boundary="------------000509030804080507080006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000509030804080507080006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi swsusp'ers...  I've been looking through some software suspend code, 
and I think there's an error in acpi_suspend.  The code is checking that 
  we're trying to move into a valid state.  The check now reads:

if (state == ACPI_STATE_S2 || state == ACPI_STATE_S3 || ACPI_STATE_S4) {
/* do stuff */
}

This check will always be true, since ACPI_STATE_S4 is defined to be 4.

The attatched patch fixes this bug by putting a 'state == ' in front of 
the 'ACPI_STATE_S4'.

Cheers!

-Matt

--------------000509030804080507080006
Content-Type: text/plain;
 name="bad_swsusp_state_check.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bad_swsusp_state_check.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.5.73-vanilla/drivers/acpi/sleep/main.c linux-2.5.73-swsusp/drivers/acpi/sleep/main.c
--- linux-2.5.73-vanilla/drivers/acpi/sleep/main.c	Sun Jun 22 11:32:30 2003
+++ linux-2.5.73-swsusp/drivers/acpi/sleep/main.c	Tue Jun 24 15:58:58 2003
@@ -238,7 +238,7 @@ acpi_suspend (
 	/* do we have a wakeup address for S2 and S3? */
 	/* Here, we support only S4BIOS, those we set the wakeup address */
 	/* S4OS is only supported for now via swsusp.. */
-	if (state == ACPI_STATE_S2 || state == ACPI_STATE_S3 || ACPI_STATE_S4) {
+	if (state == ACPI_STATE_S2 || state == ACPI_STATE_S3 || state == ACPI_STATE_S4) {
 		if (!acpi_wakeup_address)
 			return AE_ERROR;
 		acpi_set_firmware_waking_vector((acpi_physical_address) acpi_wakeup_address);

--------------000509030804080507080006--

