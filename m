Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292249AbSBZRXl>; Tue, 26 Feb 2002 12:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288967AbSBZRX1>; Tue, 26 Feb 2002 12:23:27 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:11537 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S292249AbSBZRWl>; Tue, 26 Feb 2002 12:22:41 -0500
Date: Tue, 26 Feb 2002 14:22:31 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: ext3 and undeletion
In-Reply-To: <20020226171634.GL4393@matchmail.com>
Message-ID: <Pine.LNX.4.44L.0202261419240.1413-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Mike Fedyk wrote:
> On Tue, Feb 26, 2002 at 06:07:49PM +0100, Martin Dalecki wrote:
> > >>For the educated user it was always a pain
> > >>in the you know where, to constantly run out of quota space due to
> > >>file versioning.
> > >>
> > >
> > >Ahh, so we'd need to chown the files to root (or a configurable user and
> > >group) to get around the quota issue.
> >
> > Welcome to my kill-file. This just shows that you don't even have basic
> > background.
>
> Thank you.
>
> Now, if I'm talking out of my ass, can someone sane say so?

Your idea should work on deletion, when the inode were
about to be destroyed, but ...

> It would only call chown/chgrp on the files *inside* the undelete dir,
> and user,group,etc would have to be accounted for in another way.  Am I
> going in the wrong direction?

... of course, there still is the problem of hard links.

If you unlink a file, it might still be around under
another name.

Consider:

$ ln bigfile newbigfile
$ rm bigfile

Under your scheme, maybe bigfile would be moved to the
undeletion area ... fine.

The problem would start if the ownership was changed
to root, because then 'newbigfile' would also be owned
by root and you could no longer access your file ;)

regards,

Rik
-- 
Will hack the VM for food.

http://www.surriel.com/		http://distro.conectiva.com/

