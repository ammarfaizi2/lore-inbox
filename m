Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313057AbSDSWHI>; Fri, 19 Apr 2002 18:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313115AbSDSWHI>; Fri, 19 Apr 2002 18:07:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13317 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313057AbSDSWHH>; Fri, 19 Apr 2002 18:07:07 -0400
Subject: Re: printk in init_module mixing with printf in insmod
To: dank@kegel.com
Date: Fri, 19 Apr 2002 23:24:51 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3CC06470.F05543C4@kegel.com> from "Dan Kegel" at Apr 19, 2002 11:39:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ygoF-000831-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   printk("Hello, world\n");
> in the module are intermixed unpleasantly, yielding output like
>     Warning: loHello,ading foo.o world
>     will taint kernel
> 
> This garbled output makes reading the debugging printk's difficult.
> 
> I suppose this isn't terribly important, since printk's are
> kind of a no-no in production, and this only affects printk's
> in init_module, but it'd be nice to know what
> the cleanest way to get rid of the mixing is.  Adding a sleep
> inside insmod seems heavyhanded.  I suppose I could redirect
> insmod's output to a file, sleep a bit, and then display the 
> file... bleah.

Probably you want to fprintf the message after the module initialise has
reported completion, instead of before. I see no good way of hiding it
the other way around.
