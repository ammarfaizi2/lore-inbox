Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292971AbSCSV6s>; Tue, 19 Mar 2002 16:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293071AbSCSV62>; Tue, 19 Mar 2002 16:58:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21779 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S292971AbSCSV6U>; Tue, 19 Mar 2002 16:58:20 -0500
Date: Tue, 19 Mar 2002 22:58:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: Larry McVoy <lm@work.bitmover.com>, Dave Jones <davej@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper licence issues
Message-ID: <20020319215800.GN12260@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020318212617.GA498@elf.ucw.cz> <20020318144255.Y10086@work.bitmover.com> <20020318231427.GF1740@atrey.karlin.mff.cuni.cz> <20020319002241.K17410@suse.de> <20020318180233.D10086@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  > > Pavel, the problem here is your fundamental distrust.  
> >  > By giving me binary-only installer you ask me to trust you. You ask me
> >  > to trust you without good reason [it only generates .tar.gz and
> >  > shellscript, why should it be binary? Was not shar designed to handle
> >  > that?], and that's pretty suspect.
> > 
> >  Bitmover doing anything remotely suspect in an executable installer
> >  would be commercial suicide, do you distrust realplayer too?
> 
> And all our installer does, and I will give you the code if you want it,
> I'd be happy to even have Pavel audit it, is make two arrays, 

Okay, you wanted audit ;-).

> main()
> {
>         char    installer_name[200];
>         char    data_name[200];
>         char    cmd[2048];
>         int     fd;
> 
>         fprintf(stderr, "Please wait while we unpack the installer...");
>         sprintf(installer_name, "/tmp/installer%d", getpid());
>         fd = creat(installer_name, 0777);

If nasty user on same system creates symlink (ln -s /etc/passwd
/tmp/installer123), he may overwrite any file on the system. You probably want

fd = open(installer_name, O_WRONLY | O_TRUNC | O_CREAT | O_EXCL, 0755);

Same goes for data.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
