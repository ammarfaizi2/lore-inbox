Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030481AbWHRPGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030481AbWHRPGM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 11:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbWHRPGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 11:06:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:23700 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030476AbWHRPGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 11:06:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=gwJQpKL2OMe+7yxFmWOtbYJB3u8SvH865y/IwPDbl/swV1Dc8x4VnSFkTqNkfRYtJ1NJ4dxo53w+EJA4sm0Q+XOWKy9DmiYpe+mhzHnuyXVX4pW3S4LFlF/V44QNRfXZ6If0JaHDsPmxEb73QrvQCvYJCEF62mKsu/Iz/wsMKoI=
Date: Fri, 18 Aug 2006 19:06:00 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Cc: netdev@vger.kernel.org, Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>, Thomas Klein <tklein@de.ibm.com>
Subject: Re: [2.6.19 PATCH 2/7] ehea: pHYP interface
Message-ID: <20060818150600.GG5201@martell.zuzino.mipt.ru>
References: <200608181330.21507.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608181330.21507.ossthema@de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 01:30:21PM +0200, Jan-Bernd Themann wrote:
> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_phyp.c
> +++ kernel/drivers/net/ehea/ehea_phyp.c

> +	hret = ehea_hcall_9arg_9ret(H_QUERY_HEA_QP,
> +				    hcp_adapter_handle,	        /* R4 */
> +				    qp_category,	        /* R5 */
> +				    qp_handle,	                /* R6 */
> +				    sel_mask,	                /* R7 */
> +				    virt_to_abs(cb_addr),	/* R8 */
> +				    0, 0, 0, 0,	                /* R9-R12 */
> +				    &dummy,                     /* R4 */
> +				    &dummy,                     /* R5 */
> +				    &dummy,	                /* R6 */
> +				    &dummy,	                /* R7 */
> +				    &dummy,	                /* R8 */
> +				    &dummy,	                /* R9 */
> +				    &dummy,	                /* R10 */
> +				    &dummy,	                /* R11 */
> +				    &dummy);	                /* R12 */

I asked SO to recount arguments and we've come to a conclusion that
there're in fact 19 args not 18 as the name suggests. 19 args is
I-N-S-A-N-E.

> +u64 ehea_h_register_rpage_eq(const u64 hcp_adapter_handle,
> +			     const u64 eq_handle,
> +			     const u8 pagesize,
> +			     const u8 queue_type,
> +			     const u64 log_pageaddr, const u64 count)
> +{
> +	u64 hret = H_ADAPTER_PARM;
> +
> +	if (count != 1)
> +		return H_PARAMETER;
> +
> +	hret = ehea_h_register_rpage(hcp_adapter_handle, pagesize, queue_type,
> +				     eq_handle, log_pageaddr, count);
> +	return hret;

Just

	return ehea_h_register_rpage(...);

> +u64 ehea_h_register_rpage_cq(const u64 hcp_adapter_handle,
> +			     const u64 cq_handle,
> +			     const u8 pagesize,
> +			     const u8 queue_type,
> +			     const u64 log_pageaddr,
> +			     const u64 count, const struct h_epa epa)
> +{
> +	u64 hret = H_ADAPTER_PARM;
> +
> +	if (count != 1)
> +		return H_PARAMETER;
> +
> +	hret = ehea_h_register_rpage(hcp_adapter_handle, pagesize, queue_type,
> +				     cq_handle, log_pageaddr, count);
> +	return hret;

Ditto.

> +u64 ehea_h_register_rpage_qp(const u64 hcp_adapter_handle,
> +			     const u64 qp_handle,
> +			     const u8 pagesize,
> +			     const u8 queue_type,
> +			     const u64 log_pageaddr,
> +			     const u64 count, struct h_epa epa)
> +{
> +	u64 hret = H_ADAPTER_PARM;
> +
> +	if (count != 1)
> +		return H_PARAMETER;
> +
> +	hret = ehea_h_register_rpage(hcp_adapter_handle, pagesize, queue_type,
> +				     qp_handle, log_pageaddr, count);
> +	return hret;
> +}

Ditto.

> +static inline int hcp_epas_ctor(struct h_epas *epas, u64 paddr_kernel,
> +				u64 paddr_user)
> +{
> +	epas->kernel.fw_handle = (u64) ioremap(paddr_kernel, PAGE_SIZE);
> +	epas->user.fw_handle = paddr_user;
> +	return 0;
> +}
> +
> +static inline int hcp_epas_dtor(struct h_epas *epas)
> +{
> +
> +	if (epas->kernel.fw_handle)
> +		iounmap((void *)epas->kernel.fw_handle);
> +	epas->user.fw_handle = epas->kernel.fw_handle = 0;
> +	return 0;
> +}

Always returns 0;

