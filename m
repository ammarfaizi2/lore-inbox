Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265598AbTFRWy0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 18:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265596AbTFRWyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 18:54:25 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.36.231]:52880 "EHLO
	ms-smtp-03.texas.rr.com") by vger.kernel.org with ESMTP
	id S265592AbTFRWyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 18:54:21 -0400
Message-ID: <3EF0F0D5.5030504@austin.rr.com>
Date: Wed, 18 Jun 2003 18:08:05 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: duplicate entry check in kmem_cache_create
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a recommended way to check to see if a slab cache with
a specific name exists before calling kmem_cache_create?

I was able to force it into the BUG() at about line 1160 of slab.c by 
removing my
module (rmmod -f) while some of my slab cache objects (e.g. private inode
info) were still in use, and then reloading my module which called
kmem_cache_create with a name that already existed.   I would
like to exit module init code with a more graceful error if I  
could easily detect that my slab cache objects were not deleted  
(since if I proceed farther in my module init code it will hit the  
BUG statement on 1160 of slab.c)

Any easy way to check? 

