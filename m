Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316659AbSE0Vqn>; Mon, 27 May 2002 17:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316722AbSE0Vqm>; Mon, 27 May 2002 17:46:42 -0400
Received: from jalon.able.es ([212.97.163.2]:17054 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316659AbSE0Vqd>;
	Mon, 27 May 2002 17:46:33 -0400
Date: Mon, 27 May 2002 23:42:48 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH][RFC] gcc3 arch options
Message-ID: <20020527214248.GA1848@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.44.0205271030240.24699-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.27 Kai Germaschewski wrote:
>On Mon, 27 May 2002, David Woodhouse wrote:
>
>> jamagallon@able.es said:
>> > +CFLAGS += $(shell if $(CC) -march=pentium-mmx -S -o /dev/null -xc /
>> > dev/null >/dev/null 2>&1; then echo "-march=pentium-mmx"; else echo
>> > "-march=i586"; fi)
>> 
>> Doesn't this run the shell command every time $(CFLAGS) is used?
>
>CFLAGS is initially defined with ':=', which, as opposed to '=' means to 
>evaluate directly and store the resulting string, so it should be fine. 
>
>Even if it wasn't, only the evaluations from the top-level Makefile would
>cause the command to be executed, make will always pass down the evaluated 
>result to the subdir makes.
>

It even does not depend on that. That is exactly the difference between
$(shell ) and backquoting.

Try this (with both = and :=):

# Makefile

A=
B=
#A:=
#B:=
A+=$(shell date)
B+=`date`

all:
    @echo "A="$(A)
    @sleep 2
    @echo "A="$(A)
    @sleep 2
    @echo "B="$(B)
    @sleep 2
    @echo "B="$(B)


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam4 #2 SMP dom may 26 11:20:42 CEST 2002 i686
