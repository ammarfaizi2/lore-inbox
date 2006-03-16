Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWCPXe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWCPXe0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 18:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWCPXe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 18:34:26 -0500
Received: from mail.gmx.de ([213.165.64.20]:38349 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751218AbWCPXe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 18:34:26 -0500
Date: Fri, 17 Mar 2006 00:34:24 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       janak@us.ibm.com, viro@ftp.linux.org.uk, hch@lst.de, ak@muc.de,
       paulus@samba.org
MIME-Version: 1.0
References: <1359.1142546753@www064.gmx.net>
Subject: =?ISO-8859-1?Q?Re:_[PATCH]_unshare:_Cleanup_up_the_sys=5Funshare_interfac?=
 =?ISO-8859-1?Q?e_before_we_are_committed.?=
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <26439.1142552064@www064.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I seem to have had a send problem with the previous version of 
this message, so this is a slightly modified resend]

Linus,

> On Thu, 16 Mar 2006, Andrew Morton wrote:
> > 
> > iirc there was some discussion about this and it was explicitly decided
> > to keep the CLONE flags.
> > 
> > Maybe Janak or Linus can comment?
> 
> My personal opinion is that having a different set of flags is more 
> confusing 

How is it confusing?  And who is it confusing for?

It will potentially require kernel developers to think for just 
a moment about what is going on.  But why care about them -- 
they don't have to *use* this interface; userland programmers do.

I have tried to argue in the clearest way I can that the current 
interface (uschare(CLONE_*) is confusing for *users* of this API.
Do you care about the interface that is inflicted on users?

When you give users an interface with the same name, they
expect it to do the same thing.  When their expectations are 
broken, they write bugs.  There are already precedents, 
with much less justification, for defining separate flag names
for different interfaces.  For example, poll() uses constants
with names of the form POLL*, while epoll uses constant
with *EXACTLY* the same meanings, but named EPOLL*.

> and likely to result in problems later than having the same 
> ones. 

What problems do you think can occur?  And what happens on the 
day when unshare() needs a flag that clone() does not have?

> Regardless, I'm not touching this for 2.6.16 any more, 

By which time, the discussion is over.  Since "we don't 
break userspace", we can't (shouldn't) reverse whatever goes
into 2.6.16.

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
