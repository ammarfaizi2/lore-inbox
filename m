Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbVLMSaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbVLMSaJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbVLMSaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:30:08 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:50528 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932574AbVLMSaG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:30:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NFc/dB7EnL2J63/Kgp4O361Wz4ULtCLc7DFhJ/rAOqQ8STvPOq5CoN72am1N6keOZtSVlYlhlT4nSKMt1Okyb6vdERiPj8942Z7sLSvsyL7lbPaKd4Qlzg2Vtl/1+Wr66qw+PWupR26Po/Xg7sSBYs9PmobecoWNbksh5bVx41Q=
Message-ID: <e46c534c0512131030v45640694t1030468ac5775804@mail.gmail.com>
Date: Tue, 13 Dec 2005 18:30:00 +0000
From: Filipe Cabecinhas <filcab@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: Possible problem in fcntl
Cc: linux-kernel@vger.kernel.org, Nuno Lopes <ncpl@mega.ist.utl.pt>,
       =?ISO-8859-1?Q?Renato_Cris=F3stomo?= <racc@mega.ist.utl.pt>
In-Reply-To: <Pine.LNX.4.61.0512131242280.8370@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e46c534c0512130756k18c409aen3d60df7aaee50062@mail.gmail.com>
	 <Pine.LNX.4.61.0512131242280.8370@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/05, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:

> So what is it that the socket doesn't do, that you expect it
> should do?
>

When we call recv on that socket, it returns 0 and sets the string to
"" (as if the the client had done an orderly shutdown (which is not
true, since wget says connection refused).

We were expecting it to return -1 and set errno to EAGAIN (or to
return the number of bytes written and set the string to what it
received).

It works as expected if we don't have that (second) fcntl call. But,
as the accept manpage tells us, in linux the socket returned by accept
() does  not  inherit  file status  flags such as O_NONBLOCK, so we
think we should call it (to be sure it has that flag). And, even if it
isn't necessary, we can't tell why it's breaking (because it would
just be setting a flag (that is already set )).

Thanks in advance,
Filipe Cabecinhas
