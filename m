Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754514AbWKMMvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754514AbWKMMvt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 07:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754592AbWKMMvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 07:51:48 -0500
Received: from 195-13-16-24.net.novis.pt ([195.23.16.24]:17830 "EHLO
	bipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1754514AbWKMMvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 07:51:48 -0500
Message-ID: <45586A5F.4040304@grupopie.com>
Date: Mon, 13 Nov 2006 12:51:43 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Burman Yan <yan_952@hotmail.com>
CC: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATH] Replace kmalloc+memset with kzalloc 1/17
References: <BAY20-F24A945741EAE00E4980CEAD8F50@phx.gbl>
In-Reply-To: <BAY20-F24A945741EAE00E4980CEAD8F50@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burman Yan wrote:
> OK.
> Sorry.
> 
> I had to attach the patch, since hotmail does line wrapping, but I will 
> note the part regarding
> the more descriptive subject.

Hotmail is probably the _worse_ email client you could use to send 
patches to the kernel.

> Also, some of the patches are one line per file, so I joined them 
> together in one single patch.
> I thought that splitting that into many tiny patches will actually be 
> more annoying than
> a single bigger patch.

The logical separation you did isn't bad, but there is no mention on the 
*subject line* what section is targeted by your patch.

Also you should CC the maintainer for each section you're targeting. For 
instance, for the ACPI patch you should also CC Len Brown. Check the 
MAINTAINERS file for the right people to CC on each patch.

> Does that mean I should send those patches again?

Afraid so.

While you're at it, you could remove casts like this one:

-	pathname = (char *)kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
+	pathname = (char *)kzalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
  	if (!pathname)
  		return -ENOMEM;
-	memset(pathname, 0, ACPI_PATHNAME_MAX);

That "(char *)" really isn't needed.

Oh, and just one more thing: don't top post.

-- 
Paulo Marques - www.grupopie.com

"The face of a child can say it all, especially the
mouth part of the face."
