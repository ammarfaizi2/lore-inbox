Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTK1GQQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 01:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTK1GQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 01:16:15 -0500
Received: from compaq.com ([161.114.1.206]:9744 "EHLO ztxmail02.ztx.compaq.com")
	by vger.kernel.org with ESMTP id S262033AbTK1GQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 01:16:14 -0500
Message-ID: <3FC6E8F6.80008@mailandnews.com>
Date: Fri, 28 Nov 2003 11:49:34 +0530
From: Raj <raju@mailandnews.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tore Anderson <tore@linpro.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] scheduling while atomic when lseek()ing in /proc/net/tcp
References: <1069974335.14367.17.camel@echo.linpro.no>
In-Reply-To: <1069974335.14367.17.camel@echo.linpro.no>
Content-Type: multipart/mixed;
 boundary="------------080104000303040004020907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080104000303040004020907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tore Anderson wrote:

>  Hi,
>
>  The following code instantly freezes my all of my machines running 
> any of the beavers:
>  
>
The following patch fixed this, but i am _not_not_not sure whether this 
is the right way to do.
Any ideas folks ?

/Raj





--------------080104000303040004020907
Content-Type: text/plain;
 name="lseek_crash.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lseek_crash.patch"

--- seq_file.c.org	2003-11-28 11:12:28.000000000 +0530
+++ seq_file.c	2003-11-28 11:44:44.968883784 +0530
@@ -213,6 +213,9 @@
 	switch (origin) {
 		case 1:
 			offset += file->f_pos;
+			if(offset >= 0)
+				retval = file->f_pos = offset;
+			break;
 		case 0:
 			if (offset < 0)
 				break;

--------------080104000303040004020907--

