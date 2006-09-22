Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWIVTY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWIVTY2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 15:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWIVTY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 15:24:28 -0400
Received: from dvhart.com ([64.146.134.43]:16873 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S964787AbWIVTY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 15:24:27 -0400
Message-ID: <4514386A.7040502@mbligh.org>
Date: Fri, 22 Sep 2006 12:24:26 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Christoph Lameter <clameter@sgi.com>, akpm@google.com,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
Subject: Re: [RFC] Initial alpha-0 for new page allocator API
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com> <200609220817.59801.ak@suse.de> <Pine.LNX.4.64.0609220934040.7083@schroedinger.engr.sgi.com> <200609222110.25118.ak@suse.de>
In-Reply-To: <200609222110.25118.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Friday 22 September 2006 18:35, Christoph Lameter wrote:
> 
>>On Fri, 22 Sep 2006, Andi Kleen wrote:
>>
>>
>>>On Friday 22 September 2006 06:02, Christoph Lameter wrote:
>>>
>>>>We have repeatedly discussed the problems of devices having varying 
>>>>address range requirements for doing DMA.
>>>
>>>We already have such an API. dma_alloc_coherent(). Device drivers
>>>are not supposed to mess with GFP_DMA* directly anymore for quite
>>>some time. 
>>
>>Device drivers need to be able to indicate ranges of addresses that may be 
>>different from ZONE_DMA. This is an attempt to come up with a future 
>>scheme that does no longer rely on device drivers referring to zoies.
> 
> 
> We already have that scheme. Any existing driver should be already converted
> away from GFP_DMA towards dma_*/pci_*. dma_* knows all the magic
> how to get memory for the various ranges. No need to mess up the 
> main allocator.

mbligh@mbligh:~/linux/views/linux-2.6.18$ grep -r GFP_DMA drivers

drivers/atm/fore200e.c:    chunk->alloc_addr = 
fore200e_kmalloc(chunk->alloc_size, GFP_KERNEL | GFP_DMA);
drivers/atm/fore200e.c:	data = kmalloc(tx_len, GFP_ATOMIC | GFP_DMA);
drivers/atm/fore200e.c:	fore200e->stats = fore200e_kmalloc(sizeof(struct 
stats), GFP_KERNEL | GFP_DMA);
drivers/atm/fore200e.c:    struct prom_data* prom = 
fore200e_kmalloc(sizeof(struct prom_data), GFP_KERNEL | GFP_DMA);
drivers/atm/iphase.c:       	    cpcs = kmalloc(sizeof(*cpcs), 
GFP_KERNEL|GFP_DMA);
drivers/char/synclink.c:	info->intermediate_rxbuffer = 
kmalloc(info->max_frame_size, GFP_KERNEL | GFP_DMA);
drivers/isdn/hisax/netjet.c:		GFP_KERNEL | GFP_DMA))) {
drivers/isdn/hisax/netjet.c:		GFP_KERNEL | GFP_DMA))) {
drivers/media/dvb/dvb-usb/gp8psk.c:	buf = kmalloc(512, GFP_KERNEL | 
GFP_DMA);
drivers/media/video/arv.c:	ar->line_buff = kmalloc(MAX_AR_LINE_BYTES, 
GFP_KERNEL | GFP_DMA);
drivers/media/video/planb.c:								|GFP_DMA, 0);
drivers/media/video/vino.c:				   GFP_KERNEL | GFP_DMA);
drivers/media/video/vino.c:			get_zeroed_page(GFP_KERNEL | GFP_DMA);
drivers/media/video/vino.c:				   GFP_KERNEL | GFP_DMA);
drivers/media/video/vino.c:			get_zeroed_page(GFP_KERNEL | GFP_DMA);
drivers/media/video/vino.c:	vino_drvdata->dummy_page = 
get_zeroed_page(GFP_KERNEL | GFP_DMA);
drivers/media/video/vino.c:		GFP_KERNEL | GFP_DMA);
drivers/media/video/zr36120_mem.c:	mem = 
(void*)__get_free_pages(GFP_USER|GFP_DMA,get_order(size));
drivers/mmc/wbsd.c:		GFP_NOIO | GFP_DMA | __GFP_REPEAT | __GFP_NOWARN);
drivers/net/b44.c:		skb = __dev_alloc_skb(RX_PKT_BUF_SZ,GFP_DMA);
drivers/net/b44.c:					     GFP_ATOMIC|GFP_DMA);
drivers/net/b44.c:		   insisting on use of GFP_DMA, which is more 
restrictive
drivers/net/b44.c:		   insisting on use of GFP_DMA, which is more 
restrictive
drivers/net/gt96100eth.c:	ret = (void *)__get_free_pages(GFP_ATOMIC | 
GFP_DMA, get_order(size));
drivers/net/hamradio/dmascc.c:	info = kmalloc(sizeof(struct scc_info), 
GFP_KERNEL | GFP_DMA);
drivers/net/hp100.c:	 * PCI cards can access the whole PC memory. 
Therefore GFP_DMA is not
drivers/net/irda/au1k_ir.c:	int gfp = GFP_ATOMIC | GFP_DMA;
drivers/net/irda/pxaficp_ir.c:	io->head = kmalloc(size, GFP_KERNEL | 
GFP_DMA);
drivers/net/irda/sa1100_ir.c:	io->head = kmalloc(size, GFP_KERNEL | 
GFP_DMA);
drivers/net/irda/vlsi_ir.c:		rd->buf = kmalloc(len, GFP_KERNEL|GFP_DMA);
drivers/net/lance.c:	lp = kmalloc(sizeof(*lp), GFP_DMA | GFP_KERNEL);
drivers/net/lance.c:						  GFP_DMA | GFP_KERNEL);
drivers/net/lance.c:						  GFP_DMA | GFP_KERNEL);
drivers/net/lance.c:		skb = alloc_skb(PKT_BUF_SZ, GFP_DMA | gfp);
drivers/net/lance.c:			rx_buff = kmalloc(PKT_BUF_SZ, GFP_DMA | gfp);
drivers/net/macmace.c:	mp->rx_ring = (void *) 
__get_free_pages(GFP_KERNEL | GFP_DMA, N_RX_PAGES);
drivers/net/macmace.c:	mp->tx_ring = (void *) 
__get_free_pages(GFP_KERNEL | GFP_DMA, 0);
drivers/net/meth.c:				skb = alloc_skb(METH_RX_BUFF_SIZE, GFP_ATOMIC | 
GFP_DMA);
drivers/net/ni65.c:		ret = skb = alloc_skb(2+16+size,GFP_KERNEL|GFP_DMA);
drivers/net/ni65.c:		ret = ptr = kmalloc(T_BUF_SIZE,GFP_KERNEL | GFP_DMA);
drivers/net/tokenring/3c359.c:	xl_priv->xl_tx_ring = 
kmalloc((sizeof(struct xl_tx_desc) * XL_TX_RING_SIZE) + 7, GFP_DMA | 
GFP_KERNEL) ;
drivers/net/tokenring/3c359.c:	xl_priv->xl_rx_ring = 
kmalloc((sizeof(struct xl_rx_desc) * XL_RX_RING_SIZE) +7, GFP_DMA | 
GFP_KERNEL) ;
drivers/net/wan/cosa.c:	cosa->bouncebuf = kmalloc(COSA_MTU, 
GFP_KERNEL|GFP_DMA);
drivers/net/wan/cosa.c:	if ((chan->rxdata = kmalloc(COSA_MTU, 
GFP_DMA|GFP_KERNEL)) == NULL) {
drivers/net/wan/cosa.c:	if ((kbuf = kmalloc(count, GFP_KERNEL|GFP_DMA)) 
== NULL) {
drivers/net/wan/z85230.c:	c->rx_buf[0]=(void 
*)get_zeroed_page(GFP_KERNEL|GFP_DMA);
drivers/net/wan/z85230.c:	c->tx_dma_buf[0]=(void 
*)get_zeroed_page(GFP_KERNEL|GFP_DMA);
drivers/net/wan/z85230.c:	c->tx_dma_buf[0]=(void 
*)get_zeroed_page(GFP_KERNEL|GFP_DMA);
drivers/net/znet.c:	if (!(znet->rx_start = kmalloc (DMA_BUF_SIZE, 
GFP_KERNEL | GFP_DMA)))
drivers/net/znet.c:	if (!(znet->tx_start = kmalloc (DMA_BUF_SIZE, 
GFP_KERNEL | GFP_DMA)))
drivers/s390/block/dasd.c:	device->ccw_mem = (void *) 
__get_free_pages(GFP_ATOMIC | GFP_DMA, 1);
drivers/s390/block/dasd.c:	device->erp_mem = (void *) 
get_zeroed_page(GFP_ATOMIC | GFP_DMA);
drivers/s390/block/dasd.c:				      GFP_ATOMIC | GFP_DMA);
drivers/s390/block/dasd.c:		cqr->data = kzalloc(datasize, GFP_ATOMIC | 
GFP_DMA);
drivers/s390/block/dasd_eckd.c:				  GFP_KERNEL | GFP_DMA);
drivers/s390/char/con3215.c:		      RAW3215_INBUF_SIZE, GFP_KERNEL|GFP_DMA);
drivers/s390/char/con3215.c:				       GFP_KERNEL|GFP_DMA);
drivers/s390/char/raw3270.c:	rq = kzalloc(sizeof(struct 
raw3270_request), GFP_KERNEL | GFP_DMA);
drivers/s390/char/raw3270.c:		rq->buffer = kmalloc(size, GFP_KERNEL | 
GFP_DMA);
drivers/s390/char/raw3270.c:	rp = kmalloc(sizeof(struct raw3270), 
GFP_KERNEL | GFP_DMA);
drivers/s390/char/sclp_cpi.c:	sccb = (struct cpi_sccb *) 
__get_free_page(GFP_KERNEL | GFP_DMA);
drivers/s390/char/sclp_tty.c:		page = (void *) 
get_zeroed_page(GFP_KERNEL | GFP_DMA);
drivers/s390/char/sclp_vt220.c:			page = (void *) 
get_zeroed_page(GFP_KERNEL | GFP_DMA);
drivers/s390/char/tape_3590.c:		       GFP_KERNEL | GFP_DMA);
drivers/s390/char/tape_core.c:	device->modeset_byte = kmalloc(1, 
GFP_KERNEL | GFP_DMA);
drivers/s390/char/tape_core.c:					  GFP_ATOMIC | GFP_DMA);
drivers/s390/char/tape_core.c:		request->cpdata = kzalloc(datasize, 
GFP_KERNEL | GFP_DMA);
drivers/s390/char/tty3270.c:			__get_free_pages(GFP_KERNEL|GFP_DMA, 0);
drivers/s390/char/vmcp.c:						| __GFP_REPEAT 	| GFP_DMA,
drivers/s390/cio/chsc.c:	page = (void *)get_zeroed_page(GFP_KERNEL | 
GFP_DMA);
drivers/s390/cio/chsc.c:	secm_area = (void *)get_zeroed_page(GFP_KERNEL 
|  GFP_DMA);
drivers/s390/cio/chsc.c:		css->cub_addr1 = (void 
*)get_zeroed_page(GFP_KERNEL | GFP_DMA);
drivers/s390/cio/chsc.c:		css->cub_addr2 = (void 
*)get_zeroed_page(GFP_KERNEL | GFP_DMA);
drivers/s390/cio/chsc.c:	scpd_area = (void *)get_zeroed_page(GFP_KERNEL 
| GFP_DMA);
drivers/s390/cio/chsc.c:	scmc_area = (void *)get_zeroed_page(GFP_KERNEL 
| GFP_DMA);
drivers/s390/cio/chsc.c:	sei_page = (void *)get_zeroed_page(GFP_KERNEL | 
GFP_DMA);
drivers/s390/cio/chsc.c:	sda_area = (void 
*)get_zeroed_page(GFP_KERNEL|GFP_DMA);
drivers/s390/cio/chsc.c:	scsc_area = (void *)get_zeroed_page(GFP_KERNEL 
| GFP_DMA);
drivers/s390/cio/cmf.c:		mem = (void*)__get_free_pages(GFP_KERNEL | GFP_DMA,
drivers/s390/cio/css.c:	sch = kmalloc (sizeof (*sch), GFP_KERNEL | GFP_DMA);
drivers/s390/cio/device.c:				GFP_KERNEL | GFP_DMA);
drivers/s390/cio/device_ops.c:	rdc_ccw = kzalloc(sizeof(struct ccw1), 
GFP_KERNEL | GFP_DMA);
drivers/s390/cio/device_ops.c:	rcd_ccw = kzalloc(sizeof(struct ccw1), 
GFP_KERNEL | GFP_DMA);
drivers/s390/cio/device_ops.c:	rcd_buf = kzalloc(ciw->count, GFP_KERNEL 
| GFP_DMA);
drivers/s390/cio/device_ops.c:	buf = kmalloc(32*sizeof(char), 
GFP_DMA|GFP_KERNEL);
drivers/s390/cio/device_ops.c:	buf2 = kmalloc(32*sizeof(char), 
GFP_DMA|GFP_KERNEL);
drivers/s390/cio/qdio.c:	irq_ptr = (void *) get_zeroed_page(GFP_KERNEL | 
GFP_DMA);
drivers/s390/cio/qdio.c:	irq_ptr->qdr=kmalloc(sizeof(struct qdr), 
GFP_KERNEL | GFP_DMA);
drivers/s390/cio/qdio.c:	return (void *) get_zeroed_page(gfp_mask|GFP_DMA);
drivers/s390/net/claw.c:			(void *)__get_free_pages(__GFP_DMA,
drivers/s390/net/claw.c:			(void *)__get_free_pages(__GFP_DMA,
drivers/s390/net/claw.c:                   p_buff=(void 
*)__get_free_pages(__GFP_DMA,
drivers/s390/net/claw.c:			(void *)__get_free_pages(__GFP_DMA,
drivers/s390/net/claw.c:                        p_buff = (void 
*)__get_free_pages(__GFP_DMA,
drivers/s390/net/ctcmain.c:						GFP_ATOMIC | GFP_DMA);
drivers/s390/net/ctcmain.c:					       GFP_KERNEL | GFP_DMA)) == NULL) {
drivers/s390/net/ctcmain.c:			nskb = alloc_skb(skb->len, GFP_ATOMIC | 
GFP_DMA);
drivers/s390/net/iucv.c:	/* Note: GFP_DMA used used to get memory below 
2G */
drivers/s390/net/iucv.c:					   GFP_KERNEL|GFP_DMA);
drivers/s390/net/iucv.c:				  GFP_KERNEL|GFP_DMA);
drivers/s390/net/lcs.c:			kzalloc(LCS_IOBUFFERSIZE, GFP_DMA | GFP_KERNEL);
drivers/s390/net/lcs.c:	card = kzalloc(sizeof(struct lcs_card), 
GFP_KERNEL | GFP_DMA);
drivers/s390/net/lcs.c:		 * Note: we have allocated the buffer with 
GFP_DMA, so
drivers/s390/net/lcs.c:		 * Note: we have allocated the buffer with 
GFP_DMA, so
drivers/s390/net/netiucv.c:					 NETIUCV_HDRLEN, GFP_ATOMIC | GFP_DMA);
drivers/s390/net/netiucv.c:					  GFP_KERNEL | GFP_DMA);
drivers/s390/net/netiucv.c:					  GFP_KERNEL | GFP_DMA);
drivers/s390/net/qeth_main.c:			kmalloc(QETH_BUFSIZE, GFP_DMA|GFP_KERNEL);
drivers/s390/net/qeth_main.c:	card = kzalloc(sizeof(struct qeth_card), 
GFP_DMA|GFP_KERNEL);
drivers/s390/net/qeth_main.c:			ptr = (void *) 
__get_free_page(GFP_KERNEL|GFP_DMA);
drivers/s390/net/qeth_main.c:				  GFP_KERNEL|GFP_DMA);
drivers/s390/net/qeth_main.c:					       GFP_KERNEL|GFP_DMA);
drivers/s390/net/smsgiucv.c:	msg = kmalloc(len + 1, GFP_ATOMIC|GFP_DMA);
drivers/scsi/53c7xx.c:/* FIXME: for ISA bus '7xx chips, we need to or 
GFP_DMA in here */
drivers/scsi/aacraid/commctrl.c:			/* Does this really need to be 
GFP_DMA? */
drivers/scsi/aacraid/commctrl.c:			p = 
kmalloc(usg->sg[i].count,GFP_KERNEL|__GFP_DMA);
drivers/scsi/aha1542.c:		SCpnt->host_scribble = (unsigned char *) 
kmalloc(512, GFP_KERNEL | GFP_DMA);
drivers/scsi/ch.c:	buffer = kmalloc(512, GFP_KERNEL | GFP_DMA);
drivers/scsi/ch.c:	buffer = kmalloc(512, GFP_KERNEL | GFP_DMA);
drivers/scsi/ch.c:		buffer = kmalloc(512, GFP_KERNEL | GFP_DMA);
drivers/scsi/eata.c:		gfp_t gfp_mask = (shost->unchecked_isa_dma ? 
GFP_DMA : 0) | GFP_ATOMIC;
drivers/scsi/hosts.c:		gfp_mask |= __GFP_DMA;
drivers/scsi/initio.c:		if ((tul_scb = (SCB *) kmalloc(i, GFP_ATOMIC | 
GFP_DMA)) != NULL)
drivers/scsi/ips.c:/* 4.71.00  - Change all memory allocations to not 
use GFP_DMA flag          */
drivers/scsi/osst.c:		priority |= GFP_DMA;
drivers/scsi/pluto.c:	fcs = (struct ctrl_inquiry *) kmalloc (sizeof 
(struct ctrl_inquiry) * fcscount, GFP_DMA);
drivers/scsi/scsi.c:	.gfp_mask	= __GFP_DMA,
drivers/scsi/scsi_error.c:			gfp_mask |= __GFP_DMA;
drivers/scsi/scsi_scan.c:			((shost->unchecked_isa_dma) ? __GFP_DMA : 0));
drivers/scsi/scsi_scan.c:			   (sdev->host->unchecked_isa_dma ? 
__GFP_DMA : 0));
drivers/scsi/sd.c:	buffer = kmalloc(SD_BUF_SIZE, GFP_KERNEL | __GFP_DMA);
drivers/scsi/sg.c:	 * XXX(hch): we shouldn't need GFP_DMA for the actual 
S/G list.
drivers/scsi/sg.c:		 gfp_flags |= GFP_DMA;
drivers/scsi/sg.c:		page_mask = GFP_ATOMIC | GFP_DMA | __GFP_COMP | 
__GFP_NOWARN;
drivers/scsi/sr.c:	buffer = kmalloc(512, GFP_KERNEL | GFP_DMA);
drivers/scsi/sr.c:	buffer = kmalloc(512, GFP_KERNEL | GFP_DMA);
drivers/scsi/sr_ioctl.c:/* primitive to determine whether we need to 
have GFP_DMA set based on
drivers/scsi/sr_ioctl.c:#define SR_GFP_DMA(cd) 
(((cd)->device->host->unchecked_isa_dma) ? GFP_DMA : 0)
drivers/scsi/sr_ioctl.c:	buffer = kmalloc(32, GFP_KERNEL | SR_GFP_DMA(cd));
drivers/scsi/sr_ioctl.c:	buffer = kmalloc(32, GFP_KERNEL | SR_GFP_DMA(cd));
drivers/scsi/sr_ioctl.c:	char *buffer = kmalloc(32, GFP_KERNEL | 
SR_GFP_DMA(cd));
drivers/scsi/sr_ioctl.c:	raw_sector = (unsigned char *) kmalloc(2048, 
GFP_KERNEL | SR_GFP_DMA(cd));
drivers/scsi/sr_vendor.c:	buffer = (unsigned char *) kmalloc(512, 
GFP_KERNEL | GFP_DMA);
drivers/scsi/sr_vendor.c:	buffer = (unsigned char *) kmalloc(512, 
GFP_KERNEL | GFP_DMA);
drivers/scsi/st.c:		priority |= GFP_DMA;
drivers/scsi/u14-34f.c:            (sh[j]->unchecked_isa_dma ? GFP_DMA : 
0) | GFP_ATOMIC))) {
drivers/usb/gadget/lh7a40x_udc.c:	retval = kmalloc(bytes, gfp_flags & 
~(__GFP_DMA | __GFP_HIGHMEM));
drivers/usb/gadget/pxa2xx_udc.c:	retval = kmalloc (bytes, gfp_flags & 
~(__GFP_DMA|__GFP_HIGHMEM));
