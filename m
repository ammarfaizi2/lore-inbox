Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264367AbTLPXU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 18:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264369AbTLPXU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 18:20:29 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:26254 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264367AbTLPXU1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 18:20:27 -0500
Message-ID: <3FDF943B.8020906@us.ltcfwd.linux.ibm.com>
Date: Tue, 16 Dec 2003 17:24:43 -0600
From: Linda Xie <lxiep@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linda Xie <lxiep@us.ibm.com>, linux-kernel@vger.kernel.org,
       Greg KH <gregkh@us.ibm.com>, scheel@us.ibm.com, wortman@us.ibm.com
Subject: Re: PATCH -- kobject_set_name() doesn't allocate enough space
References: <3FDF67ED.1070605@us.ltcfwd.linux.ibm.com> <Pine.LNX.4.58.0312161241570.1599@home.osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> 
> The patch looks correct, but you should change the last test to be
> appropriate too, ie the
> 
> 	/* Still? Give up. */
> 	if (need > limit) {
> 
> test should, as far as I can tell, be
> 
> 	if (need >= limit) {
> 
> instead.
> 
> 		Linus

Hi Linus,

Thank you for pointing that out. Here is the updated patch:

diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c     Tue Dec 16 17:10:16 2003
+++ b/lib/kobject.c     Tue Dec 16 17:10:16 2003
@@ -344,16 +344,16 @@
                 /*
                  * Need more space? Allocate it and try again
                  */
-               name = kmalloc(need,GFP_KERNEL);
+               limit = need + 1;
+               name = kmalloc(limit,GFP_KERNEL);
                 if (!name) {
                         error = -ENOMEM;
                         goto Done;
                 }
-               limit = need;
                 need = vsnprintf(name,limit,fmt,args);

                 /* Still? Give up. */
-               if (need > limit) {
+               if (need >= limit) {
                         kfree(name);
                         error = -EFAULT;
                         goto Done;





