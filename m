Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRB1ULT>; Wed, 28 Feb 2001 15:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129216AbRB1ULK>; Wed, 28 Feb 2001 15:11:10 -0500
Received: from cc78409-a.hnglo1.ov.nl.home.com ([213.51.107.234]:45575 "EHLO
	dexter.hensema.xs4all.nl") by vger.kernel.org with ESMTP
	id <S129249AbRB1UKv>; Wed, 28 Feb 2001 15:10:51 -0500
Date: Wed, 28 Feb 2001 21:10:43 +0100
From: Erik Hensema <erik@hensema.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: binfmt_script and ^M
Message-ID: <20010228211043.A4579@hensema.xs4all.nl>
In-Reply-To: <20010227140333.C20415@cistron.nl> <E14XkQG-0003R7-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <E14XkQG-0003R7-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2001 at 01:44:08PM +0000, Alan Cox wrote:
> > When running a script (perl in this case) that has DOS-style
> > newlines (\r\n), Linux 2.4.2 can't find an interpreter because it
> > doesn't recognize the \r.  The following patch should fix this
> > (untested).

> Fix the script. The kernel expects a specific format


How about letting the kernel return ENOEXEC instead of ENOENT? It would
give the luser just the little extra hint about converting their files to
Unix format.

$ ls
testscript
$ head -1 testscript
#!/bin/sh
$ ./testscript
bash: ./testscript: No such file or directory

versus

$ ./testscript
bash: ./testscript: Exec format error

I haven't got a clue what Posix requires though.

-- 
Erik Hensema (erik@hensema.xs4all.nl)
