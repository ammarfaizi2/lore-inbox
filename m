Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932713AbWCJImJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713AbWCJImJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 03:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbWCJImI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 03:42:08 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:33108 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932663AbWCJImG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 03:42:06 -0500
Message-ID: <44113CF0.7070005@sw.ru>
Date: Fri, 10 Mar 2006 11:46:40 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Andrey Savochkin <saw@saw.sw.com.sg>,
       devel@openvz.org
Subject: Re: [PATCH] ext3: ext3_symlink should use GFP_NOFS allocations inside
References: <441133FD.2070808@openvz.org> <20060310083136.GW27946@ftp.linux.org.uk>
In-Reply-To: <20060310083136.GW27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>+	page = find_or_create_page(mapping, 0,
>>+			mapping_gfp_mask(mapping) | gfp_mask);
> 
> 
>>+int page_symlink(struct inode *inode, const char *symname, int len)
>>+{
>>+	return __page_symlink(inode, symname, len, GFP_KERNEL);
> 
> 
> s/GFP_KERNEL/0/; if somebody has e.g. GFP_NOFS in their mapping flags,
> you end up breaking their code.  We really pass extra flags to be added
> to default ones; page_symlink() should pass 0.
thanks for noticing this.
fixed and resend.

Thanks,
Kirill


