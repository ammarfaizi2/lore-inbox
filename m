Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967998AbWLEBjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967998AbWLEBjE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 20:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968000AbWLEBjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 20:39:04 -0500
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:42420 "EHLO
	rwcrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967998AbWLEBjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 20:39:01 -0500
Message-ID: <4574CDB4.1050704@comcast.net>
Date: Mon, 04 Dec 2006 20:39:00 -0500
From: Ed Sweetman <safemode2@comcast.net>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Bernard Pidoux <pidoux@ccr.jussieu.fr>, linux-kernel@vger.kernel.org
Subject: Re: Why SCSI module needed for PCI-IDE ATA only disks ?
References: <457492B2.2050107@ccr.jussieu.fr> <4574B2E4.8060206@garzik.org>
In-Reply-To: <4574B2E4.8060206@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Bernard Pidoux wrote:
>> I am asking why need to compile the following modules while I do not
>> have any SCSI device ?
>
> libata uses SCSI to provide a lot of infrastructure that it would 
> otherwise have to recreate.  Also, using SCSI meant that it 
> automatically worked in existing installers.
>
>     Jeff
>
This confusion could easily be remedied by explaining the requirement in 
the Help output for libata drivers/section.  Also, making a dependency 
in the menu (since there is one) or automatically selecting the required 
scsi items when you select a libata driver would seem logical. As it is, 
nothing is said of scsi requirements in menuconfig. Trying to boot a 
machine without compiling the scsi drivers (something you're allowed to 
do) results in a system that boots and initializes the ata busses but 
can't communicate to any of the drives on them, (useless).


Then maybe later down the road, moving those scsi drivers shared by scsi 
and libata to the generic block layer would seem logical. That is, when 
ide is gone from the kernel and all the kernel speaks is scsi, there 
would be no need to differentiate scsi from the generic block layer 
devices, and no need to compile "scsi" drivers to have libata driver 
support, eliminating any possible further confusion.

