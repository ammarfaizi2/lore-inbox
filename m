Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbVJ2L67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbVJ2L67 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 07:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbVJ2L67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 07:58:59 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:59141 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751022AbVJ2L67 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 07:58:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aKvoHt56xgd8Yu1o/wTQt6gpo3UnHAsBGJT/idLY0o7AgDOXbr+1xS7DQqc3pNKrvgqcnRRU2Kz7vNYKQbQ4xDrqkxLzSFcVcvudhQABDBQ7E7RM8XDph+5dVjIdEVLu5TUuIUU6+P3nuDnI+EKIt0zsc2kTZkAU8lRCkdKCPNE=
Message-ID: <35fb2e590510290458u47ad70d2s1f5956cb47c193c0@mail.gmail.com>
Date: Sat, 29 Oct 2005 12:58:58 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>
Subject: Re: Weirdness of "mount -o remount,rw" with write-protected floppy
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <35fb2e590510270805h1739b19chf0b719948aa6f4f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4360C0A7.4050708@weizmann.ac.il>
	 <35fb2e590510270805h1739b19chf0b719948aa6f4f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/05, Jon Masters <jonmasters@gmail.com> wrote:
> On 10/27/05, Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il> wrote:
>
> > # mount /dev/fd0 /mnt/floppy/
> > mount: block device /dev/fd0 is write-protected, mounting read-only
> > # mount -o remount,rw /mnt/floppy
> > # echo $?
> > 0
>
> Oops. That looks like a bug.

Callchain is:

    sys_mount -> do_mount -> do_remount

and that then calls:

    do_remount_sb

which does:

    if (!(flags & MS_RDONLY) && bdev_read_only(sb->s_bdev))
                 return -EACCES;

So I'm missing something. I'll have another look, it's failing somewhere else.

Jon.
