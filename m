Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932768AbWBUVB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768AbWBUVB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbWBUVB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:01:29 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:52931
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932768AbWBUVB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:01:27 -0500
Date: Tue, 21 Feb 2006 13:01:32 -0800
From: Greg KH <greg@kroah.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, ak@suse.de, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 1/6] PCI legacy I/O port free driver (take2) - Add no_ioport flag into pci_dev
Message-ID: <20060221210132.GA12436@kroah.com>
References: <43FAB283.8090206@jp.fujitsu.com> <43FAB2F1.5030106@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FAB2F1.5030106@jp.fujitsu.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 03:28:01PM +0900, Kenji Kaneshige wrote:
> -	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO)
> +	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO) {
> +		WARN_ON(pdev->no_ioport);

You might want to just print out a nicer warning to the user through the
syslog, using dev_warn() otherwise they are not going to know which
device and driver are having problems.

Also, people see the output of this, and think their kernel just died,
which is not the case here.

thanks,

greg k-h
