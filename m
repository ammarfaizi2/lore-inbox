Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUBWM5M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 07:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbUBWM5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 07:57:11 -0500
Received: from main.gmane.org ([80.91.224.249]:51384 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261821AbUBWM5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 07:57:08 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Juha Pahkala <juhis@trinity.is-a-geek.com>
Subject: Re: matroxfb not working after trying to upgrade to 2.6.3
Date: Mon, 23 Feb 2004 12:57:01 +0000 (UTC)
Message-ID: <loom.20040223T134724-944@post.gmane.org>
References: <loom.20040223T132140-441@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.110.64.16 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030819 Mozilla Firebird/0.6.1+)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juha <juhis <at> trinity.is-a-geek.com> writes:

> 
> 



by the way, I forgot this one the first time:

I had to apply this patch, found from the lkml archives, in order for
matroxfb_maven not to segfault when inserting the module.

--- gold-2.6/drivers/video/matrox/matroxfb_maven.c      2003-10-25
14:42:44.000000000 -0400
+++ linux-2.6.0/drivers/video/matrox/matroxfb_maven.c   2003-12-22
21:55:04.082725504 -0500
@@ -1249,6 +1249,7 @@
                err = -ENOMEM;
                goto ERROR0;
        }
+       memset(new_client, 0, sizeof(*new_client) + sizeof(*data));
        data = (struct maven_data*)(new_client + 1);
        i2c_set_clientdata(new_client, data);
        new_client->addr = address;



juhis




