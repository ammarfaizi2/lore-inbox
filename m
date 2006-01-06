Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWAFJOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWAFJOM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 04:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWAFJOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 04:14:11 -0500
Received: from mail.gmx.net ([213.165.64.21]:45450 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932383AbWAFJOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 04:14:10 -0500
X-Authenticated: #4368190
Message-ID: <43BE34BB.70309@gmx.de>
Date: Fri, 06 Jan 2006 10:13:31 +0100
From: =?ISO-8859-1?Q?Hans-J=FCrgen_Lange?= <Hans-Juergen.Lange@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.x on IBM thin client 8363
References: <43BD0E1C.9060705@gmx.de> <20060105191819.594767e0.rdunlap@xenotime.net>
In-Reply-To: <20060105191819.594767e0.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Thu, 05 Jan 2006 13:16:28 +0100 Hans-Jürgen Lange wrote:
> 
> 
>>Hello,
>>
>>I would like to run a 2.6.x kernel on a IBM thin client 8363. There are 
>>patches available for the 2.4 series of kernels.
>>I had a look on these patches and the only thing they do is to expand 
>>the kernel commandline size to 512 Bytes and a change in 
>>arch/i386/kernel/head.S that changed the pointer to the commandline to a 
>>fixed address.
> 
> 
> Where are these 2.4 patches that you are referring to?
>

O.K. this is the very important one. Because without it the 8363 wont start.


--- linux/arch/i386/kernel/head.S.orig	Mon Jul 16 16:13:11 2001
+++ linux/arch/i386/kernel/head.S	Mon Jul 16 16:14:26 2001
@@ -158,7 +158,10 @@
  	movl $512,%ecx
  	rep
  	stosl
-	movl SYMBOL_NAME(empty_zero_page)+NEW_CL_POINTER,%esi
+/* NetVista */
+/*	movl SYMBOL_NAME(empty_zero_page)+NEW_CL_POINTER,%esi */
+	movl $0x98000, %esi
+
  	andl %esi,%esi
  	jnz 2f			# New command line protocol
  	cmpw $(OLD_CL_MAGIC),OLD_CL_MAGIC_ADDR




> 
> 
> ---
> ~Randy
> 
> 

