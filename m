Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315433AbSEMBZM>; Sun, 12 May 2002 21:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315448AbSEMBZM>; Sun, 12 May 2002 21:25:12 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:22912 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S315433AbSEMBZK>; Sun, 12 May 2002 21:25:10 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 12 May 2002 18:34:53 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Rose, Billy" <wrose@loislaw.com>
cc: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Segfault hidden in list.h
In-Reply-To: <4188788C3E1BD411AA60009027E92DFD0962E251@loisexc2.loislaw.com>
Message-ID: <Pine.LNX.4.44.0205121823530.995-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002, Rose, Billy wrote:

> The code inside of __list_add:
>
> next->prev = new;
> new->next = next;
> new->prev = prev;
> pre-next = new;
>
> needs to be altered to:
>
> new->prev = prev;
> new->next = next;
> next->prev = new;
> prev->next = new;

you need a wmb also :

new->prev = prev;
new->next = next;
wmb
next->prev = new;
prev->next = new;




- Davide




