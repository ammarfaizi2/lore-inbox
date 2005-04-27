Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVD0WQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVD0WQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 18:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVD0WQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 18:16:43 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:11190 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262053AbVD0WQL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 18:16:11 -0400
Date: Wed, 27 Apr 2005 17:15:58 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@jo.austin.ibm.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH: 2 of 12 ] Fix TPM driver -- address missing const defs
In-Reply-To: <422FC42B.7@pobox.com>
Message-ID: <Pine.LNX.4.61.0504271419490.3929@jo.austin.ibm.com>
References: <1110415321526@kroah.com> <422FC42B.7@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005, Jeff Garzik wrote:
> Greg KH wrote:
<snip>

> > +static u8 cap_pcr[] = {
> > +	0, 193,			/* TPM_TAG_RQU_COMMAND */
> > +	0, 0, 0, 22,		/* length */
> > +	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
> > +	0, 0, 0, 5,
> > +	0, 0, 0, 4,
> > +	0, 0, 1, 1
> > +};
> 
> const
> 
> 
> > +#define READ_PCR_RESULT_SIZE 30
> > +static u8 pcrread[] = {
> > +	0, 193,			/* TPM_TAG_RQU_COMMAND */
> > +	0, 0, 0, 14,		/* length */
> > +	0, 0, 0, 21,		/* TPM_ORD_PcrRead */
> > +	0, 0, 0, 0		/* PCR index */
> > +};
> 
> const

<snip>

> > +static u8 cap_version[] = {
> > +	0, 193,			/* TPM_TAG_RQU_COMMAND */
> > +	0, 0, 0, 18,		/* length */
> > +	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
> > +	0, 0, 0, 6,
> > +	0, 0, 0, 0
> > +};
> 
> const
> 
> 
> > +#define CAP_MANUFACTURER_RESULT_SIZE 18

> > +static u8 cap_manufacturer[] = {
> > +	0, 193,			/* TPM_TAG_RQU_COMMAND */
> > +	0, 0, 0, 22,		/* length */
> > +	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
> > +	0, 0, 0, 5,
> > +	0, 0, 0, 4,
> > +	0, 0, 1, 3
> > +};
> 
> const
> 

<snip>

> > +static u8 savestate[] = {
> > +	0, 193,			/* TPM_TAG_RQU_COMMAND */
> > +	0, 0, 0, 10,		/* blob length (in bytes) */
> > +	0, 0, 0, 152		/* TPM_ORD_SaveState */
> > +};
> 
> const

<snip>

The following patch addresses the need for all of this missing const 
definitions.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -uprN --exclude='*.orig' linux-2.6.12-rc2/drivers/char/tpm/tpm.c linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.c
--- linux-2.6.12-rc2/drivers/char/tpm/tpm.c	2005-04-18 18:40:07.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.c	2005-04-20 17:11:43.000000000 -0500
@@ -192,7 +192,7 @@ out_recv:
 
 #define TPM_DIGEST_SIZE 20
 #define CAP_PCR_RESULT_SIZE 18
-static u8 cap_pcr[] = {
+static const u8 cap_pcr[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 22,		/* length */
 	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
@@ -202,7 +202,7 @@ static u8 cap_pcr[] = {
 };
 
 #define READ_PCR_RESULT_SIZE 30
-static u8 pcrread[] = {
+static const u8 pcrread[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 14,		/* length */
 	0, 0, 0, 21,		/* TPM_ORD_PcrRead */
@@ -246,7 +246,7 @@ static ssize_t show_pcrs(struct device *
 static DEVICE_ATTR(pcrs, S_IRUGO, show_pcrs, NULL);
 
 #define  READ_PUBEK_RESULT_SIZE 314
-static u8 readpubek[] = {
+static const u8 readpubek[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 30,		/* length */
 	0, 0, 0, 124,		/* TPM_ORD_ReadPubek */
@@ -309,7 +309,7 @@ static ssize_t show_pubek(struct device 
 static DEVICE_ATTR(pubek, S_IRUGO, show_pubek, NULL);
 
 #define CAP_VER_RESULT_SIZE 18
-static u8 cap_version[] = {
+static const u8 cap_version[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 18,		/* length */
 	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
@@ -318,7 +318,7 @@ static u8 cap_version[] = {
 };
 
 #define CAP_MANUFACTURER_RESULT_SIZE 18
-static u8 cap_manufacturer[] = {
+static const u8 cap_manufacturer[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 22,		/* length */
 	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
