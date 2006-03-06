Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWCFVmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWCFVmS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbWCFVmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:42:17 -0500
Received: from fmr17.intel.com ([134.134.136.16]:47031 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752423AbWCFVmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:42:16 -0500
Message-ID: <440CACB5.2010609@ichips.intel.com>
Date: Mon, 06 Mar 2006 13:42:13 -0800
From: Sean Hefty <mshefty@ichips.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: Sean Hefty <sean.hefty@intel.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 6/6] IB: userspace support for RDMA
 connection manager
References: <ORSMSX4011XvpFVjCRG00000009@orsmsx401.amr.corp.intel.com> <adaoe0j5kd6.fsf@cisco.com>
In-Reply-To: <adaoe0j5kd6.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>  > +struct rdma_ucm_query_route_resp {
>  > +	__u64 node_guid;
>  > +	struct ib_user_path_rec ib_route[2];
>  > +	struct sockaddr_in6 src_addr;
>  > +	struct sockaddr_in6 dst_addr;
>  > +	__u32 num_paths;
>  > +	__u8 port_num;
>  > +	__u8 reserved[3];
>  > +};
> 
> Is there a 32-bit/64-bit compatibility problem here?  From a quick
> look, struct sockaddr_in6 is not 8-byte aligned.

Unless I miss counted, they should be aligned.  ib_user_path_rec is defined near 
the end of patch 1/6.

+struct ib_user_path_rec {
+	__u8	dgid[16];
+	__u8	sgid[16];
+	__be16	dlid;
+	__be16	slid;
+	__u32	raw_traffic;
+	__be32	flow_label;
+	__u32	reversible;
+	__u32	mtu;
+	__be16	pkey;
+	__u8	hop_limit;
+	__u8	traffic_class;
+	__u8	numb_path;
+	__u8	sl;
+	__u8	mtu_selector;
+	__u8	rate_selector;
+	__u8	rate;
+	__u8	packet_life_time_selector;
+	__u8	packet_life_time;
+	__u8	preference;
+};

- Sean

