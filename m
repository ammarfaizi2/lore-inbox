Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266360AbUGJTiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266360AbUGJTiV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 15:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266358AbUGJTiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 15:38:21 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:54540 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S266360AbUGJTiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 15:38:12 -0400
Date: Sun, 11 Jul 2004 03:25:34 +0800 (WST)
From: raven@themaw.net
To: Thomas Moestl <moestl@ibr.cs.tu-bs.de>
cc: autofs mailing list <autofs@linux.kernel.org>, nfs@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: umount() and NFS races in 2.4.26
In-Reply-To: <20040710181912.GA800@timesink.dyndns.org>
Message-ID: <Pine.LNX.4.58.0407110323480.20439@donald.themaw.net>
References: <20040708180709.GA7704@timesink.dyndns.org>
 <Pine.LNX.4.58.0407101419210.1378@donald.themaw.net> <20040710181912.GA800@timesink.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.2, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	RCVD_IN_ORBS, REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jul 2004, Thomas Moestl wrote:

> Hello,
> 
> On Sat, 2004/07/10 at 14:57:46 +0800, raven@themaw.net wrote:
> > > Hi,
> > > 
> > > after deploying an SMP machine at work, we started to experience Oopses
> > > in file-system related code relatively frequently. Investigation
> > > revealed that they were caused by references using junk pointers from
> > > freed super blocks via dangling inodes from unmounted file systems;
> > > Oopses would always be preceded by the warning
> > >   VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
> > > on an unmount (unmount activity is high on this machine due to heavy use
> > > of the automounter). The predecessor to this machine, a UP system with
> > > otherwise almost identical configuration, did never encounter such
> > > problems, so I went looking for possible SMP races.
> > 
> > This has been reported many times by users of autofs, especially people 
> > with a ot of mount/umount activity.
> > 
> > As James pointed out my latest autofs4 patch resolved the issue for him.
> > However, on the NFS list Greg Banks pointed out that this may be hiding a
> > problem that exists in NFS. So it would be good if the NFS folk could 
> > investigate this further.
> > 
> > Never the less I'm sure there is a race in waitq.c of autofs4 in 
> > 2.4 that seems to cause this problem. This is one of the things 
> > addressed by my patch.
> 
> The system in question still uses autofs3. While I believe that the
> waitq race is also present there (it could probably cause directory
> lookups to hang, if I understand it correctly), I do not think that
> any autofs3 code could cause exactly those symptoms that I have
> observed. For that, it would have to obtain dentries of the file
> systems that it has mounted, but the old code never does that.

All autofs has to do is not delete a directory before exiting for this 
error to occur.

Ian

