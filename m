Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317436AbSGTQXK>; Sat, 20 Jul 2002 12:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317439AbSGTQXK>; Sat, 20 Jul 2002 12:23:10 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:57338 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317436AbSGTQXJ>; Sat, 20 Jul 2002 12:23:09 -0400
Date: Sat, 20 Jul 2002 18:26:07 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Leonardo Gomes Figueira <sabbath@planetarium.com.br>,
       Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Memory detection problem in 2.4.19-rc2
In-Reply-To: <3D391A54.4020404@planetarium.com.br>
Message-ID: <Pine.NEB.4.44.0207201806350.16962-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jul 2002, Leonardo Gomes Figueira wrote:

> Hi,
>
> i have a Toshiba K6-2 450 notebook with 32MB RAM onboard plus an 256MB chip.
>
> I use kernel 2.4.18 with the mem param on the boot (mem=288M) and it
> works fine. (Without the mem param it only detects 32MB).
>
> I've been testing 2.4.19-preX (8,9,10 maybe others before, i don't
> remember) and 2.4.19-rcX (1,2) but in this releases it don't detect more
> than 32MB even with the mem param. I didn't test in 2.4.19-rc3 yet but i
> read the changelog and didn't see any change in this area but i can test
> if it helps.
>...

It seems that the change Christoph introduced (from Red Hat's tree) in the
lines around 810 (line number in -rc3) in arch/i386/kernel/setup.c didn't
consider the case that someone want's to _in_crease the size of the memory
by using the "mem="  parameter.

It's the following Changeset:

<--  snip  -->

   Changeset details for 1.383.2.25

   ChangeSet@1.383.2.25  2002-04-15 23:18:40-03:00  hch@infradead.org
   all diffs
   [PATCH] mem= command lines fixes.
   Another patch from Red Hat's tree:
     mem= command-line adapts itself to existing e820 values.
     without this patch mem=xxxM ignores bios-reserved areas and uses
     them as RAM. This patch makes the kernel skip these areas
   arch/i386/kernel/setup.c@1.38  2001-04-05
   21:19:09-03:00  hch@infradead.org

<--  snip  -->

> Thanks,
>
>     Leo
>...

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



