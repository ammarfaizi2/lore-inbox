Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbTEALnw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 07:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbTEALnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 07:43:52 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:59569 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261218AbTEALnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 07:43:51 -0400
Subject: Re: 2.5.68: NFS3+exported /mnt/cdrom+eject: system lockup
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Bojan Smojver <bojan@rexursive.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <shsd6j3gdan.fsf@charged.uio.no>
References: <1051754203.3eb07edb09c51@imp.rexursive.com>
	 <shsd6j3gdan.fsf@charged.uio.no>
Content-Type: text/plain
Message-Id: <1051790160.1960.6.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2.99 (Preview Release)
Date: 01 May 2003 13:56:00 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-01 at 12:40, Trond Myklebust wrote:
> >>>>> " " == Bojan Smojver <bojan@rexursive.com> writes:
> 
>      > NFS3 server was running on the box and it was exporting a
>      > mounted /mnt/cdrom to the world. On "umount /mnt/cdrom" it
>      > reported "device busy". On "eject /mnt/cdrom" it locked the
>      > system hard.
> 
>      > What kind of information would help debugging this?
> 
> The only bug there is the hard crash. You are never allowed to unmount
> a device that has been exported.

What about not being able to unmount a filesystem that was once
exported, but now it's not? I've been experiencing this problem since a
long time ago:

I have a volume/partition exported via NFS:

/data           192.168.0.100(rw,no_root_squash) 192.168.0.0/24(ro)

However, during shutdown (it's a RH9 box), I do get "can't unmount,
device is busy" errors while unmounting this filesystem *after* the NFS
server has been stopped and all shares unexported.

This does only occurs if the shared NFS volume has been used by other
clients on the LAN. If no client tries to mount/use the share, this
doesn't happen.

Anyways, I'm having problems with NFS on 2.5... many programs fail when
accessing files over NFS, normally, programs that perform heavy file
seeks, writes and reads, like "oggdec" or "lame". They usually can't
complete without exitting with errors.

More information can be provided on detail :-)

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

