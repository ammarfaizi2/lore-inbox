Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265693AbRFXBH6>; Sat, 23 Jun 2001 21:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265692AbRFXBHs>; Sat, 23 Jun 2001 21:07:48 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:36325 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S265687AbRFXBHh>; Sat, 23 Jun 2001 21:07:37 -0400
Message-ID: <3B353DB8.578F43FB@idcomm.com>
Date: Sat, 23 Jun 2001 19:09:12 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: Is this part of newer filesystem hierarchy?
In-Reply-To: <E15Dx9t-0005zT-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > glad to know this, i do wonder how does /usr/bin/ld work for red hat.
> > to my old mentality this seems red hat is going out of any resonable
> > standard.
> 
> It works like /usr/bin/ld on any other platform I know of
> 
> > if the same libc stripped would not run library, and they HAVE to mantein
> > a libc.so.6 linside of /lib, otherway this would be too mutch against
> > a resonable standard.
> 
> bash-2.04$ ls -l /lib/libc.so.6
> lrwxrwxrwx    1 root     root           13 May 14 16:46 /lib/libc.so.6 -> libc-2.2.2.so
> 
> I don't follow the discussion here.

There is a directory on RH 7.1 x86, /lib/i686/. When checking with ldd
to various applications, as to which libc they link to, it turns out
that the /lib/libc.so.6 is not used. They all seem to point at
/lib/i686/libc.so.6 (this is the version with debugging symbols) by
default. The odd thing is that there are NO LD_ style path variables set
on this system, there is NO /etc/ld.so.preload, and /etc/ld.so.conf does
not contain any reference to /lib/i686/. So there is a question of just
how it is possible for ld to use that directory and ignore /lib/ for
libc.so.6. So far the two possibilities seem to be that either the
linker was precompiled to look in the subdirectory, or else when the
linker looks at /lib/ it also recursively checks other directories (this
doesn't seem likely). The reason why it matters is because it is
confusing some custom boot floppy creation software. The original author
of that software is looking for a means to make it work correctly with
RH 7.1. The manual way for it to avoid confusion is to cd to the mount
point of the ramdisk which it builds up, into its lib directory, and sym
link the contents of the i686 subdirectory into the main lib directory.
But the original software does interesting things like checking what
ld.so.conf has, and checking what environment variables are set, but
since none of those provide any clues, the automated means remains
broken for now. Probably the next step will be manually testing for the
existence of /lib/{uname -m}/, and if it exists, sym linking it to /lib/
(these are actually relative to the mount point of the ramdisk during
creation). The boot system is designed as a customized bootdisk creation
that automatically detects various dependencies of a highly customized
linux install.

It still remains to be seen how it is that /lib/i686/libc.so.6 is used
in place of /lib/libc.so.6 (which could be deleted and RH 7.1 wouldn't
care...very strange).

D. Stimits, stimits@idcomm.com

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
