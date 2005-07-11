Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVGLAzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVGLAzM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 20:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVGLAzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 20:55:07 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:41881 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261878AbVGKOdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:33:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dAS3EK9WQOy/xcjM7JhZWCsUvKG9tL3QIxvewE7murPoPbOFN0HUanQo9XCOQmeFyMwAKNTwbRfDFQe6OTtoQOh24OlAN0uRIzV6EgZsjn4A/flOB3lljRUvQCw+3EEhOX7eNpC03kZCZllfBz/Gx7i3n4F8bTIEGzGiykiMFJU=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Hal Rosenstock <halr@voltaire.com>
Subject: Re: [PATCH 3/27] Add MAD helper functions
Date: Mon, 11 Jul 2005 18:39:41 +0400
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
References: <1121089079.4389.4511.camel@hal.voltaire.com>
In-Reply-To: <1121089079.4389.4511.camel@hal.voltaire.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507111839.41807.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 July 2005 17:48, Hal Rosenstock wrote:
> Add new helper routines for allocating MADs for sending and formatting
> a send WR.

> -- linux-2.6.13-rc2-mm1/drivers/infiniband2/core/mad.c
> +++ linux-2.6.13-rc2-mm1/drivers/infiniband3/core/mad.c
				   ^^^^^^^^^^^
Ick. You'd better have linux-2.6.13-rc2-mm1-[0123...].

> +struct ib_mad_send_buf * ib_create_send_mad(struct ib_mad_agent *mad_agent,
> +					    u32 remote_qpn, u16 pkey_index,
> +					    struct ib_ah *ah,
> +					    int hdr_len, int data_len,
> +					    int gfp_mask)

unsigned int __nocast gfp_mask, please. 430 or so infiniband sparse warnings
is not a reason to add more.

> +{

> +	buf = kmalloc(sizeof *send_buf + buf_size, gfp_mask);
