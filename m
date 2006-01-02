Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWABQYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWABQYj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 11:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWABQYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 11:24:39 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:52408 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750805AbWABQYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 11:24:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dF8k3qyeWHbXIW1QSFpQpb2iVJ9e3cfocr5iXhmrv70b/ZFqackxZc6GM5CayT23KYwaO5YgihqYfy694gzOyTH76mV2oHzj+jHnfs9N75jB3p17Av9HytaJ+5wMVI8AIvjQstwNenNV0OuEhnzGs+pXVV7EW6/SuA9T6wxdWRE=
Message-ID: <43B953BF.50602@gmail.com>
Date: Mon, 02 Jan 2006 18:24:31 +0200
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20051014 Thunderbird/1.0.7 Mnenhy/0.7.2.0
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Matan Peled <chaosite@gmail.com>
CC: kwallinator@gmail.com
Subject: Re: Arjan's noinline Patch
References: <20060101155710.GA5213@kurtwerks.com> <20060102034350.GD5213@kurtwerks.com> <43B8FA70.2090408@gmail.com> <20060102151429.GH5213@kurtwerks.com>
In-Reply-To: <20060102151429.GH5213@kurtwerks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Wall wrote:
> Right, I need to isolate the effects of each variable. Results for gcc 
> 3.4.4 and 4.0.2, built with CONFIG_CC_OPTIMIZE_FOR_SIZE enabled, appear
> below. Pardon the bad methodology.
> 
> $ size vmlinux.*
>    text    data     bss     dec     hex filename
> 2333474  461848  479920 3275242  31f9ea vmlinux.344.inline
> 2327319  462000  479920 3269239  31e277 vmlinux.344.noinline
> 2319085  461608  479984 3260677  31c105 vmlinux.402.inline
> 2313578  461800  479984 3255362  31ac42 vmlinux.402.noinline

Yes, thats more like the rest of the results I seen... BTW, what is the .config?

Here are my results. Kernel is 2.6.15-rc7, gcc is 4.0.2 (Gentoo 4.0.2-r2, 
HTB-4.0.2-1.00, pie-8.7.8)

'ay' denotes allyesconfig, def is defconfig.

I believe that neither of these have OPTIMIZE_FOR_SIZE turned on, but I didn't 
play with that.

allyesconfig made a huge kernel, so I manually 'fixed' the formatting.

kaitou inlinetest # size *def*
    text	   data	    bss	    dec	    hex	filename
3676326	1084576	 584920	5345822	 51921e	vmlinux.def.inline
3658652	1085168	 584920	5328740	 514f64	vmlinux.def.noinline


kaitou inlinetest # size *ay*
     text	   data	    bss	     dec	    hex	filename
22911557	7523774	1997000	32432331	1eee0cb	vmlinux.ay.inline
22783415	7525934	1997000	32306349	1ecf4ad	vmlinux.ay.noinline


defconfig:
	17674 byte difference (0.4%) in text.

allyesconfig:
	128142 byte difference (0.6%) in text.

Unless my math is off, that is.

-- 
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred

