Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVDSGo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVDSGo1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 02:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVDSGo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 02:44:27 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:24068 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261354AbVDSGoV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 02:44:21 -0400
Date: Tue, 19 Apr 2005 15:46:42 +0900 (JST)
Message-Id: <20050419.154642.111848378.yoshfuji@linux-ipv6.org>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] introduce generic 64bit rotations and i386 asm
 optimized version
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200504190918.10279.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200504190918.10279.vda@port.imtp.ilyichevsk.odessa.ua>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200504190918.10279.vda@port.imtp.ilyichevsk.odessa.ua> (at Tue, 19 Apr 2005 09:18:10 +0300), Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> says:

> diff -urpN 2.6.12-rc2.1.be/include/linux/bitops.h 2.6.12-rc2.2.ror/include/linux/bitops.h
> --- 2.6.12-rc2.1.be/include/linux/bitops.h	Mon Apr 18 22:55:10 2005
> +++ 2.6.12-rc2.2.ror/include/linux/bitops.h	Tue Apr 19 00:25:28 2005
> @@ -41,7 +41,7 @@ static inline int generic_ffs(int x)
>   * fls: find last bit set.
>   */
>  
> -static __inline__ int generic_fls(int x)
> +static inline int generic_fls(int x)
>  {
>  	int r = 32;
>  
> @@ -76,7 +76,7 @@ static __inline__ int generic_fls(int x)
>   */
>  #include <asm/bitops.h>
>  
> -static __inline__ int get_bitmask_order(unsigned int count)
> +static inline int get_bitmask_order(unsigned int count)
>  {
>  	int order;
>  	

Please keep using __inline__, not inline.

> +#ifndef ARCH_HAS_ROL64
> +static inline __u64 rol64(__u64 word, unsigned int shift)
> +{
> +	return (word << shift) | (word >> (64 - shift));
> +}
> +#endif
:
> +#ifndef ARCH_HAS_ROR64
> +static inline __u64 ror64(__u64 word, unsigned int shift)
> +{
> +	return (word >> shift) | (word << (64 - shift));
> +}
> +#endif
>  
>  #endif

please use __inline__, in header files.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
Homepage: http://www.yoshifuji.org/~hideaki/
GPG FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
