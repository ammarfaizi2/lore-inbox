Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271112AbTGXG4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 02:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271113AbTGXG4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 02:56:52 -0400
Received: from soft.uni-linz.ac.at ([140.78.95.99]:26623 "EHLO
	zeus.soft.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id S271112AbTGXG4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 02:56:52 -0400
Message-ID: <3F1F86A9.8010909@gibraltar.at>
Date: Thu, 24 Jul 2003 09:11:37 +0200
From: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: de-at, de-de, en-gb, en-us
MIME-Version: 1.0
To: Jason Baron <jbaron@redhat.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>,
       vda@port.imtp.ilyichevsk.odessa.ua,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root seems to be broken in 2.4.21-ac4 and 2.4.22-pre7
References: <Pine.LNX.4.44.0307232136370.8637-100000@dhcp64-178.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0307232136370.8637-100000@dhcp64-178.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Baron wrote:
> right. so the semantics of how file tables are shared has changed a bit. I
> would think that for at least 'init', it'd be nice to preserve the
> original behavior, for situations such as you described. Something like
> the following would probably work, although i havent' tried the test
> script.
> 
> --- linux/kernel/fork.c.orig  2003-07-23 21:34:59.000000000 -0400
> +++ linux/kernel/fork.c       2003-07-23 21:35:45.000000000 -0400
> @@ -558,7 +558,7 @@ int unshare_files(void)
>  
>         /* This can race but the race causes us to copy when we don't
>            need to and drop the copy */
> -       if(atomic_read(&files->count) == 1)
> +       if(atomic_read(&files->count) == 1 || (current->pid == 1))
>         {
>                 atomic_inc(&files->count);
>                 return 0;

Thanks for the hint ! I will try that in the evening. Any chance that 
this will be in 2.4.22 final ?

best regards,
Rene



