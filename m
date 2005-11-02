Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965300AbVKBWEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965300AbVKBWEQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965297AbVKBWEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:04:15 -0500
Received: from gw0.infiniconsys.com ([65.219.193.226]:55394 "EHLO
	mail.infiniconsys.com") by vger.kernel.org with ESMTP
	id S965294AbVKBWEN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:04:13 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [openib-general] Re: [PATCH/RFC v2] IB: Add SCSI RDMA Protocol(SRP) initiator
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Wed, 2 Nov 2005 17:04:07 -0500
Message-ID: <5D78D28F88822E4D8702BB9EEF1A436773E947@mercury.infiniconsys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [openib-general] Re: [PATCH/RFC v2] IB: Add SCSI RDMA Protocol(SRP) initiator
Thread-Index: AcXf+PCKEJQnC0JPSImA1j2jmF38WgAAF4zg
From: "Rimmer, Todd" <trimmer@silverstorm.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       "Roland Dreier" <rolandd@cisco.com>
Cc: <openib-general@openib.org>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

also leaks it on success

> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@mellanox.co.il]
> Sent: Wednesday, November 02, 2005 5:04 PM
> To: Roland Dreier
> Cc: openib-general@openib.org; linux-kernel@vger.kernel.org;
> linux-scsi@vger.kernel.org
> Subject: [openib-general] Re: [PATCH/RFC v2] IB: Add SCSI RDMA
> Protocol(SRP) initiator
> 
> 
> Hello, Roland!
> Quoting Roland Dreier <rolandd@cisco.com>:
> > +static int srp_init_qp(struct srp_target_port *target,
> > +		       struct ib_qp *qp)
> > +{
> > +	struct ib_qp_attr *attr;
> > +	int ret;
> > +
> > +	attr = kmalloc(sizeof *attr, GFP_KERNEL);
> > +	if (!attr)
> > +		return -ENOMEM;
> > +
> > +	ret = ib_find_cached_pkey(target->srp_host->dev,
> > +				  target->srp_host->port,
> > +				  be16_to_cpu(target->path.pkey),
> > +				  &attr->pkey_index);
> > +	if (ret)
> > +		return ret;
> > +
> > +	attr->qp_state        = IB_QPS_INIT;
> > +	attr->qp_access_flags = (IB_ACCESS_REMOTE_READ |
> > +				    IB_ACCESS_REMOTE_WRITE);
> > +	attr->port_num        = target->srp_host->port;
> > +
> > +	return ib_modify_qp(qp, attr,
> > +			    IB_QP_STATE		|
> > +			    IB_QP_PKEY_INDEX	|
> > +			    IB_QP_ACCESS_FLAGS	|
> > +			    IB_QP_PORT);
> > +}
> 
> This seems to leak sizeof *attr bytes if ib_find_cached_pkey
> returns an error.
> 
> -- 
> MST
> _______________________________________________
> openib-general mailing list
> openib-general@openib.org
> http://openib.org/mailman/listinfo/openib-general
> 
> To unsubscribe, please visit 
> http://openib.org/mailman/listinfo/openib-general
> 
