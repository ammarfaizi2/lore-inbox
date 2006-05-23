Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWEWSTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWEWSTg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWEWSTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:19:36 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:18038 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751161AbWEWSTf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:19:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cvxC28cyBnllXaKGruFJJxJvD8P8NbnLjcgKzX6U+Yab3bCXDP+cCTnjKwvnggGkD4IbuYymW27AWqUX9kxjjh4GPpzyrY+uvlOrdfDVLsDAM5rRyDDJg4rtwtUTBD+kyIlcB//SW5MLiWc+kiP7DtMVlITBomn8p7zNi0SI73Y=
Message-ID: <bda6d13a0605231119t466bed99q34991c242d259266@mail.gmail.com>
Date: Tue, 23 May 2006 11:19:35 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [-mm] klibc breaks my initscripts
In-Reply-To: <44734AEF.2020104@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060523083754.GA1586@elf.ucw.cz> <44734AEF.2020104@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/06, H. Peter Anvin <hpa@zytor.com> wrote:
> Pavel Machek wrote:
> > Hi!
> >
> > To reproduce: boot with init=/bin/bash
> >
> > attempt to
> >
> > mount / -oremount,rw
> >
> > I have this as my command line:
> >
> > root=/dev/hda4 resume=/dev/hda1 psmouse.psmouse_proto=imps
> > psmouse_proto=imps psmouse.proto=imps vga=1 pci=assign-busses
> > rootfstype=ext2
> >
>
> I tried this (or at least as close to this as I can get in my simulation
> environment), and I don't see any problems.  It works as is should;
> however, mount(8) requires that /proc is mounted so that it can read
> /proc/partitions, but that has nothing to do with klibc (or the kernel
> overall) of course.
>
> I'm afraid I'm going to have to ask for more details...
>
>         -hpa

Sounds like /etc/fstab corruption to me. Try this:
# mount -n /proc /proc -t proc
# mount /dev/hda4 -t ext2 -o remount,ro /
# mount -f /proc /proc -t proc
If it works, you have fstab corruption
If it doesn't, the problem lies elsewhere.

Yes I know that mount shouldn't require all that for
a remount. I'm probably way out on a limb on this one.
I still can't figure out what this has to do with klibc.
