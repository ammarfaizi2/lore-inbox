Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288919AbSBIMVO>; Sat, 9 Feb 2002 07:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288923AbSBIMVE>; Sat, 9 Feb 2002 07:21:04 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12297 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S288919AbSBIMUv>; Sat, 9 Feb 2002 07:20:51 -0500
Message-Id: <200202091219.g19CJEt23147@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Urban Widmark <urban@teststation.com>
Subject: Re: [BUG] 2.4.18pre6+ll: autofs+smbfs: processes in D state
Date: Sat, 9 Feb 2002 14:19:16 -0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0202082046200.2508-100000@cola.teststation.com>
In-Reply-To: <Pine.LNX.4.33.0202082046200.2508-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 February 2002 18:55, Urban Widmark wrote:

> > I wanted to verify that mp3 was good before I got all of it,
> > so cd'ed to /mnt/auto/smb.host.dir, paused download,
> > copied incomplete file to Linux and tried to resume dl.
> > It failed (JetCar: "can't open file").
> > I rebooted NT box.
>
> This has nothing to do with the automounter.
>
> Rebooting the NT box with smbfs mounted probably made some process go to
> sleep for a long time, waiting for a reply or some network timeout.
>
> smbfs has an ugly and incorrect assumption that it will always get a reply
> to it's requests. And one process will block all others from sending any
> requests until it is done.

Note that NT box was rebooted, not shut down. I brought it back on and even 
restarted download of unlucky mp3 (via NT downloader). Since NT box was 
available on the network I thought smbfs will reestablish SMB connection, as 
NFS do in similar scenario (server reboot).

> You may want to test the 2.4.17 patch on:
>     http://www.hojdpunkten.ac.se/054/samba/index.html
>
> But that code is (very) experimental. It will allow multiple processes
> sending data, the processes will be in interruptible sleep and capable of
> timeout.
>
> Further down on that page there is a patch for 2.4.4 to make it poll()
> before reading and time-out. That is a smaller change and I have some good
> feedback on the 2.2 version of it.
>
> > Now I have some processes in D state. mc and ls hung trying to stat
> > /mnt/auto/smb.host.dir it seems. Ksymoopsed SysRq-T output below.
>
> They are all waiting for access to the smbfs "server" struct. None of them
> is the real problem.
>
> The process that is blocking the others is probably sleeping in
> tcp_data_wait(), and if so it is interruptible.

Hmmm, maybe... I tried to kill -KILL automounter, forgot to do that to 
smbmount.

I will try to find reproducible scenario and then will try that patches.
Maybe you'll have to wait till Monday.
--
vda
