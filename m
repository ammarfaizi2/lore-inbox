Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751640AbWJIRq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbWJIRq5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 13:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWJIRq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 13:46:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24033 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751640AbWJIRq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 13:46:56 -0400
Date: Mon, 9 Oct 2006 09:45:04 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Matthias Hentges <oe@hentges.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: sky2 (was Re: 2.6.18-mm2)
Message-ID: <20061009094504.7b58eb2d@freekitty>
In-Reply-To: <1160332296.4575.31.camel@mhcln03>
References: <20060928155053.7d8567ae.akpm@osdl.org>
	<451C5599.80402@garzik.org>
	<20060928161956.5262e5d3@freekitty>
	<1159930628.16765.9.camel@mhcln03>
	<20061003202643.0e0ceab2@localhost.localdomain>
	<1160250529.4575.7.camel@mhcln03>
	<1160314905.4575.21.camel@mhcln03>
	<20061008092001.0c83a359@localhost.localdomain>
	<1160326801.4575.27.camel@mhcln03>
	<1160332296.4575.31.camel@mhcln03>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Oct 2006 20:31:36 +0200
Matthias Hentges <oe@hentges.net> wrote:

> 
> Oops, I forgot the "x" in lspci -vvvx, new dumps are attached.


I think I know what the problem is. The PCI access routines to access pci express
registers (ie reg > 256), only work if using MMCONFIG access. For some reason
your configuration doesn't want to use/allow that.

When it happened before, I ended up just not using the pci_read_config_XXX
routines and using the device map.  I'll revert the patch that started using
pci_find_ext_capabablity.

-- 
Stephen Hemminger <shemminger@osdl.org>
