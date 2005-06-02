Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVFBX7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVFBX7z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 19:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVFBX7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 19:59:54 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:63933 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261446AbVFBX7I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 19:59:08 -0400
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell
	BIOS update driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Abhay Salunke <Abhay_Salunke@dell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       matt_domsch@dell.com, Greg KH <greg@kroah.com>
In-Reply-To: <20050602232634.GA32462@littleblue.us.dell.com>
References: <20050602232634.GA32462@littleblue.us.dell.com>
Content-Type: text/plain
Date: Fri, 03 Jun 2005 01:58:48 +0200
Message-Id: <1117756728.3656.45.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhay,

> Resubmitting after cleaning up spaces/tabs etc...

and now starting with the coding style nitpicking ;)

> +	/* check if we have any packets */
> +	if (0 == rbu_data.num_packets) {

Make it "if (!rbu_data.num_packets) {".

> +	while(--packet_count) {
> +		ptemp_list = ptemp_list->next;
> +	}

Don't forget the space between "while" and "(" and the "{"/"}" are not
needed.

> +	ppacket = list_entry(ptemp_list,struct packet_data, list);

We always put a space after ",".

> +	if ((rbu_data.packet_write_count + length) > rbu_data.packetsize) {

Make it "(rbu_data.packet_write_count + length > rbu_data.packetsize)".

> +	/* copy the incoming data in to the new buffer */
> +	memcpy((ppacket->data + rbu_data.packet_write_count),
> +			data, length);

Make it "memcpy(ppacket->data + rbu_data.packet_write_count, ".

> +	if ((rbu_data.packet_write_count + length) == rbu_data.packetsize) {
> +		/*
> +		 this was the last data chunk in the packet
> +		 so reinitialize the packet data counter to zero
> +		*/
> +		rbu_data.packet_write_count = 0;
> +	} else
> +		rbu_data.packet_write_count += length;

Why not:

	rbu_data.packet_write_count += length;
	if (rbu_data.packet_write_count == rbu_data.packetsize)
		rbu_data.packet_write_count = 0;

> +	/* try allocating a new buffer to fit the request */
> +	pbuf =(unsigned char *)__get_free_pages(GFP_KERNEL, *ordernum);

Forgot a space after "=" and after "...char*)".

> +	if (pbuf != NULL) {

Make it "if (!pbuf)",

> +		/* check if the image is with in limits */
> +		img_buf_phys_addr = (unsigned long)virt_to_phys(pbuf);

Put a space after "...long)".

> +		if ((limit != 0) && ((img_buf_phys_addr + size) > limit)) {

Make it "if (!limit && img_bug_phys_addr + size > limit)"

> +			free_pages ((unsigned long)pbuf, *ordernum);

Space.

> +			 Try allocating a new buffer from the 
> +			 GFP_DMA range as it is with in 16MB range.
> +			*/
> +			pbuf =(unsigned char *)__get_free_pages(GFP_DMA,

Space.

> +			if (pbuf == NULL)

Use "(!pbuf)".

> +	if (rbu_data.packetsize == 0 ) {

Use "if (!rbu_data.packetsize)".

> +	if(newpacket == NULL) {

Use "if (!newpacket)".

> +	if(newpacket->data == NULL) {

Use "if (!newpacket->data)"

> +	if (rbu_data.packet_write_count == 0) {
> +		if ((rc = create_packet(length)) != 0 )
> +			return rc;
> +	}

Use this:

	if (!rbu_data.packet_write_count)
		if (!(rc = create_packet(length)))
			return rc;

> +	if ((rc = fill_last_packet(data, length)) != 0)

Use "if (!(rc = fill_last_packet(data, length)))".

> +		free_pages((unsigned long)newpacket->data, newpacket->ordernum);

Space.

> +	if (rbu_data.image_update_buffer == NULL)

Use "(!rbu_data.image_update_buffer)".

> +	free_pages((unsigned long)rbu_data.image_update_buffer,

Space.

> +		if ((size != 0) && (rbu_data.image_update_buffer == NULL)) {

Use "if (!size && !rbu_data.image_update_buffer)"

> +	image_update_buffer = (unsigned char *)get_free_pages_limited(size,

Space.

> +	if (image_update_buffer != NULL) {

Use "if (!image_update_buffer)".

> +		memset(rbu_data.image_update_buffer,0,

Space.

> +	sscanf(buf, "%d",&size);	

Spaces.

> +	if (size != 0)

Use "if (!size)".

> +	if (type == MONOLITHIC )

Space.

> +	if ( type == MONOLITHIC )

Spaces.

> +		size = sprintf(buf, "%lu\n",  rbu_data.bios_image_size);

Extra space not needed.

> +	if (type == MONOLITHIC ) 

Space.

> +	if (strlen(buf) >= 256 ) {

Space.

> +	if (type == MONOLITHIC ) {

Space.

> +	if (type == MONOLITHIC ) {

Space.

> +		if (fw_entry->size == 0 )

use "if (!fw_entry->size)".

> +				if (rc == 0) {

Use "if (!rc)".

> +		if ( rbu_data.packetsize != fw_entry->size )

Spaces.

> +		if ( rc == 0 )

Spaces.

> +static decl_subsys(dell_rbu,&ktype_dell_rbu,NULL);

Spaces.

> +        memset(rbu_dev, 0, sizeof (*rbu_dev));

No tab.

> +	if (type == MONOLITHIC)

Space.

> +		if (type == MONOLITHIC ) {

Space.

> +	if (rbu_dev != NULL) {

Use "if (!rbu_dev)".

> +static int __init dcdrbu_init(void)

What stand "dcd" for? Why not only "rbu_init"?

> +	if (rbu_download_mono == NULL) {	

Use "if (!rbu_download)".

> +	rbu_download_packet=  create_rbu_download_entry (PACKETIZED);

Wrong spaces.

> +	if (rbu_download_packet == NULL) {	

Use "if (!rbu_download_packet)".

> +	strncpy(rbu_device.bus_id,"firmware", BUS_ID_SIZE);

Space.

> +static __exit void dcdrbu_exit( void)

Why "dcd"?

> +config DELL_RBU
> +        tristate "BIOS update support for DELL systems via sysfs"
> +        default n
> +	select FW_LOADER

Space vs tab clash.

Regards

Marcel


