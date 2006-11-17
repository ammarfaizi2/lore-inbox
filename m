Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424607AbWKQEpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424607AbWKQEpj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 23:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162353AbWKQEpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 23:45:39 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:6767 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1162350AbWKQEph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 23:45:37 -0500
To: Steve Wise <swise@opengridcomputing.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH  09/13] Core WQE/CQE Types
X-Message-Flag: Warning: May contain useful information
References: <20061116035826.22635.61230.stgit@dell3.ogc.int>
	<20061116035912.22635.21736.stgit@dell3.ogc.int>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 16 Nov 2006 20:45:36 -0800
In-Reply-To: <20061116035912.22635.21736.stgit@dell3.ogc.int> (Steve Wise's message of "Wed, 15 Nov 2006 21:59:12 -0600")
Message-ID: <adaveleof4f.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 Nov 2006 04:45:36.0910 (UTC) FILETIME=[397E32E0:01C70A03]
Authentication-Results: sj-dkim-4; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +struct t3_send_wr {
 > +	struct fw_riwrh wrh;	/* 0 */
 > +	union t3_wrid wrid;	/* 1 */
 > +
 > +	enum t3_rdma_opcode rdmaop:8;
 > +	u32 reserved:24;	/* 2 */

Does this do the right thing wrt endianness?  I'd be more comfortable
with something like

	u8 rdmaop;
        u8 reserved[3];

(although the __attribute__((packed)) on enum t3_rdma_opcode does make
it OK to use here, I guess)

 > +	u32 rem_stag;		/* 2 */
 > +	u32 plen;		/* 3 */
 > +	u32 num_sgle;
 > +	struct t3_sge sgl[T3_MAX_SGE];	/* 4+ */
 > +};
