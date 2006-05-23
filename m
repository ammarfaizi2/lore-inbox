Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWEWWib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWEWWib (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 18:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWEWWib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 18:38:31 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29847 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932236AbWEWWia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 18:38:30 -0400
Date: Wed, 24 May 2006 00:36:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [-mm] klibc breaks my initscripts
Message-ID: <20060523223652.GA1585@elf.ucw.cz>
References: <20060523083754.GA1586@elf.ucw.cz> <4473482A.3050407@zytor.com> <20060523211100.GA2788@elf.ucw.cz> <44737C33.4030503@zytor.com> <20060523215111.GA1669@elf.ucw.cz> <44738BA7.1020507@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44738BA7.1020507@zytor.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>[Adjusted Cc: list]
> >>
> >>Pavel Machek wrote:
> >>>>- a. What distro?
> >>>Hacked debian.
> >>>
> >>>>- b. What's the error?
> >>>Something about root not being mounted so it can't be remounted.
> >>I need the details on this one.  This sounds like it could be the Debian 
> >>mount getting confused by /proc/mounts and/or /etc/mtab.
> >
> >I cheated: I added "rw" to the command line. But results are the same
> >as in normal case, even strace looked the same.
> >
> >Any ideas?
> >								Pavel
> >
> 
> >read(3, "/dev/hda4\t/\text2\tdefaults,commit"..., 4096) = 601
>                                         ^^^^^^
> 
> Yes, check your /etc/fstab.  You're trying (explicitly) to mount an ext3 
> filesystem as ext2, but your /etc/fstab contains ext3-related options.  
> This means that mount(8) will try to add them to the remount, and the 
> remount will fail because you're passing options to the filesystem that the 
> filesystem doesn't understand.

Aha, sorry for confusion. So it was not klibc merge but stricter
parser to mount commandline. Problems are now fixed, thanks.

(And swsusp works okay; now I could test it from multiuser mode).

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
