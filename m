Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933670AbWKWNNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933670AbWKWNNP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 08:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933673AbWKWNNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 08:13:15 -0500
Received: from nz-out-0102.google.com ([64.233.162.196]:28564 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S933670AbWKWNNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 08:13:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p1higzym/njCSg5vCKaITPQiQQzZWQHjLGbGfmXzxU0LtDtHKfHnqp1YSR0pwQxiVMxUNn+9C+YZJF1mxWiUCNFsXjLO2hzFBVMU+PF1F6l3gUssA4OT9UUh/u6n0rVbEAzMzEK07TTeEPfdnFvYa0s31/Hgs/7B6t8qJ7z3V1c=
Message-ID: <9a8748490611230513y258ab33cgf9733b2a8cd93f74@mail.gmail.com>
Date: Thu, 23 Nov 2006 14:13:12 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Ian Molton" <spyro@f2s.com>
Subject: Re: BUG: 2.6.19-rc6 net/irda/irlmp.c
Cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <45657BD4.5040604@f2s.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45657BD4.5040604@f2s.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/06, Ian Molton <spyro@f2s.com> wrote:
> spin_lock_irqsave_nested is used in net/irda/irlmp.c
>
> Im not sure what it _should_ be, but thought it worth reporting.

I reported this yesterday - http://lkml.org/lkml/2006/11/22/137 - It
is commit 700f9672c9a61c12334651a94d17ec04620e1976 that breaks the
build.

Linus: I think that commit should either be reverted or fixed in a
different way before 2.6.19. As it is right now we have a build
failure :

net/built-in.o: In function `irlmp_slsap_inuse':
net/irda/irlmp.c:1681: undefined reference to `spin_lock_irqsave_nested'
make: *** [.tmp_vmlinux1] Error 1

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
