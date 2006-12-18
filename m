Return-Path: <linux-kernel-owner+w=401wt.eu-S1754540AbWLRUYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540AbWLRUYp (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 15:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754536AbWLRUYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 15:24:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:44593 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543AbWLRUYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 15:24:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nenQM1sJlfDUO7XR6jdH7/3Ff0+PvZwwxzK4t276eYFXJUlqxrX6fuV6daqyfcp/gYlLpHiYivELhqJB402p3IMPDolAWhybt9UW998LVZiP6vZEBsOBohRrzSwTgWe2Pvimv+9+Wjy/eaVAkyAMClJnK99A7YniYf5938rhDSQ=
Message-ID: <653402b90612181224r4106dbf4g16b258f6a4a860@mail.gmail.com>
Date: Mon, 18 Dec 2006 21:24:43 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Subject: Re: [PATCH davem] drivers: add LCD support
Cc: davem@davemloft.net, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061218093855.01445a7c.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061108204908.8def2283.maxextreme@gmail.com>
	 <653402b90611110203y6ea7356re77c6de6fb868807@mail.gmail.com>
	 <20061218093855.01445a7c.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/06, Randy Dunlap <randy.dunlap@oracle.com> wrote:
>
> Hi,
>
> Shouldn't the framebuffer part of this code (cfag12864bfb) also
> depend on CONFIG_FB?  Without that, this build error occurs:
>

Indeed it should. Thanks for noticing that!

> cfag12864bfb.c:(.init.text+0xc19d): undefined reference to `framebuffer_alloc'
> cfag12864bfb.c:(.init.text+0xc211): undefined reference to `register_framebuffer'
> cfag12864bfb.c:(.text+0xf2782): undefined reference to `unregister_framebuffer'
> cfag12864bfb.c:(.text+0xf2789): undefined reference to `framebuffer_release'
>
> (from 2.6.20-rc1-mm1)
>
> so you may need to modify the Kconfig and Makefile to have a
> separate config entry for cfag12864bfb (or is it always required?).
>

For normal users, yes, it is the only way (yet) to use cfag12864b
(through a framebuffer). However, I divided the code in logical blocks
so it is more modular (easier understanding, scalability...), so
anyone can easily add a new way to control the LCD without worring
about other unrelated stuff the code.

>
> And while you are there (in the Kconfig file), please change
> (hertzs) to (hertz).
>

Thanks again.

-- 
Miguel Ojeda
http://maxextreme.googlepages.com/index.htm
