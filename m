Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316245AbSEVQzj>; Wed, 22 May 2002 12:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316252AbSEVQzi>; Wed, 22 May 2002 12:55:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34066 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316245AbSEVQzf>; Wed, 22 May 2002 12:55:35 -0400
Date: Wed, 22 May 2002 18:55:37 +0200
From: Jan Kara <jack@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
Message-ID: <20020522165537.GC12982@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.GSO.4.21.0205220801540.1068-100000@weyl.math.psu.edu> <3CEB9826.4070000@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,
  
> Uz.ytkownik Alexander Viro napisa?:
> >
> >On Wed, 22 May 2002, Martin Dalecki wrote:
> > 
> >
> >>Or are are you going to reinvent just enother
> >>case of /proc/ formatting compatibility problems?!
> >>And the requirement to have /proc mounted for quoate usage?!
> >>
> >>I hate /proc/my/random/sandbox/becouse/I/dont/knwo/unix/and/have/no/taste
> >>interfaces more and more...
> >>
> >>(PS. Hah! I found finally someone today who deserves flames! :-).)
> >
> >
> >Gives the phrase "finding yourself" a whole new meaning, doesn't it?
> >
> >Al, deeply PO'd by assorted cretinisms _not_ related to the kernel.
> >Sigh...
> 
> Lokking at 2.5.17 I see the following:
> 
> -#define QUOTAFILENAME "quota"
> -#define QUOTAGROUP "staff"
> 
> 
> As usuall we can see what goes to /proc is apparently
> random bulls*it as always. I love in esp. the assumption about
> some group name on a system!
> But it get's removed this time. So let's peer where
> it get's reintroduced:
  gets reintroduced? I think I removed QUOTAGROUP forever...
  
> Ah... yes, patch-2.5.17, here it is:
> 
> +#ifdef CONFIG_PROC_FS
> +static int read_stats(char *buffer, char **start, off_t offset, int count, 
> int *eof, void *data)
> +{
> + 
  <snip>
  
> return len;
> +}
> +#endif
> 
> What can we see in the above:
> 
> 1. Those are first grade candidates for sysctl read-only entires, since they
>    are system global statistics which should belong to /proc/sys/fs/
>    We even have already fs.dquot-nr there! Why the hell don't put them
>    alongside?
> 
> 2. Typical string formating and value copy and termination
>     problems inherent to string stuff...
  I agree that the proc code isn't good (maybe you missed the mail from
Christoph Hellwing and my answer to it...) and should be replaced.

> 3. The futile hope that tools using it will even bother to check the
>    Version... gtop just *right today* showed that user space programmers
>    won't care about it, so it gains us literally *nothing*.
  The hope isn't futile I think. At least quota tools (which are
IMHO the most interesting) are checking the version and warning user
about too new kernel.

> If it where sysctl numbers they would just vanish beneath them if something
> changed semantincally and they *would have no chance* to do it wrong.
  The version isn't there only for format of that quota file in proc.
It's *mainly* used for detection of kernel interface to use. Previously
tools had to try a few quotactl()s and from their results they had to
guess the quota format etc. With version somewhere it's a bit easier...
  Looking forward to next flame from you ;)

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
