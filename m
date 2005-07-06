Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVGFUTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVGFUTv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVGFUK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:10:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33459 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262163AbVGFT3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 15:29:19 -0400
Date: Wed, 6 Jul 2005 15:29:09 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix bt87x.c build problem
Message-ID: <20050706192909.GA23293@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Linus Torvalds <torvalds@osdl.org>
References: <200507061824.j66IODbD018395@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507061824.j66IODbD018395@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 11:24:13AM -0700, Linux Kernel wrote:
 > tree 2fe5cb66de97b707e23d531578dc2a656855415e
 > parent 3d3c2ae1101c1f2dff7e2f9d514769779dbd2737
 > author Greg KH <greg@kroah.com> Wed, 06 Jul 2005 22:51:03 -0700
 > committer Linus Torvalds <torvalds@g5.osdl.org> Wed, 06 Jul 2005 23:34:23 -0700
 > 
 > [PATCH] Fix bt87x.c build problem
 > 
 > Missing forward declaration
 > 
 > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
 > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
 > 
 >  sound/pci/bt87x.c |    2 ++
 >  1 files changed, 2 insertions(+)
 > 
 > diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
 > --- a/sound/pci/bt87x.c
 > +++ b/sound/pci/bt87x.c
 > @@ -798,6 +798,8 @@ static struct {
 >  	{0x270f, 0xfc00}, /* Chaintech Digitop DST-1000 DVB-S */
 >  };
 >  
 > +static struct pci_driver driver;
 > +
 >  /* return the rate of the card, or a negative value if it's blacklisted */
 >  static int __devinit snd_bt87x_detect_card(struct pci_dev *pci)
 >  {
 > -

Still not enough to make it build here..

sound/pci/bt87x.c:809: error: incompatible type for argument 1 of 'pci_match_device'

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.12/sound/pci/bt87x.c~	2005-07-06 14:59:08.000000000 -0400
+++ linux-2.6.12/sound/pci/bt87x.c	2005-07-06 15:26:35.000000000 -0400
@@ -806,7 +806,7 @@ static int __devinit snd_bt87x_detect_ca
 	int i;
 	const struct pci_device_id *supported;
 
-	supported = pci_match_device(driver, pci);
+	supported = pci_match_device(&driver, pci);
 	if (supported)
 		return supported->driver_data;
 
