Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbTCFXUm>; Thu, 6 Mar 2003 18:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261263AbTCFXUl>; Thu, 6 Mar 2003 18:20:41 -0500
Received: from daimi.au.dk ([130.225.16.1]:54477 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S261246AbTCFXU3>;
	Thu, 6 Mar 2003 18:20:29 -0500
Message-ID: <3E67DA2F.500EEE5B@daimi.au.dk>
Date: Fri, 07 Mar 2003 00:30:55 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jw schultz <jw@pegasys.ws>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <buon0kirym1.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DCB89.9086582F@daimi.au.dk> <buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030227092121.GG15254@pegasys.ws> <20030302130430.GI45@DervishD> <3E621235.2C0CD785@daimi.au.dk> <20030303010409.GA3206@pegasys.ws> <3E634916.6AE643EB@daimi.au.dk> <20030304020203.GD7329@pegasys.ws> <3E65F454.825890F4@daimi.au.dk> <20030306011850.GA16552@pegasys.ws>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz wrote:
> 
> And umount?  Anything that umounts or remountes a filesystem
> has to modify /etc/mtab to remove or alter the relevant
> line.

That is not an issue. With my suggestion the line is automatically
removed by the kernel at umount. If the umount program changes the
line before calling the umount system call, the changed line is
discareded anyway. If the umount program try to change the line
after calling umount, it is simply ignored. Currently this is not
going to happen anyway with a umount program that see /etc/mtab
is a symlink and simply skips the update. An updated umount
program for the new approach will simply remove all the code
related to updating mtab.

> 
> To put this in kernel means changing how it is updated.
> Once we do that we might as well go all the way.

Yes, in this case it means umount is not going to write at all.
It only needs to read the file for the user specific options.
(To know if the calling user is allowed to umount.) The read can
be done either through the /etc/mtab symlink or the /proc
interface, I prefer the later.

> >
> > 1) Make a new mount system call. Finally get rid of the old
> >    magic value in the flag register and add the extra argument
> >    which is then required. Make the old mount system call
> >    obsolete, but keep it for some versions. The old mount
> >    system call should then just behave as if the user data
> >    was the empty string.
> >
> > 2) Add a new flag for the old mount system call, which
> >    indicates that there is one more argument containing the
> >    user data.
> 
> #2 with warnings i like better than keeping a deprecated mount
> syscall until 2038.

But by adding options to the existing systemcall we are going
to keep historic options and magic values in that system call
forever. With the new system call we have at least collected all
the historic parts in a single obsolete system call, that can
eventually be removed. Anyway I think this is a minor detail,
both approaches will be an improvement over the current mtab
file. So whatever people prefer I'd be happy with.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
