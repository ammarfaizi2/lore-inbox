Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbTEAFVE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 01:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbTEAFVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 01:21:04 -0400
Received: from [211.167.76.68] ([211.167.76.68]:11925 "HELO soulinfo")
	by vger.kernel.org with SMTP id S262414AbTEAFVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 01:21:03 -0400
Date: Thu, 1 May 2003 13:33:07 +0800
From: hugang <hugang@soulinfo.com>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-Id: <20030501133307.158c7e10.hugang@soulinfo.com>
In-Reply-To: <20030430221129.11595e2e.akpm@digeo.com>
References: <200304300446.24330.dphillips@sistina.com>
	<20030430135512.6519eb53.akpm@digeo.com>
	<20030501130318.459a4776.hugang@soulinfo.com>
	<20030430221129.11595e2e.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= Andrew Morton <akpm@digeo.com>
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Apr 2003 22:11:29 -0700
Andrew Morton <akpm@digeo.com> wrote:

>  nooo..  That has a big cache footprint.  At the very least you should use
>  a binary search.  gcc will do it for you:
> 
>  	switch (n) {
>  	case 0 ... 1:
>  		return 1;
>  	case 2 ... 3:
>  		return 2;
>  	case 4 ... 7:
>  		return 3;
>  	case 8 ... 15:
>  		return 4;
> 
>  etc.
It is here.
--------------------
static inline int fls_table_fls(unsigned n)
{
    switch (n) {
    case 0  ...      0: return 1;
    case 1  ...      1: return 2;
    case 2  ...      3: return 3;
    case 4  ...      7: return 4;
    case 8  ...      15: return 5;
    case 16         ...      31: return 6;
    case 32         ...      63: return 7;
    case 64         ...      127: return 8;
    case 128        ...      255: return 9;
    case 256        ...      511: return 10;
    case 512        ...      1023: return 11;
    case 1024       ...      2047: return 12;
    case 2048       ...      4095: return 13;
    case 4096       ...      8191: return 14;
    case 8192       ...      16383: return 15;
    case 16384      ...      32767: return 16;
    case 32768      ...      65535: return 17;
    case 65536      ...      131071: return 18;
    case 131072     ...      262143: return 19;
    case 262144     ...      524287: return 20;
    case 524288     ...      1048575: return 21;
    case 1048576    ...      2097151: return 22;
    case 2097152    ...      4194303: return 23;
    case 4194304    ...      8388607: return 24;
    case 8388608    ...      16777215: return 25;
    case 16777216   ...      33554431: return 26;
    case 33554432   ...      67108863: return 27;
    case 67108864   ...      134217727: return 28;
    case 134217728  ...      268435455: return 29;
    case 268435456  ...      536870911: return 30;
    case 536870912  ...      1073741823: return 31;
    default:    
    }   
    return 32;
} 

Now it in test, I will put log and file into 
http://soulinfo.com/~hugang/kernel/

-- 
Hu Gang / Steve
Email        : huagng@soulinfo.com, steve@soulinfo.com
GPG FinePrint: 4099 3F1D AE01 1817 68F7  D499 A6C2 C418 86C8 610E
ICQ#         : 205800361
Registered Linux User : 204016
