Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262787AbSI2QFn>; Sun, 29 Sep 2002 12:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbSI2QFn>; Sun, 29 Sep 2002 12:05:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23047 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262787AbSI2QFm>;
	Sun, 29 Sep 2002 12:05:42 -0400
Date: Sun, 29 Sep 2002 17:11:04 +0100
From: Matthew Wilcox <willy@debian.org>
To: Hu Gang <gang_hu@soul.com.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Serial 2/2
Message-ID: <20020929171104.G18377@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -1582,10 +1583,10 @@
>                          ret = -ENOMEM;
>          }
>  
> - if (ret) {
> - if (res_rsa)
> + if (ret == 0) {
> + if (res_rsa == 0)
>                          release_resource(res_rsa);
> - if (res)
> + if (res == 0)
>                          release_resource(res);
>          }
>          return ret;

definitely not.

	if (res_rsa)
		release_resource(res_rsa);

will release the resource if we allocated it.  your patch calls
release_resource with an argument of NULL, and we'll leak the resource
we allocated.

i'm not sure about the rest of your changes, but this one is definitely
wrong.

-- 
Revolutions do not require corporate support.
