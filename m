Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWCJIx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWCJIx1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 03:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWCJIx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 03:53:27 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:19632 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750922AbWCJIx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 03:53:26 -0500
Message-ID: <44113F65.50706@sw.ru>
Date: Fri, 10 Mar 2006 11:57:09 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@ftp.linux.org.uk>, devel@openvz.org,
       Andrey Savochkin <saw@saw.sw.com.sg>
Subject: Re: [PATCH] ext3: ext3_symlink should use GFP_NOFS allocations	inside
 (ver. 3)
References: <44113CCC.5080602@openvz.org> <1141980385.2876.30.camel@laptopd505.fenrus.org>
In-Reply-To: <1141980385.2876.30.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Andrew,
>>
>>Fixed both comments from Al Viro (thanks, Al):
>>- should have a separate helper
>>- should pass 0 instead of GFP_KERNEL in page_symlink()
> 
> 
>> 
>>+	page = find_or_create_page(mapping, 0,
>>+			mapping_gfp_mask(mapping) | gfp_mask);
> 
> 
> 
> 
> this does not work; GFP_NOFS has a bit *LESS* than GFP_KERNEL, not a bit
> more. As such a | operation isn't going to be useful....
> 
> (So I think that while Al's intention was good, the implication of it
> isn't ;)
Oh no... Had to sleep well today... :/
Al, are you agree with the original patch then?
I don't think it is a good idea to introduce AND mask instead :)

Thanks,
Kirill

