Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbTHaNBe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 09:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTHaNBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 09:01:34 -0400
Received: from mx0.gmx.net ([213.165.64.100]:47951 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S261467AbTHaNBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 09:01:32 -0400
Date: Sun, 31 Aug 2003 15:01:31 +0200 (MEST)
From: Felix Seeger <felix.seeger@gmx.de>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: Reiser4 snapshot problems
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0005429946@gmx.net
X-Authenticated-IP: [217.80.179.195]
Message-ID: <30017.1062334891@www39.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 August 2003 15:14, Felix Seeger wrote:
> On Friday 29 August 2003 14:28, you wrote:
> > Felix Seeger writes:
> >  > Hi
> >  >
> >  > I am trying out Reiser4 snapshot from August 26th.
> >  > I've putted my kde cvs sources on the new partition and compile from
> >  > reiser4 now.
> >  >
> >  > After some time processes hang when accessing this disk. I cannot do
> >  > anything on it but I also don't get any errormessage.
> >
> > If there anything in /var/log/messages, or wherever your kernel log is
> > stored?
>
> No, nothing. At least in messages, kern.log and syslog.
>
> But I found the problem. My old dir (on a reiser3 partition) was:
> ~/download/kde3/cvs which got renamed to old_cvs
> My new reiser4 dir is
> ~/download/kde3/new_cvs
>
> Since there are some full paths (maybe from make) I created a symlink
> ~/download/kde3/cvs
>
> I removed that link and readded the one to the old partition, all make
> processes stopped and I can access the partition again.
> Note that I cannot reproduce this if I create just the symlink. That works
> fine here, maybe I have to run make again to get the problem back.

The mount hangs again. This time without a symbolic link.
umount -f /dev/hdb6 gives:

umount2: Device or resource busy
umount: /dev/hdb6: not mounted
umount: /home/hal/download/kde3/cvs: Illegal seek

Prozesses that use that partition:
# lsof | grep kde3/cvs
cc1plus   31258      hal  cwd    DIR       3,70       33    133147
/home/hal/download/kde3/cvs/kdelibs/kstyles/keramik
cc1plus   31258      hal  mem    REG       3,70    85595    248079
/home/hal/download/kde3/cvs/kdelibs/kstyles/keramik/keramik.cpp
cc1plus   31258      hal  mem    REG       3,70    23725    135815
/home/hal/download/kde3/cvs/kdelibs/config.h
rm        31413      hal  cwd    DIR       3,70       33    133147
/home/hal/download/kde3/cvs/kdelibs/kstyles/keramik

I can't kill them, nothing in the logs again.

> >  > Umount, bash autocomletion and things like that don't work. Normal df
> >  > and mount are working btw.
> >
> > Nikita.
>
> have fun
> Felix

-- 
COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post

