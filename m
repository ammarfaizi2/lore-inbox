Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268487AbUILQ1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268487AbUILQ1l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 12:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268539AbUILQ1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 12:27:41 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:37125 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S268487AbUILQ1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 12:27:38 -0400
Date: Sun, 12 Sep 2004 17:43:12 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH][2.4.28-pre3] I2C driver core gcc-3.4 fixes
Message-Id: <20040912174312.5ea8d2ef.khali@linux-fr.org>
In-Reply-To: <200409121510.i8CFA5Ji015615@harpo.it.uu.se>
References: <200409121510.i8CFA5Ji015615@harpo.it.uu.se>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, it results in code doing void* pointer arithmetic, but
> the kernel uses that particular gcc extension in a lot of
> places. It's ugly but known to work exactly like char*.

OK, I didn't know that. Thanks for the info.

> However, I'm no fan of void* arithmetic. Would code like
> buffer = (void*)((char*)buffer + buflen); make you happier?

Well, it makes things even uglier IMHO, so let's not do it.

> >After a quick look at the code I'd say that the buffer-like
> >parameters involved should be declared as char* instead of void* in
> >the first place, which would effectively make all further casts
> >unnecessary, and still work exactly as before.
> 
> Maybe, but that's potentially a much larger change. I'm just
> looking for the minimal changes to make the 2.4 kernel safe for
> gcc-3.4 and later (cast-as-lvalue is an error in gcc-3.5/4.0).

I'm not much in favor of "fixing" old code just to make it gcc-3.5
compliant, especially when at the same time we won't clean it up,
potentially resulting in less readable code. I would be perfectly happy
with being able to compile 2.4 kernels with gcc versions up to 3.3 and
not above. What's the exact benefit of changing old and stable code in
the end of its life cycle for it to support future compilers? I don't
get it (but at the same time I am not the one deciding here).

This was a general comment. For the specific changes you propose, if
void* works like char* when it comes to arithmetics, it looks safe and
as such is (technically) fine with me.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
