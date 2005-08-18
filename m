Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbVHRLGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVHRLGl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 07:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbVHRLGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 07:06:41 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:60862 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932172AbVHRLGk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 07:06:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c2NE1WjIj/NnSkDs7OW+ncR0Mru4CtVxoodf30HU55eL80ybqD4ZZCm/gokYlXS83IoS69GKSTUGkiJa2e3spbZbQNdzI1HYS+7RaFgK5ZAHfxjDrwCv6NO5+7CkcHBgtJNon4dhThm2HlAqqTJWRLkPsK/3HcQZPgdyJr+UDvY=
Message-ID: <98df96d305081804061ea70686@mail.gmail.com>
Date: Thu, 18 Aug 2005 20:06:39 +0900
From: Hiro Yoshioka <lkml.hyoshiok@gmail.com>
Reply-To: hyoshiok@miraclelinux.com
To: Andi Kleen <ak@suse.de>
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Cc: Arjan van de Ven <arjan@infradead.org>, taka@valinux.co.jp,
       linux-kernel@vger.kernel.org, Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <p73oe7y10qw.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050816.131729.15816429.taka@valinux.co.jp.suse.lists.linux.kernel>
	 <20050816.135425.719901536.hyoshiok@miraclelinux.com.suse.lists.linux.kernel>
	 <1124171015.3215.0.camel@laptopd505.fenrus.org.suse.lists.linux.kernel>
	 <20050816.191617.1025215458.hyoshiok@miraclelinux.com.suse.lists.linux.kernel>
	 <1124187950.3215.31.camel@laptopd505.fenrus.org.suse.lists.linux.kernel>
	 <p73oe7y10qw.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Aug 2005 15:15:35 +0200, Andi Kleen <ak@suse.de> wrote:
> However it disables preemption, which especially for bigger
> copies will probably make the low latency people unhappy.

In the copy loop,
+#ifdef CONFIG_PREEMPT
+               if ( (i%64)==0 ) {
+                   MMX_RESTORE;
+                   MMX_SAVE;
+               };
+#endif

It costs several hundred clocks (wow) every 4KB copy.

It kills throughput but it makes the low latency people smile.

So I make two APIs. 
__copy_user_zeroing_nocache()
__copy_user_zeroing_inatomic_nocache()

The former is a low latency version and the other is a throughput version.

What do you think?

Regards,
  Hiro

-- 
Hiro Yoshioka
mailto:hyoshiok at miraclelinux.com
