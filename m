Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310309AbSCLBsU>; Mon, 11 Mar 2002 20:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310330AbSCLBsN>; Mon, 11 Mar 2002 20:48:13 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:18660 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S310309AbSCLBrS>; Mon, 11 Mar 2002 20:47:18 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Malte Starostik <malte@kde.org>
To: linux-kernel@vger.kernel.org
Subject: Re: directory notifications lost after fork?
Date: Tue, 12 Mar 2002 02:47:05 +0100
X-Mailer: KMail [version 1.4]
X-Security-Warning: All Your Base Are Belong To Us!
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200203120247.05611.malte@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Manually quoted from the archive)

> Just a "me too".
> I have tried also to use the default (SIGIO) by setting owner pid (just
> in case). It is all the same.
> Does someone use the notifications, btw?
> The whole thing seems somewhat untested.
> -alex
We used to use them in the KDE libraries. However, we decided to disable it 
for now due to this problem since it's not theoretical, it hits quite often 
in konqueror and especially kdesktop as both spawn child processes.
On a side note, dnotify is pretty weak compared to FAM with imon 
(http://oss.sgi.com/projects/fam/) IMHO:
Imagine a file manager that has a view on a large directory like /usr/bin. Now 
a file in that directory is added / removed / changed. With dnotify, the 
filemanager will have to rescan the whole directory as a reaction to the 
signal, to find out which file has changed. OTOH, with FAM, it gets a precise 
event that tells "file `somebinary' has been added" or similar.
I don't have much of a clue about the kernel, so please excuse my ignorance, 
but the imon patch seems pretty unintrusive to me and enables more 
fine-grained file change notifications than dnotify. Also, FAM can monitor 
NFS-mounted directories with almost no network overhead when it's also 
running on the server.

> On Sun, Mar 10, 2002 at 10:08:02PM +0100, Oskar Liljeblad wrote:
> > The code snipper demonstrates what I consider a bug in the
> > dnotify facilities in the kernel. After a fork, all registered
> > notifications are lost in the process where they originally
> > where registered (the parent process). "lost" here means that
> > the signal specified with F_SETSIG fcntl no longer is delivered
> > when notified.

Regards,
-Malte

PS: I'm not subscribed, please CC me on answers; I'll also watch the archive.
-- 
Malte Starostik
PGP: 1024D/D2F3C787 [C138 2121 FAF3 410A 1C2A  27CD 5431 7745 D2F3 C787]

