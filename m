Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVCGJJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVCGJJH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 04:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVCGJJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 04:09:06 -0500
Received: from mx2.mail.ru ([194.67.23.122]:57411 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S261716AbVCGJHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 04:07:36 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Alex Aizman <itn780@yahoo.com>
Subject: Re: [ANNOUNCE 2/6] Open-iSCSI High-Performance Initiator for Linux
Date: Mon, 7 Mar 2005 12:08:02 +0200
User-Agent: KMail/1.6.2
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <422BFEC6.70305@yahoo.com>
In-Reply-To: <422BFEC6.70305@yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200503071208.02285.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 March 2005 09:12, Alex Aizman wrote:
>           Common header files:
>           - iscsi_ifev.h (user/kernel events).
>           - iscsi_if.h (iSCSI open interface over netlink);
>           - iscsi_proto.h (RFC3720 #defines and types);

> --- linux-2.6.11.orig/include/scsi/iscsi_if.h
> +++ linux-2.6.11.dima/include/scsi/iscsi_if.h

> +/**
> + * struct iscsi_transport - down calls
> + *
> + * @name: transport name
> + * @caps: iSCSI Data-Path capabilities
> + * @create_snx: create new iSCSI session object
> + * @destroy_snx: destroy existing iSCSI session object
> + * @create_cnx: create new iSCSI connection
> + * @bind_cnx: associate this connection with existing iSCSI session and
> + *            specified transport descriptor
> + * @destroy_cnx: destroy inactive iSCSI connection
> + * @set_param: set iSCSI Data-Path operational parameter
> + * @start_cnx: set connection to be operational
> + * @stop_cnx: suspend connection
> + * @send_pdu: send iSCSI PDU, Login, Logout, NOP-Out, Reject, Text.
> + *
> + * API provided by generic iSCSI Data Path module
> + */
> +struct iscsi_transport {
> +	char            *name;
> +	unsigned int    caps;
> +	unsigned int    max_cnx;
> +	iscsi_snx_h (*create_session) (iscsi_snx_h cp_snx,
> +			uint32_t initial_cmdsn, uint32_t *sid);
> +	void (*destroy_session) (iscsi_snx_h dp_snx);
> +	iscsi_cnx_h (*create_cnx) (iscsi_snx_h dp_snx, iscsi_cnx_h cp_cnx,
> +			uint32_t cid);
> +	int (*bind_cnx) (iscsi_snx_h dp_snx, iscsi_cnx_h dp_cnx,
> +			uint32_t transport_fd, int is_leading);
> +	int (*start_cnx) (iscsi_cnx_h dp_cnx);
> +	void (*stop_cnx) (iscsi_cnx_h dp_cnx);
> +	void (*destroy_cnx) (iscsi_cnx_h dp_cnx);
> +	int (*set_param) (iscsi_cnx_h dp_cnx, iscsi_param_e param,
> +			  uint32_t value);
> +	int (*send_pdu) (iscsi_cnx_h dp_cnx, struct iscsi_hdr *hdr,
> +			 char *data, uint32_t data_size);
> +};

create_snx		in comment but not in structure
destroy_snx		in comment but not in structure

destroy_session		in structure but not in comment
create_session		in structure but not in comment
max_cnx			in structure but not in comment

	Alexey
