Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266327AbUGJSSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266327AbUGJSSr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 14:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266328AbUGJSSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 14:18:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:58040 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266327AbUGJSSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 14:18:45 -0400
X-Authenticated: #5374206
Date: Sat, 10 Jul 2004 20:19:12 +0200
From: Thomas Moestl <moestl@ibr.cs.tu-bs.de>
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>, nfs@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: umount() and NFS races in 2.4.26
Message-ID: <20040710181912.GA800@timesink.dyndns.org>
References: <20040708180709.GA7704@timesink.dyndns.org> <Pine.LNX.4.58.0407101419210.1378@donald.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407101419210.1378@donald.themaw.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, 2004/07/10 at 14:57:46 +0800, raven@themaw.net wrote:
> > Hi,
> > 
> > after deploying an SMP machine at work, we started to experience Oopses
> > in file-system related code relatively frequently. Investigation
> > revealed that they were caused by references using junk pointers from
> > freed super blocks via dangling inodes from unmounted file systems;
> > Oopses would always be preceded by the warning
> >   VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
> > on an unmount (unmount activity is high on this machine due to heavy use
> > of the automounter). The predecessor to this machine, a UP system with
> > otherwise almost identical configuration, did never encounter such
> > problems, so I went looking for possible SMP races.
> 
> This has been reported many times by users of autofs, especially people 
> with a ot of mount/umount activity.
> 
> As James pointed out my latest autofs4 patch resolved the issue for him.
> However, on the NFS list Greg Banks pointed out that this may be hiding a
> problem that exists in NFS. So it would be good if the NFS folk could 
> investigate this further.
> 
> Never the less I'm sure there is a race in waitq.c of autofs4 in 
> 2.4 that seems to cause this problem. This is one of the things 
> addressed by my patch.

The system in question still uses autofs3. While I believe that the
waitq race is also present there (it could probably cause directory
lookups to hang, if I understand it correctly), I do not think that
any autofs3 code could cause exactly those symptoms that I have
observed. For that, it would have to obtain dentries of the file
systems that it has mounted, but the old code never does that.

Almost anything else autofs could do should only affect its own set of
dentries etc.

Thanks for the information, though, I'm going to upgrade to a patched
autofs4 at the next opportunity.

	- Thomas
