Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWGLLPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWGLLPr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 07:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWGLLPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 07:15:47 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:10354 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751257AbWGLLPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 07:15:46 -0400
Message-ID: <44B4D970.90007@sw.ru>
Date: Wed, 12 Jul 2006 15:13:52 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain>	<20060711075420.937831000@localhost.localdomain>	<44B3D435.8090706@sw.ru> <m1k66jebut.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1k66jebut.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Another example of not so evident coupling here:
>>user structure maintains number of processes/opened files/sigpending/locked_shm
>>etc.
>>if a single user can belong to different proccess/ipc/... namespaces
>>all these becomes unusable.
> 
> 
> Why do the count of the number of objects a user has become
> unusable if they can count objects in multiple namespaces?
> 
> Namespaces are about how names are looked up and how names are
> created.  Namespaces are not about the objects those names refer to.

One example below, which I believe is a bug due to coupling.
Will be glad to hear your opinion on this.

Let user u to unshare its process namespace and run e.g. httpd inside newly created 2nd process namespace.
Now imagine that user u hits his process rlimit.
He can't kill his httpd's because they are in another process namespace. He can kill visible to his bash processes from
1st process namespace, but httpd can spawn childs more after that. So we end up with the situation
when user u can't control his processes, nor run any other processes in his bash.

I'm fine with such situations, since we need containers mostly, but what makes me
really afraid is that it introduces hard to find/fix/maintain issues. I have no any other concerns.

Thanks,
Kirill

