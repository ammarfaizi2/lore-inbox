Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280015AbRKSQsC>; Mon, 19 Nov 2001 11:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280032AbRKSQr6>; Mon, 19 Nov 2001 11:47:58 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:54434 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S280015AbRKSQrj>; Mon, 19 Nov 2001 11:47:39 -0500
Date: Mon, 19 Nov 2001 10:47:23 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200111191647.KAA36330@tomcat.admin.navo.hpc.mil>
To: vda@port.imtp.ilyichevsk.odessa.ua, James A Sutherland <jas88@cam.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: x bit for dirs: misfeature?
In-Reply-To: <01111916583804.00817@nemo>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda <vda@port.imtp.ilyichevsk.odessa.ua>
> 
> On Monday 19 November 2001 14:36, James A Sutherland wrote:
> > On Monday 19 November 2001 4:22 pm, vda wrote:
> > > Everytime I do 'chmod -R a+rX dir' and wonder are there
> > > any executables which I don't want to become world executable,
> > > I think "Whatta hell with this x bit meaning 'can browse'
> > > for dirs?! Who was that clever guy who invented that? Grrrr"
> > >
> > > Isn't r sufficient? Can we deprecate x for dirs?
> > > I.e. make it a mirror of r: you set r, you see x set,
> > > you clear r, you see x cleared, set/clear x = nop?
> > >
> > > Benefits:
> > > chmod -R go-x dir (ensure there is no executables)
> > > chmod -R a+r dir (make tree world readable)
> > > mount -t vfat -o umask=644 /dev/xxx dir
> > > 	(I don't want all files to be flagged as executables there)
> > >
> > > These commands will do what I want without (sometimes ugly) tricks.
> > > For mount, I can't even see how to do it with current implementation.
> > >
> > > What standards will be broken?
> > > Any real loss of functionality apart from compat issues?
> 
> > The R and X bits on directories have different meanings. Watch:
> 
> I know. I'd like to hear anybody who have a directory with r!=x
> on purpose (and quite curious on that purpose). UNIX gugus, anybody?

It's used to hide files in anonymous FTP for for one. It prevents you from
retrieving files that you don't know the name of. Yes, a brute force attempt
to open MAY work to find the unknown file, it will take a long time, and you
are most likely to be detected. The anonymous FTP use is usually in an incoming
directory - the files are put there from remote individuals, and are hidden
(unless someone is a good guesser/or a poor name chosen) until the
administrator examines/moves them.

> 
> > $ mkdir test
> > $ echo content > test/file
> > $ chmod a-r test
> > $ ls test
> > ls: test: permission denied
> > $ cat test/file
> > content
> > $ chmod a=r test
> > $ ls test
> > ls: test/file: Permission denied
> 
> Hmm... I do actually tested this and last command succeeds
> (shows dir contents). You probably meant cat test/file, not ls...
> 
> > In short, the X bit allows you to access the contents of the directory,
> > while R allows you to LIST those contents. There are valid uses for X only
> > directories (i.e. users are not allowed to list the contents, only to
> > access them directly by name). R-only directories make little sense, as you
> > can see from the transcript above :)

It's there for consistancy/simplisity. Mode bits for directories are treated
the same as they are for any other type of file.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
