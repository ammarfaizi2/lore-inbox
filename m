Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWFYQai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWFYQai (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 12:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWFYQai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 12:30:38 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:12139 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751161AbWFYQah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 12:30:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=4U30/OG6+Z+8WvJlVz6FCOr/CKtu0n8KDqHIKlwGNa+H1AR3TWqZpA/mmBrk2oMO4LFvM79gb9FDrCVWwzhI8Ie76IZmbqYnKWKBIhL5xuBr0EdIK32kOmTxQcG/0VLfXgjpmI10TplsafdtG1NbfErCgoVDAvXBW9zIQ/tZw2g=  ;
Message-ID: <449EBA2A.5030501@yahoo.com.au>
Date: Mon, 26 Jun 2006 02:30:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Neil Brown <neilb@suse.de>, balbir@in.ibm.com, akpm@osdl.org,
       aviro@redhat.com, jblunck@suse.de, dev@openvz.org, olh@suse.de,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Destroy the dentries contributed by a superblock on unmounting
References: <17566.12727.489041.220653@cse.unsw.edu.au>  <17564.52290.338084.934211@cse.unsw.edu.au> <15603.1150978967@warthog.cambridge.redhat.com> <553.1151156031@warthog.cambridge.redhat.com> <20946.1151251352@warthog.cambridge.redhat.com>
In-Reply-To: <20946.1151251352@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:

> +	for (;;) {
> +		/* descend to the first leaf in the current subtree */
> +		while (!list_empty(&dentry->d_subdirs)) {
> +			/* this dentry has children - pin it whilst we dispose
> +			 * of them */
> +			atomic_inc(&dentry->d_count);
> +			dentry = list_entry(dentry->d_subdirs.next,
> +					    struct dentry, d_u.d_child);
> +		}
> +
> +	consume_empty_leaf:

Just to nitpick, the indented label goes against the style in this
part of the kernel.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
