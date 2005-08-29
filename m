Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbVH2XZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbVH2XZW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 19:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbVH2XZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 19:25:22 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:43029 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751414AbVH2XZW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 19:25:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AWhSsSQRS/V3+YfGmxS9iPjat+CHeLuzME8MQYpR4UUwU8+hYGuFri4AZN2gYB91g5pKTF3lnGuzKl7Dz8XUZ8dFRIoIzbGSxxPA+SqZTiW1v4wiqAqs9Bx2Ok7AwAmpoWmP9RhWcQIywtbIowQKjJ682+3GKu9hSo0KlgCeB0A=
Message-ID: <9a8748490508291625321e4e3b@mail.gmail.com>
Date: Tue, 30 Aug 2005 01:25:21 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Subject: Re: Linux-2.6.13 : __check_region is deprecated
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050829231417.GB2736@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050829231417.GB2736@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Stephane Wirtel <stephane.wirtel@belgacom.net> wrote:
> Hi,
> 
> By compiling my kernel, I can see that the __check_region function (in
> kernel/resource.c) is deprecated.
> 
[snip]
> 
> Is there a function to replace this deprecated function ?
> 
Yes, you just call request_region() and check its return value.


> Why is it deprecated ?
> 
In the past you first called check_region() followed by
request_region() if the region was available. That is not safe as you
could get interrupted between the two calls and something else might
have already grabbed the region you thought was free by the time you
get to calling request_region().  So, request_region() was rewritten
to do the checking internally and let the caller know via its return
value if
acquiring the region failed or succeded. 
So these days check_region should no longer be used. It's a historic
relic. request_region() should be used directly instead. That's why it
is deprecated.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
