Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWAQXkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWAQXkH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWAQXkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:40:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42889 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932398AbWAQXjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:39:43 -0500
Date: Tue, 17 Jan 2006 15:38:38 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "Sean Hefty" <sean.hefty@intel.com>
Cc: "Hefty, Sean" <sean.hefty@intel.com>, <linux-kernel@vger.kernel.org>,
       <netdev@vger.kernel.org>, <openib-general@openib.org>
Subject: Re: [PATCH 2/5] [RFC] Infiniband: connection abstraction
Message-ID: <20060117153838.3dc2cd2e@dxpl.pdx.osdl.net>
In-Reply-To: <ORSMSX401FRaqbC8wSA00000040@orsmsx401.amr.corp.intel.com>
References: <ORSMSX401FRaqbC8wSA0000003e@orsmsx401.amr.corp.intel.com>
	<ORSMSX401FRaqbC8wSA00000040@orsmsx401.amr.corp.intel.com>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor nits.

On Tue, 17 Jan 2006 15:24:37 -0800
"Sean Hefty" <sean.hefty@intel.com> wrote:

> The following patch extends matching connection requests to listens in the
> Infiniband CM to include private data.
> 
> Signed-off-by: Sean Hefty <sean.hefty@intel.com>
> 
> ---

> +static void cm_mask_compare_data(u8 *dst, u8 *src, u8 *mask)

static void cm_mask_compare_data(u8 *dst, const u8 *src, u8 *mask)

but I would rename it to cm_mask_copy since it doesn't really do a compare.


> +{
> +	int i;
> +
> +	for (i = 0; i < IB_CM_PRIVATE_DATA_COMPARE_SIZE; i++)
> +		dst[i] = src[i] & mask[i];
> +}
> +
> +static int cm_compare_data(struct ib_cm_private_data_compare *src_data,
> +			   struct ib_cm_private_data_compare *dst_data)

static int cm_compare_data(const struct ib_cm_private_data_compare *src,
		           cosnt struct ib_cm_private_data_compare *dst)
Your data type names are getting too long ^^^^^^^^^^^^^^^^^^^^^^^^


<flamebait>
Also should infiniband exports be EXPORT_SYMBOL_GPL, to make
it clear that binary drivers for this are not allowed??
</flamebait>

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
