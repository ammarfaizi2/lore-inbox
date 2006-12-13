Return-Path: <linux-kernel-owner+w=401wt.eu-S932611AbWLMIFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbWLMIFl (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 03:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWLMIFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 03:05:41 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:52843 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932611AbWLMIFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 03:05:40 -0500
X-Greylist: delayed 12353 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 03:05:40 EST
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64
From: Kasper Sandberg <lkml@metanurb.dk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, ak@muc.de, vojtech@suse.cz
In-Reply-To: <200612130253_MC3-1-D4E3-471@compuserve.com>
References: <200612130253_MC3-1-D4E3-471@compuserve.com>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 09:05:20 +0100
Message-Id: <1165997121.23819.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 02:50 -0500, Chuck Ebbert wrote:
> In-Reply-To: <1165984783.23819.7.camel@localhost>
> 
> On Wed, 13 Dec 2006 05:39:43 +0100, Kasper Sandberg wrote:
> 
> > do you think it may be a bug in the kernel? the stuff with wine that
> > gets thrown in the kernel messages?
> 
> Let's just say the behavior has changed.  It now returns
> -EINVAL instead of -ENOTTY when the msdos IOCTLs fail.
> 
> > im 100% positive wine does NOT have
> > access to any fat32, cause i entirely removed the only disk having such
> > a filesystem, and it still likes to give this
> 
> That's when this happens: running certain programs that try
> msdos-type IOCTLs on native Linux filesystems.
ohhh :) well wine may do that :)
> 
> > however the last few
> > times i havent observed the app going nuts
> 
> If there aren't any other problems you can just turn off the logging.
> 
> Did you change something else?
i did upgrade from rc5 to final

> 
> Anyway, here is a much simpler patch that restores the previous
> behavior (but leaves the message.)  However if you aren't having
> any problems now other than the messages maybe there's no real
> problem after all?

well the hardlock problem still occurs, however that, (as i believe has
veen the semi-conclusion in this thread) arent related?

> 
> --- 2.6.19.1-64smp.orig/fs/compat.c
> +++ 2.6.19.1-64smp/fs/compat.c
> @@ -444,7 +444,11 @@ asmlinkage long compat_sys_ioctl(unsigne
>  
>  		if (++count <= 50)
>  			compat_ioctl_error(filp, fd, cmd, arg);
> -		error = -EINVAL;
> +
> +		if (cmd == 0x82187201)
> +			error = -ENOTTY;
> +		else
> +			error = -EINVAL;
>  	}
>  
>  	goto out_fput;

