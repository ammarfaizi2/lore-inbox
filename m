Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbSKUURv>; Thu, 21 Nov 2002 15:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264711AbSKUURv>; Thu, 21 Nov 2002 15:17:51 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:2697 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S264697AbSKUURu>; Thu, 21 Nov 2002 15:17:50 -0500
Date: Thu, 21 Nov 2002 18:24:40 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Matt Young <wz6b@arrl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Operations inside a module
In-Reply-To: <200211211159.03552.wz6b@arrl.net>
Message-ID: <Pine.LNX.4.44L.0211211821560.1644-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2002, Matt Young wrote:

> Within the open routine of my module I need to open another device; and
> the write routine needs to write to the other device.
>
> User space system calls seem to be unavailable to module code. I know
> about swapping the DS and ES to fake out other modules; then using
> sys_write etc.

You don't need the system calls, you can just call the in-kernel
functions directly. If one of the functions you want isn't exported
you could either use an exported alternative or export it yourself
by patching your kernel.  However, chances are that if it's not
exported it'll be changed or gone 10 kernels down the line, so you
don't want to use it anyway. ;)

> My module code would also like to use user space malloc, is this a
> problem?

Yes. This is absolutely impossible.

Think of the kernel as a shared library, a shared library that
causes the process that calls a function from it to switch into
supervisor mode.

regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

