Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTK1A0j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 19:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbTK1A0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 19:26:39 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:3081 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S261754AbTK1A0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 19:26:38 -0500
Date: Fri, 28 Nov 2003 09:26:42 +0900 (JST)
Message-Id: <20031128.092642.47232575.yoshfuji@linux-ipv6.org>
To: felipe_alfaro@linuxmail.org
Cc: rmk+lkml@arm.linux.org.uk, davem@redhat.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH 2.6]: IPv6: strcpy -> strlcpy
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20031128.092326.39861126.yoshfuji@linux-ipv6.org>
References: <20031127221928.F25015@flint.arm.linux.org.uk>
	<1069974209.5349.7.camel@teapot.felipe-alfaro.com>
	<20031128.092326.39861126.yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031128.092326.39861126.yoshfuji@linux-ipv6.org> (at Fri, 28 Nov 2003 09:23:26 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> says:

>  2)   memset(dst, 0, len);
>       strncpy(dst, src, len);

oops, this should be

        memset(dst, 0, len);
        if (len > 0)
          strncpy(dst, src, len - 1);


>  3)   if (len)
>          strncpy(dst, src, len - 1);
>       dst[len] = 0;
> 
> (or, say, strncpy0()).

Note: in this case, we need to fix strncpy() first 
to zero-out rest of destination buffer.

--yoshfuji
