Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264632AbUD1DbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264632AbUD1DbE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 23:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264634AbUD1DbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 23:31:03 -0400
Received: from mail.kroah.org ([65.200.24.183]:53448 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264632AbUD1Dar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 23:30:47 -0400
Date: Tue, 27 Apr 2004 20:30:20 -0700
From: Greg KH <greg@kroah.com>
To: Michael Brown <Michael_E_Brown@Dell.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, mebrown@michaels-house.net
Subject: Re: [BK PATCH] add SMBIOS tables to sysfs
Message-ID: <20040428033020.GA14078@kroah.com>
References: <1083119269.1203.2821.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083119269.1203.2821.camel@debian>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 09:27:49PM -0500, Michael Brown wrote:
> Andrew,
> 	Below is a short patch to add SMBIOS data to sysfs. It it against latest
> bitkeeper 2.6.6-rc (specifically, it applies after the efivars patch that
> recently went in) but should apply to any recent kernel with only minor 
> reject on drivers/firmware/Makefile. A version for 2.4 (using /proc) will
> follow tomorrow.

Nice idea and patch.  A few minor comments:

> /sys/firmware/smbios/smbios/table_entry_point
> /sys/firmware/smbios/smbios/table

Why repeat the "smbios" directory?  Is this a limitation in the sysfs
interface right now?  Or are you going to put more files in the main
smbios directory some day?

> +	snprintf(sdev->kobj.name, 7, "smbios" );

Try using kobject_set_name() instead, it will do the proper thing if the
string is bigger than the base kobj.name field.

thanks,

greg k-h
