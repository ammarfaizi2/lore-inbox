Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbVKXGaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbVKXGaT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 01:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161019AbVKXGaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 01:30:18 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:4366 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161018AbVKXGaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 01:30:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=X+BDxaUxjDUjse98c8ZAtTOWhLZXRAJEYCDQLVxp/flRLLbKqzcVbWDasjbAhMe+MeMQxRtPsO8nOWmcHozzw+H4LeY9qC/HQizSU0gAgNZg4Ht++3YhKrFu8j2JvC30b07/eN1NmiiC8hFrygZf9schNMR3m/nM5ejLfa8kAJQ=
Message-ID: <43855DBA.1050302@gmail.com>
Date: Thu, 24 Nov 2005 14:29:14 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Console rotation problems
References: <1132793150.26560.357.camel@gaston>	 <1132793556.26560.361.camel@gaston>  <1132796831.26560.392.camel@gaston> <1132801542.26560.402.camel@gaston>
In-Reply-To: <1132801542.26560.402.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> Remove bogus usage of test/set_bit() from fbcon rotation code and just
> manipulate the bits directly. This fixes an oops on powerpc among others
> and should be faster. Seems to work fine on the G5 here.

Thanks, I reached a point when my head became muddled with bit 
manipulations, so I used arch-specific bitops but complete forgot
that they were atomic :-)

> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Antonino Daplas <adaplas@pol.net>

> ---
> 
> And here is the fix. Tony, did I miss something ?

Works in little-endian too, so thank you very much. cfbimageblit may
also suffer from this same mistake (mine).  So can you test with
12x22 fonts at rotate 1 or 3 with acceleration off?

This particular line in cfbimgblit.c:slow_imageblit() is definitely
questionable.

- color = (*s & 1 << (BIT_NR(l))) ? fgcolor : bgcolor;
+ color = (*s & (1 << l)) ? fgcolor : bgcolor;


Tony
