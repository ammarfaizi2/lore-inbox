Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318155AbSG3A2Z>; Mon, 29 Jul 2002 20:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318159AbSG3A2Y>; Mon, 29 Jul 2002 20:28:24 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:14628 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318155AbSG3A2X>; Mon, 29 Jul 2002 20:28:23 -0400
Date: Tue, 30 Jul 2002 02:32:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Theurer <habanero@us.ibm.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.19-rc3 (hyperthreading)
Message-ID: <20020730003248.GP1201@dualathlon.random>
References: <Pine.LNX.4.44L.0207292051040.3086-100000@imladris.surriel.com> <20020730000912.GA6406@714-cm.cps.unizar.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020730000912.GA6406@714-cm.cps.unizar.es>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 02:09:12AM +0200, J.A. Magallon wrote:
> How about this version (gcc-3.2 generates the same amount of assembler):
> 
> int find(int this_cpu)
> {
>     int i;
> 
>     for (   i = (this_cpu+1)%smp_num_cpus;
>             i != this_cpu;
>             i = (i+1)%smp_num_cpus  )
>     {
>         int physical = cpu_logical_map(i);
>         int sibling = cpu_sibling_map[physical];
> 
>         if (idle_cpu(physical) && idle_cpu(sibling))
>             return physical;
>     }
>     return -1;
> }

I also find the above a bit more readable, I'll rediff once more time
then.

Andrea
