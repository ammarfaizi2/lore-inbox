Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132142AbRDPVSj>; Mon, 16 Apr 2001 17:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132137AbRDPVSa>; Mon, 16 Apr 2001 17:18:30 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:1540 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132127AbRDPVSO>;
	Mon, 16 Apr 2001 17:18:14 -0400
Date: Mon, 16 Apr 2001 15:37:58 +0000
From: Pavel Machek <pavel@suse.cz>
To: Chad Hogan <Chad.Hogan@inphinity.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: system call logging in userspace
Message-ID: <20010416153757.D40@(none)>
In-Reply-To: <0104121732070D.51519@usul.inphinity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <0104121732070D.51519@usul.inphinity.com>; from Chad.Hogan@inphinity.com on Thu, Apr 12, 2001 at 05:32:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Man strace, or http://subterfugue.org

> Hello,
> 
> I'm not very experienced with dealing directly with the kernel, so I was 
> hoping for a little advice...
> 
> I'd like to implement some sort of rudimentary (file)system-call logging.  
> Specifically, I'd like information about write, open, creat, unlink, and 
> maybe a few others to be pushed into userspace.  Mostly, I'd just like to 
> know what files are being created, modified, and deleted as it happens.
> 
> It seems quite easy to me -- I was thinking of doing this with a module.  
> I'll just grab the pointer from sys_call_table[__NR_open] and replace it with 
> my own little wrapper that does nothing but call the original function, and 
> then log the call in some manner.
> 
> ================
> 
> asmlinkage int my_sys_open(const char *fname, int flags, int mode)
> {
>          [preliminary stuff]
> 
>          returnval = real_sys_open(fname, flags, mode);
> 
>          [log information based on returnval, fname, whatever];
> 
>          return returnval;
> }
> 
> 
> int init_module()
> {
>          [other stuff]
> 
>          real_sys_open = sys_call_table[__NR_open];
>          sys_call_table[__NR_open] = my_sys_open;
>          return 0;
> }
> 
> init cleanup_module()
> {
>          sys_call_table[__NR_open] = real_sys_open;
> }
> 
> ===========
> 
> The simplicity of the whole thing is what scares me a little bit.  Am I being 
> horribly naive about something here?  It seems like an obviously useful 
> module to have around, and yet I've never seen it and I couldn't find anyone 
> who had done it already.  Is there a much better way to accomplish this than 
> loading in a module?  Am I risking serious fs corruption?
> 
> It occurs to me that I may have some problems if something else changes the 
> sys_call_table[__NR_open] and the two modules don't cooperate...
> 
> Thanks.
> - -- 
> Chad Hogan                                 chad.hogan@inphinity.com
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.4 (FreeBSD)
> Comment: For info see http://www.gnupg.org
> 
> iD8DBQE61kkHiSF5tViVwg0RAkMOAJ4rMTC/xvvknmiSf512Y5d06ezdpgCfZH+s
> rEQ6ltXalr2SVqFg7lhIFYc=
> =iBPm
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

