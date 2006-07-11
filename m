Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWGKNPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWGKNPw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWGKNPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:15:52 -0400
Received: from [195.23.16.24] ([195.23.16.24]:44267 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1751203AbWGKNPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:15:51 -0400
Message-ID: <44B3A484.5000002@grupopie.com>
Date: Tue, 11 Jul 2006 14:15:48 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Theodore Tso <tytso@mit.edu>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: tty's use of file_list_lock and file_move
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>	 <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com>	 <1152554708.27368.202.camel@localhost.localdomain>	 <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>	 <1152573312.27368.212.camel@localhost.localdomain>	 <9e4733910607101604j16c54ef0r966f72f3501cfd2b@mail.gmail.com>	 <9e4733910607101649m21579ae2p9372cced67283615@mail.gmail.com>	 <20060711012904.GD30332@thunk.org>	 <9e4733910607101916y4638c097ie26ae63a9949bc3e@mail.gmail.com>	 <1152612752.18028.3.camel@localhost.localdomain> <9e4733910607110528t73d5d7dai73efd59caddb9d25@mail.gmail.com>
In-Reply-To: <9e4733910607110528t73d5d7dai73efd59caddb9d25@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
>[...]
>  extern struct tty_driver *ptm_driver;	/* Unix98 pty masters; for /dev/ptmx */
> @@ -158,21 +157,21 @@ static struct tty_struct *alloc_tty_stru
>  {
>  	struct tty_struct *tty;
>  
> -	tty = kmalloc(sizeof(struct tty_struct), GFP_KERNEL);
> -	if (tty)
> -		memset(tty, 0, sizeof(struct tty_struct));
> +	tty = kmalloc(sizeof(*tty), GFP_KERNEL);
               ^^^^^^^
kzalloc?

I don't know this code very well, so you might be actually changing the 
initialization here. On the other hand, this might be just a simple bug...

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?
