Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTK0Urt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 15:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbTK0Urt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 15:47:49 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:41992 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S261217AbTK0Urr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 15:47:47 -0500
Date: Fri, 28 Nov 2003 05:47:24 +0900 (JST)
Message-Id: <20031128.054724.116712136.yoshfuji@linux-ipv6.org>
To: rmk+lkml@arm.linux.org.uk
Cc: felipe_alfaro@linuxmail.org, davem@redhat.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH 2.6]: IPv6: strcpy -> strlcpy
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20031127200041.B25015@flint.arm.linux.org.uk>
References: <20031127194602.A25015@flint.arm.linux.org.uk>
	<20031128.045413.133305490.yoshfuji@linux-ipv6.org>
	<20031127200041.B25015@flint.arm.linux.org.uk>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031127200041.B25015@flint.arm.linux.org.uk> (at Thu, 27 Nov 2003 20:00:41 +0000), Russell King <rmk+lkml@arm.linux.org.uk> says:

> The thing that worries me is that an incorrect strlcpy() conversion
> gives the impression that someone has thought about buffer underruns
> as well as overruns, and, unless someone /has/ actually thought about
> it, there could well still be a security problem lurking there.

Hmm, what do you actually mean by "buffer underruns?"

(If I'm correct) do you suggest that we should zero-out rest of 
destination buffer?

if so, we may want to have a function, say strlcpy0(), like this:

size_t strlcpy0(char *dst, const char *src, size_t maxlen)
{
  size_t len = strlcpy(dst, src, maxlen);
  if (maxlen && len < maxlen - 1)
    memset(dst + len + 1, 0, maxlen - len - 1);
  return len;
}

--yoshfuji
