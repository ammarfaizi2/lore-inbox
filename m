Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbUCWHLD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 02:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbUCWHLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 02:11:03 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:40665 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262220AbUCWHKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 02:10:48 -0500
Date: Mon, 22 Mar 2004 23:08:50 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com
Subject: Re: [PATCH] nodemask_t x86_64 changes [5/7]
Message-Id: <20040322230850.1d8f26dc.pj@sgi.com>
In-Reply-To: <1079651082.8149.175.camel@arrakis>
References: <1079651082.8149.175.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll be surprised if the following line works:

	nodemask_t node_offline_map = nodes_complement(node_online_map);

1) Doesn't nodes_complement return void, and work in place?
2) It might set bits above MAX_NUMNODES, if MAX_NUMNODES isn't a word size multiple.

I am less sure of (2) - the exact details of handling the unused bits of
a bitmask are still confusing me.  But this would be one of the very
rare situations that I can find that would actually be sensitive to
possible confusions here - most places don't set bits that aren't
already set in some mask, or are careful to initialize a mask with just
set bits in select positions from 0 to MAX_NUMNODES-1.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
