Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUCRNg0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 08:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbUCRNg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 08:36:26 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:49367 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262635AbUCRNgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 08:36:16 -0500
Subject: Re: [PATCH] Fix removable USB drive oops
From: James Bottomley <James.Bottomley@steeleye.com>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040318005838.GA25884@kroah.com>
References: <200403141810.i2EIAtK9032222@hera.kernel.org> 
	<20040318005838.GA25884@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Mar 2004 08:36:11 -0500
Message-Id: <1079616973.2021.5.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-17 at 19:58, Greg KH wrote:
> Bah, this was my fault, sorry.
> 
> Here's a patch that should fix this, and prevent you from needing this
> patch.  Can you verify this?

No, no.  It was Martin's fault: He used a NULL class to indicate that we
had no transport class.

The registration code in SCSI looks like:

	if (sdev->transport_classdev.class) {
		error = class_device_add(&sdev->transport_classdev);

i.e. only add the device if we actually have a transport class.  The
oops was caused because the unregister code was unconditional (i.e.
unregister a device we never registered in the first place).  The patch
(among other things) makes it conditional on the
sdev->transport_classdev.class like the registration.

James


