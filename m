Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313784AbSDQMaZ>; Wed, 17 Apr 2002 08:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313819AbSDQMaY>; Wed, 17 Apr 2002 08:30:24 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:27098 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S313784AbSDQMaX>; Wed, 17 Apr 2002 08:30:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: "Anthony J. Breeds-Taurima" <tony@cantech.net.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Change "return EBLAH" to "return -EBLAH in drivers/*
Date: Wed, 17 Apr 2002 15:29:35 +0300
X-Mailer: KMail [version 1.4]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0204171223370.14274-100000@thor.cantech.net.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200204171529.35613.nahshon@actcom.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 April 2002 07:42 am, Anthony J. Breeds-Taurima wrote:
> --- linux-2.4.19-pre6.clean/drivers/net/plip.c  Mon Oct 22 16:05:31 2001
> +++ linux-2.4.19-pre6/drivers/net/plip.c        Wed Apr 17 11:08:35 2002
...
> -                       return ERROR;
> +                       return -ERROR;

At least the changes to plip.c are wrong.

ERROR is not an errno value:
	#define ERROR     2
and the return from this function is propgated to a test
                if (error != ERROR) { /* Timeout */
Which will go wrong with the suggested patch.

-- Itai

