Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272817AbTHEOz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 10:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272840AbTHEOz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 10:55:27 -0400
Received: from chaos.analogic.com ([204.178.40.224]:27265 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S272817AbTHEOzP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 10:55:15 -0400
Date: Tue, 5 Aug 2003 10:57:11 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
In-Reply-To: <20030805160435.7b151b0e.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.53.0308051042310.6347@chaos>
References: <20030804141548.5060b9db.skraw@ithnet.com> <03080409334500.03650@tabby>
 <20030804170506.11426617.skraw@ithnet.com> <03080416092800.04444@tabby>
 <20030805003210.2c7f75f6.skraw@ithnet.com> <3F2FA862.2070401@aitel.hist.no>
 <20030805150351.5b81adfe.skraw@ithnet.com> <Pine.LNX.4.53.0308050916140.5994@chaos>
 <20030805160435.7b151b0e.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003, Stephan von Krawczynski wrote:

> On Tue, 5 Aug 2003 09:36:37 -0400 (EDT)
> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
>
> > A hard-link is, by definition, indistinguishable from the original
> > entry. In fact, with fast machines and the course granularity of
> > file-system times, even the creation time may be exactly the
> > same.
>
> Hello Richard,
>
> I really don't mind if you call the thing I am looking for a hardlink or a
> chicken. And I am really not sticking to creating them by ln or mount or just
> about anything else. I am, too, not bound to making them permanent on the
> media. All I really want to do is to _export_ them via nfs.
> And guys, looking at mount -bind makes me think someone else (before poor me)
> needed just about the same thing.
> So, instead of constantly feeding my bad conscience, can some kind soul explain
> the possibilities to make "mount -bind/rbind" work over a network fs of some
> flavor, please?
>
> Regards,
> Stephan
>
> PS: if you ever want to find out what *nix people are carrying guns, just enter
> the room and cry out loud "directory hardlinks to the left!"
> ;-)
>

But symlinks work over NFS. You just have to make sure they are
relative to whatever the remote mount-point is:

Script started on Tue Aug  5 10:38:55 2003
# mount boneserver:/tmp /mnt
# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   6560676   9199292  42% /
/dev/sdc1              6356624   1217040   4816680  20% /alt
/dev/sdc3              2253284   1796788    342036  84% /home/users
/dev/sda1              1048272    280960    767312  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
boneserver:/tmp        3881192   2385676   1294706  65% /mnt
# cd /mnt
# ls
# mkdir foo
# ls
foo
# ln -s foo bar
# ls
bar  foo
# cd bar
# pwd
/mnt/bar
# mkdir xxx
# ln -s xxx ../zzz
# cd ..
# ls
bar  foo  zzz
# file zzz
zzz: broken symbolic link to xxx
# rm zzz
# cd bar
# ls
xxx
# file xxx
xxx: directory
# pwd
/mnt/bar
# ln -s /mnt/bar/xxx ../zzz
# cd ..
# ls
bar  foo  zzz
# file zzz
zzz: symbolic link to /mnt/bar/xxx
# ls zzz
# home
# umount /mnt
# exit
exit
Script done on Tue Aug  5 10:41:41 2003


As you an clearly see, the symlink to the directories worked
fine. You don't need a hard-link at all. I deliberately created
a broken link, deleted it, then made another that works.
Everything I did locally could have been done remotely on
the server who's /tmp directory I mounted R/W. All you
need to do to make such working links is to use the
same mount-point name on each of you clients. That way,
a sim-link will work the same for everybody.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

