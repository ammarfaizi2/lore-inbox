Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275990AbRKMQUm>; Tue, 13 Nov 2001 11:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276097AbRKMQUc>; Tue, 13 Nov 2001 11:20:32 -0500
Received: from [195.66.192.167] ([195.66.192.167]:23571 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S275990AbRKMQUP>; Tue, 13 Nov 2001 11:20:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: "David D. Hagood" <David.Hagood@ifrsys.com>, linux-kernel@vger.kernel.org
Subject: Re: Automount FS re-exported via NFS fails
Date: Tue, 13 Nov 2001 18:19:39 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <3BF0343C.2080409@ifrsys.com>
In-Reply-To: <3BF0343C.2080409@ifrsys.com>
MIME-Version: 1.0
Message-Id: <01111318193900.00801@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 November 2001 20:42, David D. Hagood wrote:
> I have a situation where I have a set of file systems that are automounted
> by the automount file system in 2.4.x under /misc. I'd like to make those
> file systems available via NFS from machine.
>
> In the ideal case, I would have something like this in /etc/exports:
> /misc 10.0.0.0/255.0.0.0 (rw)
>
> Thus, a client machine could mount server:/misc as /somedir, and then cause
> a filesystem to be mounted by accessing /somedir/some_auto_filesystem.
>
> However, that doesn't work, as the NFSD seems to want to do a getfh() IOCTL
> on the auto file system, and autofs doesn't seem to support that IOCTL.

NFS don't see mountpoints. It's a strange feature but it is really done that
way. I can mount my /dev/hdc on a non-empty dir in NFS exported tree and
I see hdc filesystem when browsing it locally, but NFS clients
still see old dir contents - they don't see mounted drive there!

I don't know whether it's bug or a feature.

Every automounted dir under automount mountpoint is a mountpoint too,
that's why you can't export them via NFS.
--
vda
