Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbVITIbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbVITIbM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 04:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbVITIbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 04:31:12 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:61353 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S964898AbVITIbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 04:31:12 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "colin" <colin@realtek.com.tw>
Subject: Re: CONFIG_PRINTK doesn't makes size smaller
Date: Tue, 20 Sep 2005 11:30:10 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <01bf01c5bdaa$9e8b81c0$106215ac@realtek.com.tw>
In-Reply-To: <01bf01c5bdaa$9e8b81c0$106215ac@realtek.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="big5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509201130.10905.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 September 2005 09:14, colin wrote:
> 
> Hi there,
> I tried to make kernel with CONFIG_PRINTK off. I considered it should become
> smaller, but it didn't because it actually isn't an empty function, and
> there are many copies of it in vmlinux, not just one. Here is its
> definition:
>     static inline int printk(const char *s, ...) { return 0; }
> 
> I change the definition to this and it can greatly reduce the size by about
> 5%:
>     #define printk(...) do {} while (0)
> However, this definition would lead to error in some situations. For
> example:
>     1. (printk)
>     2. ret = printk
> 
> I hope someone could suggest a better definition of printk that can both
> make printk smaller and eliminate errors.

I think isolated testcase (a preprocessed .c file) would be interesting.
Use make dir/dir/file.i, reduce result to small .c file which shows
the problem, and show it on lkml.
--
vda
