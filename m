Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAPI53>; Tue, 16 Jan 2001 03:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRAPI5U>; Tue, 16 Jan 2001 03:57:20 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:45029 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129406AbRAPI5I>; Tue, 16 Jan 2001 03:57:08 -0500
To: Gregor Jasny <gjasny@wh8.tu-dresden.de>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Bug in swapfs (2.4.0-ac9)
In-Reply-To: <01011523192600.00565@backfire>
From: Christoph Rohland <cr@sap.com>
Date: 16 Jan 2001 09:50:09 +0100
In-Reply-To: <01011523192600.00565@backfire>
Message-ID: <qwwn1crhoe6.fsf@sap.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregor,

On Mon, 15 Jan 2001, Gregor Jasny wrote:
> I think I've found a bug in swapfs:
> 
> fstab:
> swapfs          /dev/shm        swapfs  defaults 0 0
> swapfs         /tmp    swapfs  defaults 0 0
> 
> When I hit <enter> on a tar.gz file in Midnight Commander nothing
> happens. If I do a umonut /tmp and hit <enter> again it works as It
> should (I see the archived files).  Nearly the same Problem with the
> Acrobat Reader pluin for Netscape. It shows only a blank page when
> /tmp is swapfs.

Yep, Alan introduced a maxbytes field to the superblock which is not
set in swapfs. So the vfs will always fail with EFBIG. 
I will send out a patch soon.

> I've noticed that it's possible to mount /tmp more than once. mount
> shows then
> [snip]
> swapfs on /dev/shm type swapfs (rw)
> swapfs on /tmp type swapfs (rw)
> swapfs on /tmp type swapfs (rw)
> swapfs on /tmp type swapfs (rw)
> swapfs on /tmp type swapfs (rw)

The vfs allows multiple mount with 2.4, and for swapfs you always get
a fresh instance with its own resource limits. Think anout chroot with
its own swapfs instance. AFAIK the new util-linux will give you some
checking.

> The permissions for /tmp are rwxrwxrwt, and even -omode=777,exec
> didn't help.

Your bootup script sets the mode after mounting? The mode parameter is
functional for me and the default is 777. 1777 has to be done in user
space.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
