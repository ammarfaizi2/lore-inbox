Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbSKLPqj>; Tue, 12 Nov 2002 10:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261627AbSKLPqj>; Tue, 12 Nov 2002 10:46:39 -0500
Received: from ns.suse.de ([213.95.15.193]:61705 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261624AbSKLPqi>;
	Tue, 12 Nov 2002 10:46:38 -0500
To: Adam Voigt <adam@cryptocomm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File Limit in Kernel?
References: <1037115535.1439.5.camel@beowulf.cryptocomm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 12 Nov 2002 16:53:26 +0100
In-Reply-To: Adam Voigt's message of "12 Nov 2002 16:45:43 +0100"
Message-ID: <p738yzywzrd.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Voigt <adam@cryptocomm.com> writes:

> --=-gjU1b+qYiuNy2hSLpQYr
> Content-Type: text/plain
> Content-Transfer-Encoding: quoted-printable
> 
> I have a directory with 39,000 files in it, and I'm trying to use the cp
> command to copy them into another directory, and neither the cp or the
> mv command will work, they both same "argument list too long" when I
> use:
> 
> cp -f * /usr/local/www/images

Kind of. The * is expanded by the shell. The kernel limits the max
length of program arguments, which is biting you here. In theory you
could increase the MAX_ARG_PAGES #define in linux/binfmts.h and
recompile. No guarantee that it won't have any bad side effects
though. The default is rather low, it should be probably increased 
(I also regularly run into this)

The actual limit of files per directory is usually around 65000 in
most fs.

For your immediate problem you can use

find -type f | xargs cp -iX -f X /usr/local/www/images


-Andi
