Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313702AbSELRfo>; Sun, 12 May 2002 13:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313711AbSELRfn>; Sun, 12 May 2002 13:35:43 -0400
Received: from mail.eskimo.com ([204.122.16.4]:19719 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S313702AbSELRfn>;
	Sun, 12 May 2002 13:35:43 -0400
Date: Sun, 12 May 2002 10:34:32 -0700
To: Jakob ?stergaard <jakob@unthought.net>,
        Kasper Dupont <kasperd@daimi.au.dk>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
Message-ID: <20020512103432.A24018@eskimo.com>
In-Reply-To: <3CDE96F9.8443C446@daimi.au.dk> <20020512184204.A17334@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

His test was different.

He opened a file in a legal situation (shell can create a new file), and
then forked off a suid process over and over with the stdout of that
process set to a dup of the shell's already open fd.

It's perfectly legal for the shell to sit around with a file open and
pass it off to a child, even if the disk is full.

It's also perfectly legal for root to write to the fd, even if the disk
is full (for normal users).  

It just happens that the suid program wasn't the one who chose what file
it was going to write stdout to - the shell did.

Thus, the security violation.


mount > /etc/passwd doesn't work, because the shell can't open
/etc/passwd for writing.

-J


On Sun, May 12, 2002 at 06:42:04PM +0200, Jakob ?stergaard wrote:
> On Sun, May 12, 2002 at 06:23:21PM +0200, Kasper Dupont wrote:
> > Usually the last 5% of the diskspace on ext2 and ext3
> > filesystems are reserved for root. But I just realized
> > that they can be bypassed by redirecting the output
> > from a suid root program to a file.
> > 
> > This command will keep writing beyond the 95% limit:
> > while true ; do mount ; done >filename
> 
> Hej Kasper,
> 
> Sure you were not running the shell as root ?  :)
> 
> The redirection is handled by your shell, mount doesn't have anything to do
> with the '>filename' part.
> 
> Actually, the more fun test is to
>   mount > /etc/passwd
> or
>   mount > /dev/hda
> 
> But this won't work either, unless your shell (and therefore you as a user,
> suid programs or not) have the permissions as required.
> 
> In short: I don't think you are seeing what you think you are seeing  ;)
> 
> -- 
> ................................................................
> :   jakob@unthought.net   : And I see the elder races,         :
> :.........................: putrid forms of man                :
> :   Jakob ?stergaard      : See him rise and claim the earth,  :
> :        OZ9ABN           : his downfall is at hand.           :
> :.........................:............{Konkhra}...............:
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
