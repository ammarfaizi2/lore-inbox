Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315695AbSEILSA>; Thu, 9 May 2002 07:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315699AbSEILR7>; Thu, 9 May 2002 07:17:59 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:27908 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S315695AbSEILR6>; Thu, 9 May 2002 07:17:58 -0400
Message-Id: <200205091102.g49B2AX25891@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="koi8-r"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Paul P Komkoff Jr <i@stingr.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Some useless cleanup
Date: Thu, 9 May 2002 13:09:04 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020509102841.GA1125@stingr.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 May 2002 08:28, Paul P Komkoff Jr wrote:
> Look at this very funny cleanup changeset for 2.4
> avaliable at linux-stingr.bkbits.net/comm
>
> For those who don't have bk I including it here below.
>
> Please give your comments. Maybe it is completely useless and anything
> should stay as before, or maybe it is somewhat useful and this abstraction
> will decrease possibility of bugs such as akpm worked around in 8139too

Well, it isn't bad, but what's the point in multiple
set_xxxxxx(char *dst, char *src) functions?

Maybe it makes more sense to have a generic macro
which copies string into char[N] buffer, avoiding overflow.

Actually, there is similar code in your mail:
> -šššššššstrncpy (current->comm, dev->name, sizeof(current->comm) - 1);
> -šššššššcurrent->comm[sizeof(current->comm) - 1] = '\0';
> +šššššššset_current_title(dev->name);

A macro:

#define STRNCPY(dst,src) \
	do { \
		/* todo: put clever check that dst is char[] here */ \
		strncpy((dst), (src), sizeof(dst)-1); \
		dst[sizeof(dst)-1] = '\0'; \
	} while(0)

--
vda
