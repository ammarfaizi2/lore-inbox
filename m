Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131305AbRCWRgj>; Fri, 23 Mar 2001 12:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131311AbRCWRgU>; Fri, 23 Mar 2001 12:36:20 -0500
Received: from algernon.satimex.tvnet.hu ([195.38.110.113]:44046 "EHLO
	zeus.suselinux.hu") by vger.kernel.org with ESMTP
	id <S131307AbRCWRgK>; Fri, 23 Mar 2001 12:36:10 -0500
Date: Fri, 23 Mar 2001 18:35:13 +0100 (CET)
From: Pjotr Kourzanoff <pjotr@suselinux.hu>
To: Bryan Henderson <hbryan@us.ibm.com>
cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] sane access to per-fs metadata (was Re: [PATCH]
 Documentation/ioctl-number.txt)
In-Reply-To: <OF791BBBC5.E3FCBEEE-ON87256A18.005BA3B7@LocalDomain>
Message-ID: <Pine.LNX.4.31.0103231814590.19423-100000@zeus.suselinux.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Bryan Henderson wrote:

> How it can be used? Well, say it you've mounted JFS on /usr/local
> >% mount -t jfsmeta none /mnt -o jfsroot=/usr/local
> >% ls /mnt
> >stats     control   bootcode whatever_I_bloody_want
> >% cat /mnt/stats
> >master is on /usr/local
> >fragmentation = 5%
> >696942 reads, yodda, yodda
> >% echo "defrag 69 whatever 42 13" > /mnt/control
> >% umount /mnt
>
> There's a lot of cool simplicity in this, both in implementation and
> application, but it leaves something to be desired in functionality.  This
> is partly because the price you pay for being able to use existing,
> well-worn Unix interfaces is the ancient limitations of those interfaces
> -- like the inability to return adequate error information.

  I can imagine a solution to this using the _same_ method - extend
  /proc/*/ with a new entry (say, trace) for dumping errors. Put data
  in there from every failing function in your code. Normally, this
  will not introduce overheads (not unless you use error conditions to
  pass on useful information), however, in case of errors, you can
  get the backtrace (together with any info you want to put in there)
  immediately.

> Specifically, transactional stuff looks really hard in this method.
> If I want the user to know why his "defrag" command failed, how would I
> pass that information back to him?  What if I want to warn him of of a
> filesystem inconsistency I found along the way?  Or inform him of how
> effective the defrag was?  And bear in mind that multiple processes may be
> issuing commands to /mnt/control simultaneously.

  That's all up to you. Informational messages can go to /proc.
  Transactions/serialization can be done in your filesystem's
  implementation. Maybe glibc guys would even want to extend
  strerror() to handle these cases?

>
> With ioctl, I can easily match a response of any kind to a request.  I can
> even return an English text message if I want to be friendly.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
>

  Cheers,

Pjotr Kourzanov

