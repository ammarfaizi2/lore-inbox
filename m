Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVEKHTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVEKHTS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 03:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVEKHTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 03:19:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:29119 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261911AbVEKHTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 03:19:10 -0400
Date: Wed, 11 May 2005 00:19:02 -0700
From: Greg KH <greg@kroah.com>
To: Abhay Salunke <Abhay_Salunke@dell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       matt_domsch@dell.com
Subject: Re: [patch 2.6.12-rc3] dell_rbu: New Dell BIOS update driver
Message-ID: <20050511071902.GA10352@kroah.com>
References: <20050510220520.GA30741@littleblue.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050510220520.GA30741@littleblue.us.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 05:05:20PM -0500, Abhay Salunke wrote:
> +static struct bin_attribute rbudata_attr = {
> +	.attr = {.name = "rbudata", .owner = THIS_MODULE, .mode = 0644},
> +	.read = read_rbu_data,
> +	.write = write_rbu_data,
> +};
> +
> +static struct bin_attribute rbudatasize_attr = {
> +	.attr = { .name = "rbudatasize", .owner = THIS_MODULE, .mode = 0644 },
> +	.read = read_rbu_data_size,
> +	.write= write_rbu_data_size,
> +};
> +
> +static struct bin_attribute packetdatasize_attr = {
> +	.attr = { .name = "packetdatasize", .owner = THIS_MODULE, .mode = 0644 },
> +	.read = read_packet_data_size,
> +	.write= write_packet_data_size,
> +};
> +
> +static struct bin_attribute packetdata_attr = {
> +	.attr = { .name = "packetdata", .owner = THIS_MODULE, .mode = 0644 },
> +	.read = read_rbu_packet_data,
> +	.write= write_rbu_packet_data,
> +};

I can understand having the data use the sysfs binary attribute, but do
not do this for the size files.  Please just use a normal attribute for
them, the binary ones are _only_ for blobs of data that are not
interpreted by the kernel.

thanks,

greg k-h
