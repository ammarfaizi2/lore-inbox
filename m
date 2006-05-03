Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWECNz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWECNz0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 09:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWECNzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 09:55:25 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:60798 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030211AbWECNzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 09:55:25 -0400
In-Reply-To: <17489.18630.75412.66803@cargo.ozlabs.ibm.com>
Subject: Re: [PATCH 13/16] ehca: firmware InfiniBand interface
To: Paul Mackerras <paulus@samba.org>
Cc: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Marcus Eder <MEDER@de.ibm.com>, openib-general@openib.org,
       schihei@de.ibm.com
X-Mailer: Lotus Notes Release 7.0 HF85 November 04, 2005
Message-ID: <OF10E7ED21.CCC1AFCE-ONC1257163.00478AC0-C1257163.004BF94F@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Wed, 3 May 2006 15:56:34 +0200
X-MIMETrack: Serialize by Router on D12ML067/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 03/05/2006 15:56:34
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote on 28.04.2006 00:42:14:

> Mind you, since a lot of the parameters are used to return individual
> bytes or half-words, which are then put into structures, it might be
> better to pass the pointers to the structures and let the wrapper put
> the values straight into the structures.
>
> Paul.

As Paul already mentioned we can't change the firmware interface.

...so we would propose the following solution:
For the two h_call wrappers with more than 8 parameters we'll change to the
following signature:

hipz_h_alloc_resource_cq(const struct ipz_adapter_handle adapter_handle,
                         struct ehca_cq *cq, /* used for input and output
parameters */
                         const struct ipz_eq_handle eq_handle);

hipz_h_alloc_resource_qp(const struct ipz_adapter_handle adapter_handle,
                         struct ehca_qp * qp, /* used for input and output
parameters */
                         struct ehca_alloc_qp_params * param); /*input
params not in ehca_qp*/


hipz_h_alloc_resource_mr(const struct ipz_adapter_handle adapter_handle,
                         struct ehca_mr *mr,
                         const u64 vaddr,
                         const u64 length,
                         const u32 access_ctrl,
                         const struct ipz_pd pd);


u64 hipz_h_query_mr(const struct ipz_adapter_handle adapter_handle,
                    struct ehca_mr *mr);

u64 hipz_h_reregister_pmr(const struct ipz_adapter_handle adapter_handle,
                          struct ehca_mr *mr,
                          const u64 vaddr_in,
                          const u64 length,
                          const u32 access_ctrl,
                          const struct ipz_pd pd,
                          const u64 mr_addr_cb);

u64 hipz_h_register_smr(const struct ipz_adapter_handle adapter_handle,
                        struct ehca_mr *mr,
                        struct ehca_mr *orig_mr,
                        const u64 vaddr_in,
                        const u32 access_ctrl,
                        const struct ipz_pd pd);


What do you think about this solution?


Gruss / Regards . . . Christoph Raisch


