Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbVEMVOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbVEMVOA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 17:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVEMVMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 17:12:34 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:32211 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262559AbVEMVIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 17:08:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=q12dEAszmZiVo6uj020Fk9aKkzQc4z+7fQ5zMY2+TyZPcah5/lLI0jA6RLKq5HfX0Omh/hkifPUSZfTHbaJtJGwrfCIamy3gRWLMIL7V9lULMhpgGxj/dPQgR43YXRWitIB4KJpoFpwAKPYo6epSXHQamgR8ARPR0a6lXRPtMz8=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Abhay Salunke <Abhay_Salunke@dell.com>
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Date: Sat, 14 May 2005 01:11:59 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       matt_domsch@dell.com
References: <20050513190030.GA2338@littleblue.us.dell.com>
In-Reply-To: <20050513190030.GA2338@littleblue.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505140111.59546.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 May 2005 23:00, Abhay Salunke wrote:
--- linux-2.6.11.8.ORIG/Documentation/DELL_RBU.txt
+++ linux-2.6.11.8/Documentation/DELL_RBU.txt

> +physical memory of packetdatasize and the data is written to that meomry.
								     ^^^^^^
> +Afte updating the BIOS image the appplication needs to communicate with the BIOS 
   ^^^^
> +reboot the system imideately or not reboot the system and leave up to the user 
		     ^^^^^^^^^^

--- linux-2.6.11.8.ORIG/drivers/firmware/dell_rbu.c
+++ linux-2.6.11.8/drivers/firmware/dell_rbu.c

> + * Changelog:
> + * 
> + * 13 May 2005 Abhay Salunke <Abhay_Salunke@dell.com>
> + * Modified code with suggestions from Andrew Morton; 

Maintaining ChangeLogs is the job of SCM. At least don't put my name here. ;-)

> +void init_packet_head(void)

static?

> +static int fill_last_packet(void *data, size_t length)

> +	memcpy(((char *)ppacket->data + rbu_data.packet_write_count), 

No need for cast and brackets.

> +		data, length);

> +		/* adjust the total packet length */

Useless comment.

> +		rbu_data.packet_write_count += length;

> +static void *get_free_pages_limited(unsigned long size,

> +		/* The incoming size is very large */

Useless comment.

> +		pr_debug("get_free_pages_limited: Incoming size is very large\n");

> +	pbuf =(unsigned char *)__get_free_pages(GFP_KERNEL, *ordernum);

pbuf is void *.

> +		img_buf_phys_addr = (unsigned long)virt_to_phys((void *)pbuf);

pbuf is void *.

> +			pbuf =(unsigned char *)__get_free_pages(GFP_DMA, *ordernum);

pbuf is void *.

> +static int create_packet(size_t length)

> +	newpacket = kmalloc(sizeof(struct packet_data) ,GFP_KERNEL);
> +	if(newpacket == NULL) {
> +		printk(KERN_WARNING"create_packet: failed to allocate new packet\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* there is no upper limit on memory address for packetized mechanism */
> +	newpacket->data = get_free_pages_limited(rbu_data.packetsize,&ordernum,	0);
> +	pr_debug("create_packet: newpacket %p\n", newpacket->data);
> +		
> +	if(newpacket->data == NULL) {
> +		printk(KERN_WARNING"create_packet: failed to allocate new packet\n");
> +		return -ENOMEM;

You leak newpacket.

> +	/* initialize the newly created packet headers */

Useless comment.

> +	INIT_LIST_HEAD(&newpacket->list);
> +	/* add this packet to the link list */

Useless comment.

> +	list_add_tail(&newpacket->list, &packet_data_head.list);
> +	/* 
> +	 * packets are of fixed sizes so initialize 
> +	 * the length to rbu_data.packetsize
> +	 */

"Packets have fixed size" is enough.

> +	newpacket->length = rbu_data.packetsize;

> +static int packetize_data(void *data, size_t length) 

> +		/* create a new packet */

Useless comment.

> +		if ((rc = create_packet(length)) != 0 )
> +			return rc;

> +static int packet_read_list(char *data, size_t *pread_length)

> +	/* get the current read count */

Useless comment.

> +	bytes_read = rbu_data.packet_read_count;

> +	ptemp_list = (&packet_data_head.list)->next;
> +	while(!list_empty(ptemp_list)) {

> +		/* adjust the remaining bytes */

Useless comment.

> +		remaining_bytes -= bytes_copied;
> +		bytes_read += bytes_copied;
> +		/* adjust the data pointer */

Useless comment.

> +		pdest += bytes_copied;

> +		/* point to the next packet in the list */

Useless comment.

> +		ptemp_list = ptemp_list->next;

> +static void packet_empty_list(void)

> +	ptemp_list = (&packet_data_head.list)->next;
> +	while(!list_empty(ptemp_list)) {
> +		newpacket = list_entry(ptemp_list, struct packet_data, list);
> +		/* get the next list ptr before we delete this entry */

Useless comment.

> +		pnext_list = ptemp_list->next;
> +		/* remove the list entry */

Useless comment.

> +		list_del(ptemp_list);
> +		/* set the list to next */

Useless comment.

> +		ptemp_list = pnext_list;
> +		/* zero out the RBU packet memory before freeing */
> +		memset(newpacket->data, 0, rbu_data.packetsize);

For what? Useless comment, anyway.

> +		/* free the memory pointed by this packet */

Useless comment.

> +		free_pages((unsigned long)newpacket->data, newpacket->ordernum);
> +		/* now free the packet*/

Useless comment.

> +		kfree(newpacket);

> +static void img_update_free( void)
			       ^
> +	/* zero out this buffer before freeing it */
> +	memset(rbu_data.image_update_buffer, 0, rbu_data.image_update_buffer_size);

For what?

> + 	free_pages((unsigned long)rbu_data.image_update_buffer, 
> +		rbu_data.image_update_order_number);

> +static int img_update_realloc(unsigned long size)

> +	if (image_update_buffer != NULL) {
> +		/* store address for the new buffer */

Useless comment.

> +		rbu_data.image_update_buffer = image_update_buffer;
> +		/* adjust allocated size */

Useless comment.

> +		rbu_data.image_update_buffer_size = PAGE_SIZE << ordernum;
> +		/* save the current order number */

Useless comment.

> +		rbu_data.image_update_order_number = ordernum;
> +		/* initialize the new buffer data to 0 */

Useless comment.

> +		memset(rbu_data.image_update_buffer,0, rbu_data.image_update_buffer_size);
> +		pr_debug("img_update_realloc: success\n");
> +		/* success */

Useless comment.

> +		rc = 0; 

> +static int __init dcdrbu_init(void)

> +		printk(KERN_WARNING"dcdrbu_init: firmware_register failed\n");

People usually leave space after KERN_*.

> +static __exit void dcdrbu_exit( void)
				  ^
> +	sysfs_remove_bin_file(&rbu_subsys.kset.kobj, &rbudata_attr );
> +	sysfs_remove_bin_file(&rbu_subsys.kset.kobj, &rbudatasize_attr );
> +	sysfs_remove_bin_file(&rbu_subsys.kset.kobj, &packetdatasize_attr );
> +	sysfs_remove_bin_file(&rbu_subsys.kset.kobj, &packetdata_attr );

Almost trailing whitespace.

--- linux-2.6.11.8.ORIG/drivers/firmware/Kconfig
+++ linux-2.6.11.8/drivers/firmware/Kconfig
> +	  DELL system. Note you need a supporting application to comunicate 
								 ^^^^^^^^^^
> +	  with the BIOS regardign the new image for the image update to 
			^^^^^^^^^

Also, try to fit both comments and code in 80 characters, run comments through
spellchecker, use consistent style for comments (
	/* foo                    /* foo
	   bar 1 */        or      * bar 1 */
) is OK.
