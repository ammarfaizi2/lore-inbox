Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVB1Nvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVB1Nvg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 08:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVB1Nuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 08:50:51 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:51692 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261596AbVB1NsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 08:48:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=A50BuOBCSL6pfNa36CtdhZ3jP7tM81BlLZMF8oiBMJinEkwr+tJSQNNkttM1Po/DBZlfdVTeubjxzVYPdTaVkP7fYxbJogHfXnLEcRceEOsefrLplIHeuqxh3vuPIbZILXAwisRl6ZgQI7fXe+mis8ql9TybDhZfcMMDqQORJUE=
Message-ID: <d120d5000502280548733724a0@mail.gmail.com>
Date: Mon, 28 Feb 2005 08:48:12 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "colbuse@ensisun.imag.fr" <colbuse@ensisun.imag.fr>
Subject: Re: [patch 3/2] drivers/char/vt.c: remove unnecessary code
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
In-Reply-To: <1109596437.422319158044b@webmail.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1109596437.422319158044b@webmail.imag.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2005 14:13:57 +0100, colbuse@ensisun.imag.fr
<colbuse@ensisun.imag.fr> wrote:
> 
> >On Mon, Feb 28, 2005 at 01:57:59PM +0100, colbuse@xxxxxxxxxxxxxxx wrote:
> >> Please _don't_ apply this, but tell me what you think about it.
> 
> >It's broken. 8)
> 
> >> --- old/drivers/char/vt.c 2004-12-24 22:35:25.000000000 +0100
> >> +++ new/drivers/char/vt.c 2005-02-28 12:53:57.933256631 +0100
> >> @@ -1655,9 +1655,9 @@
> >> vc_state = ESnormal;
> >> return;
> >> case ESsquare:
> >> - for(npar = 0 ; npar < NPAR ; npar++)
> >> + for(npar = NPAR-1; npar < NPAR; npar--)
> 
> >How many times do you want this for loop to run?
> 
> NPAR times :-). As I stated, npar is unsigned.
> 

for (npar = NPAR - 1; npar >= 0; npar--)

would be more readable and may be even faster on a dumb compiler than
your variant. Still, I'd have compiler worry about such
micro-optimizations.

-- 
Dmitry
