Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbVHOXeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbVHOXeE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbVHOXeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:34:04 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:58945 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932586AbVHOXeC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 19:34:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QymNsbpp7vWMAXzJOryHQqlsTYWJjtnTsyHPFAYjbJOYzlTHMbaRQD+zBbasBYLZnMhAmq1E5IQrYKb+SpIzS5TY+/zU07TsqdRwHuwhO4TosuptzP7LDHeBMbTGO4j0IGv3iJ1dqYTbOFhzl2sjKfee0S1cWlw3JdXpz8RB0oE=
Message-ID: <98df96d3050815163331d6cce1@mail.gmail.com>
Date: Tue, 16 Aug 2005 08:33:59 +0900
From: Hiro Yoshioka <lkml.hyoshiok@gmail.com>
Reply-To: hyoshiok@miraclelinux.com
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Cc: linux-kernel@vger.kernel.org, Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <1124096021.3228.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <98df96d305081402164ce52f8@mail.gmail.com>
	 <1124012489.3222.13.camel@laptopd505.fenrus.org>
	 <98df96d305081403222e75b232@mail.gmail.com>
	 <1124015743.3222.17.camel@laptopd505.fenrus.org>
	 <98df96d30508142343407b4d61@mail.gmail.com>
	 <1124090190.3228.3.camel@laptopd505.fenrus.org>
	 <98df96d305081501441bc9b121@mail.gmail.com>
	 <1124096021.3228.20.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/05, Arjan van de Ven <arjan@infradead.org> wrote:
> > copy_from_user_nocache() is fine.
> >
> > But I don't know where I can use it. (I'm not so
> >  familiar with the linux kernel file system yet.)
> 
> I suspect the few cases where it will make the most difference will be
> in the VFS for the write() system call, and the AIO variants thereof.
> 
> generic_file_buffered_write() will be a good candidate to try first...

Thanks.

filemap_copy_from_user() calls __copy_from_user_inatomic() calls
__copy_from_user_ll().

I'll look at the code.

Hiro
--
Hiro Yoshioka
mailto:hyoshiok at miraclelinux.com
