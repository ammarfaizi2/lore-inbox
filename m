Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316778AbSE0WsC>; Mon, 27 May 2002 18:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316779AbSE0WsB>; Mon, 27 May 2002 18:48:01 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:50822 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316778AbSE0WsA>; Mon, 27 May 2002 18:48:00 -0400
Date: Mon, 27 May 2002 17:47:58 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "J.A. Magallon" <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] gcc3 arch options
In-Reply-To: <20020527214248.GA1848@werewolf.able.es>
Message-ID: <Pine.LNX.4.44.0205271738160.25398-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2002, J.A. Magallon wrote:

> >CFLAGS is initially defined with ':=', which, as opposed to '=' means to 
> >evaluate directly and store the resulting string, so it should be fine. 
> 
> It even does not depend on that. That is exactly the difference between
> $(shell ) and backquoting.
> 
> Try this (with both = and :=):
> 
> # Makefile
> 
> A=
> B=
> #A:=
> #B:=
> A+=$(shell date)
> B+=`date`
> 
> all:
>     @echo "A="$(A)
>     @sleep 2
>     @echo "A="$(A)
>     @sleep 2
>     @echo "B="$(B)
>     @sleep 2
>     @echo "B="$(B)

Actually, it makes a difference. Backquoting doesn't really have anything 
to do with the problem at all, since make doesn't understand it, it
just puts literally "`date`" into the variable, so you pass
echo "B="`date` to the shell, which will then to the substitution.

(Try

C = `echo all.c`

all: $(C)

it won't compile all, even if there is all.c - backquoting can only work
in the command part of a rule.)

Anyway, A= vs A:=, A += $(shell ...) behaves differently, as I 
conjectured. Example:

VAR =
#VAR :=
VAR += $(shell echo $$RANDOM)

all:
	@echo $(VAR)
	@echo $(VAR)


Not that it really matters...

--Kai





