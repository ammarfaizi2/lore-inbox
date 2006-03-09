Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751879AbWCIMDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbWCIMDN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWCIMDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:03:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65225 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751891AbWCIMDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:03:02 -0500
Date: Thu, 9 Mar 2006 04:00:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: tony.luck@intel.com, ak@suse.de, jschopp@austin.ibm.com,
       haveblue@us.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH: 010/017](RFC) Memory hotplug for new nodes v.3.
 (allocate wait table)
Message-Id: <20060309040055.21f3ec2d.akpm@osdl.org>
In-Reply-To: <20060308213301.0036.Y-GOTO@jp.fujitsu.com>
References: <20060308213301.0036.Y-GOTO@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
>
>  +		/* we can use kmalloc() in run time */
>  +		do {
>  +			table_size = zone->wait_table_size
>  +					* sizeof(wait_queue_head_t);
>  +			zone->wait_table = kmalloc(table_size, GFP_ATOMIC);

Again, GFP_KERNEL would be better is possible.

Won't this place the node's wait_table into a different node's memory?
