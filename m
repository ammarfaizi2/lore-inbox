Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267090AbSLRBRr>; Tue, 17 Dec 2002 20:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267091AbSLRBRr>; Tue, 17 Dec 2002 20:17:47 -0500
Received: from hermes.domdv.de ([193.102.202.1]:29190 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S267090AbSLRBRr>;
	Tue, 17 Dec 2002 20:17:47 -0500
Message-ID: <3DFFCF12.6050902@domdv.de>
Date: Wed, 18 Dec 2002 02:27:46 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en, de-de, de
MIME-Version: 1.0
To: Andrei Ivanov <andrei.ivanov@ines.ro>
CC: Robert Love <rml@tech9.net>, procps-list@redhat.com,
       linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: Re: [announce] procps 2.0.11
References: <1039639829.826.119.camel@phantasy> <Pine.LNX.4.50L0.0212112343550.6387-100000@webdev.ines.ro>
In-Reply-To: <Pine.LNX.4.50L0.0212112343550.6387-100000@webdev.ines.ro>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010306060100060602070706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010306060100060602070706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrei Ivanov wrote:
> top reports this:
> 
> 7 root 18446744073709551615 -20 0 0 0 SW< 0.0  0.0   A0:00   0 mdrecoveryd
> 8 root 18446744073709551615 -20 0 0 0 SW< 0.0  0.0   0:00   0 raid1d
> 
> is this strange or what ?
> 

The attached patch does fix this.

--------------010306060100060602070706
Content-Type: text/plain;
 name="procps.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="procps.diff"

diff -rNu procps-2.0.11-orig/top.c procps-2.0.11/top.c
--- procps-2.0.11-orig/top.c	2002-11-24 00:01:58.000000000 +0100
+++ procps-2.0.11/top.c	2002-12-17 20:36:28.000000000 +0100
@@ -1125,7 +1125,7 @@
 			if (task->priority < -99)
 				sprintf(tmp, " RT ");
 			else
-				sprintf(tmp, "%3llu ", task->priority);
+				sprintf(tmp, "%3lld ", task->priority);
 			break;
 		case P_NICE:
 			sprintf(tmp, "%3.3s ", scale_k(task->nice, 3, 0));

--------------010306060100060602070706--

