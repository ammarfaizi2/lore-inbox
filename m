Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263338AbUDVFeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbUDVFeX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 01:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbUDVFeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 01:34:22 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:55984 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263338AbUDVFeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 01:34:21 -0400
Message-ID: <40875944.4060405@colorfullife.com>
Date: Thu, 22 Apr 2004 07:33:56 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH] per-user signal pending and message queue limits
References: <20040419212810.GB10956@logos.cnet> <20040419224940.GY31589@devserv.devel.redhat.com> <20040420141319.GB13259@logos.cnet> <20040420130439.23fae566.akpm@osdl.org> <20040420231351.GB13826@logos.cnet> <20040420163443.7347da48.akpm@osdl.org> <20040421203456.GC16891@logos.cnet>
In-Reply-To: <20040421203456.GC16891@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>I'm thinking about how to do the mqueue "kernel allocated memory" accounting, 
>and I have a problem. A user can create an mqueue of given size via sys_mq_open()
>using "msg_attr" structure (will be created in do_create). I can account for how much 
>memory has been allocated, but I can't at "deaccount" at kfree() time (this memory 
>is stored in inode->(mqueue_inode_info *)info->messages), because I dont know how big
>it is (its user selectable via "msg_attr" structure). 
>  
>
Why not? mqueue_delete_inode can look at info->attr.mq_maxmsg and 
info->attr.mq_curmsg.

--
    Manfred

