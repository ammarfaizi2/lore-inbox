Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267154AbSKMJbw>; Wed, 13 Nov 2002 04:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267156AbSKMJbw>; Wed, 13 Nov 2002 04:31:52 -0500
Received: from dp.samba.org ([66.70.73.150]:43946 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267154AbSKMJbv>;
	Wed, 13 Nov 2002 04:31:51 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Remove BUG in cpu_up 
In-reply-to: Your message of "Tue, 12 Nov 2002 22:42:07 CDT."
             <Pine.LNX.4.44.0211122236270.24523-100000@montezuma.mastecende.com> 
Date: Wed, 13 Nov 2002 20:33:11 +1100
Message-Id: <20021113093843.5C5142C253@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0211122236270.24523-100000@montezuma.mastecende.com> 
you write:
>  	ret = __cpu_up(cpu);
>  	if (ret != 0)
>  		goto out_notify;
> -	if (!cpu_online(cpu))
> -		BUG();
> +
> +	if (!cpu_online(cpu)) {
> +		ret = -EIO;
> +		goto out_notify;
> +	}

Err, no.  If __cpu_up(cpu) succeeded, that means the cpu should bloody
well be online!

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
