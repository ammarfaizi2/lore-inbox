Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269787AbRIPKBq>; Sun, 16 Sep 2001 06:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270073AbRIPKBh>; Sun, 16 Sep 2001 06:01:37 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:36626 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S269787AbRIPKBX>; Sun, 16 Sep 2001 06:01:23 -0400
Message-ID: <3BA47835.16A91A57@t-online.de>
Date: Sun, 16 Sep 2001 12:00:21 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: How errorproof is ext2 fs?
In-Reply-To: <200109160858.KAA28624@cave.bitwizard.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff schrieb:
> 
> Alan Cox wrote:
> > > due to an not responding USB-keyboard/-mouse (what a nice coincident). Now while
> > > the Mac restarted without any fuse I had to fix the ext2-fs manually for about
> > > 15 min. Luckily it seems I haven't lost anything on both system.
> > >
> > > This leaves me a bad taste of Linux in my mouth. Does ext2 fs really behave so
> > > worse in case of a crash? Okay Linux does not crash that often as MacOS does, so
> 
> > That sounds like it behaved well. fsck didnt have enough info to safely
> > do all the fixup without asking you. Its not a reliability issue as such.
> 
> Well, fsck wants to ask
> 
>         "Found an unattached inode, connect to lost+found?"
> 
> to the user and will interrupt an automatic reboot for that.
> 
> This is bad: The safe choice is safe: It won't cause data-loss.
> 
> Maybe it should report it (say by Email), but interrupting a reboot
> just for connecting a couple of files to lost+found, that's
> rediculous.
> 
> If it would give me enough information when I do this manually, I'd
> make an informed decision. However, what are the chances of me knowing
> that inode 123456 is a staroffice bak-file? So the only way to safely
> operate is to link them into lost+found, and then to look at the files
> manually.

Hello...

This is true, most distros are relatively rigid in dropping you to a
shell, because they call fsck with very weak options and do not care
about the fact that most servers are not standing under a table of
someone with easy access to the console.

If i have such a problem and get dropped to a shell, i normaly do a
simple "e2fsck /dev/XXX -p" or "-y" and this runs through and fixes the
filesystem without any questions.

I had only one time in the recent history where this did not work, i had
to repeat the steps a second and third time, but that was due to an
extreme error, i did e2fsck on a mounted filesystem during writing
.tar-backups there (error in crontab)...no good idea..:-).

So if you want to come around this "dropping-you-to-a-shell" problem you
could easily patch the file "/etc/rc.d/rc.sysinit" (RH) and call fsck
with the option "-p" or "-y", and you could easily change this script
that in cases of really bad trouble the system mounts / (or a
reserve-partition, even a CD would do AFAIK) readonly but starts up
normaly, so you can log in via net and do the repair by hand.

Solong..
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
... -.-
