Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262997AbSJBIAg>; Wed, 2 Oct 2002 04:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262998AbSJBIAf>; Wed, 2 Oct 2002 04:00:35 -0400
Received: from kim.it.uu.se ([130.238.12.178]:61108 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S262997AbSJBIAe>;
	Wed, 2 Oct 2002 04:00:34 -0400
Date: Wed, 2 Oct 2002 10:06:00 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210020806.KAA17736@kim.it.uu.se>
To: jamagallon@able.es
Subject: Re: bad function ptrs - is it dangerous ?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Oct 2002 00:51:25 +0200, J.A. Magallon wrote:
>int (*pf)(data *);
>int f(data*);
>
>so you can:
>
>pf = f;
>pf(data).
>
>Fine. But what happens if:
>
>void (*pf)(data *);
>int f(data*);
>
>pf = f; // gcc happily swallows, gcc-3.2 gives a warning.
>pf(data).

Undefined Behaviour. I can easily imagine cases where, depending
on the calling convention and the actual return type, things could
go very very wrong. Consider struct returns...

This case, returning an int to a caller expecting void, is likely
to work on most normal machines -- the int would go into a GP result
register, and the GP result register is typically always part of the
caller-save set. The code is still utter crap, however.

>The (in)famous graphics driver all you know is doing this with the
>copy_info op for gart...

<censored>

/Mikael
