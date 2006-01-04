Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWADW4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWADW4w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWADW4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:56:52 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:55683 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S1751028AbWADW4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:56:51 -0500
Date: Wed, 04 Jan 2006 17:56:12 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 04/15] i386: Handle HP laptop rebooting properly.
In-reply-to: <20060104224250.GA32177@quicksilver.road.mcmartin.ca>
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
Message-id: <1136415372.4430.47.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <0ISL004R0943MT@a34-mta01.direcway.com>
 <20060104224250.GA32177@quicksilver.road.mcmartin.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 17:42 -0500, Kyle McMartin wrote:
> On Wed, Jan 04, 2006 at 04:59:44PM -0500, Ben Collins wrote:
> > +	{	/* HP laptops have weird reboot issues */
> > +		.callback = set_bios_reboot,
> > +		.ident = "HP Laptop",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq"),
> > +		},
> > +	},
> >  	{	/* Handle problems with rebooting on HP nc6120 */
> >  		.callback = set_bios_reboot,
> >  		.ident = "HP Compaq nc6120",
> >
> 
> Looks like the entry below could be removed, as it's now covered by
> the above.

That's correct, so here's a better trivial patch to just broaden the
existing entry.

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

diff --git a/arch/i386/kernel/reboot.c b/arch/i386/kernel/reboot.c
index 2afe0f8..2fa5803 100644
--- a/arch/i386/kernel/reboot.c
+++ b/arch/i386/kernel/reboot.c
@@ -111,12 +111,12 @@ static struct dmi_system_id __initdata r
 			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 2400"),
 		},
 	},
-	{	/* Handle problems with rebooting on HP nc6120 */
+	{	/* Handle problems with rebooting on HP laptops */
 		.callback = set_bios_reboot,
-		.ident = "HP Compaq nc6120",
+		.ident = "HP Compaq Laptop",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq nc6120"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq"),
 		},
 	},
 	{ }


-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

