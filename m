Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267231AbUBMVdd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 16:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267227AbUBMVcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 16:32:24 -0500
Received: from mail.inter-page.com ([12.5.23.93]:36622 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S267211AbUBMVbD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 16:31:03 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "'Jamie Lokier'" <jamie@shareable.org>
Cc: "'Theodore Ts'o'" <tytso@mit.edu>, "'Pavel Machek'" <pavel@ucw.cz>,
       "'the grugq'" <grugq@hcunix.net>, <linux-kernel@vger.kernel.org>
Subject: RE: PATCH - ext2fs privacy (i.e. secure deletion) patch
Date: Fri, 13 Feb 2004 13:30:46 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAdbnfw1HHZ0KztRo05wDeeAEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <20040213034119.GK25499@mail.shareable.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some forms of better, yes.  8-)  The disposable inode key and the fully
encrypted file system are clearly more potent and better.  Nice and
bank-vault.  Sometimes though, you just want and only need a $3 chain on
your door to keep out the neighbor children.  Were the fully vault-like
option available you can bet I'd partition my keychain to do both.
Meanwhile...

A generic mount option that does the write-over-on-free operation could be
easily ported to/integrated with the other file-systems like, say, vfat.
Which, in turn, would continue to let me use my keychain to carry things to
non-linux environments while giving me some anti-leave-behind protection
when I delete things (in linux).  (So I am evil in trying to get the
poor-man's feature in for general consideration. 8-)

"Truly secure" is a good thing but "casually secure and pervasive" is
relatively important too.

Consider the simple "strings /dev/sda1" "attack" on a raw device.  Even with
the VMWare journaling and such and its implications, from inside the
environment write-over-on-erase would go a long way to block the stupid
leave behind vulnerability.

[Discussion-Fork]

I have actually been looking into the removable media issues more than
anything else.  My exact area of focus has been the idea of "local root" for
a (removable) file system.  Basically it seems that there needs to be a way
to communicate a list of otherwise unassigned user ID numbers into the
kernel.  Then when a flagged file system were mounted, the real user ID
numbers in the file system image would map to known-unused numbers.  The
root-on-disk would become something arbitrary like 21901 and then user ID
21901 would enjoy root-like write permissions on that media, but no other
media in the system.  All the other UID/GID numbers would likewise be
translated to unused "real" nubers.  This way applications could "run
setuid" and such but in their own sandbox, leaving the file system
internally consistent after use, but never endangering the overall system
security state.  (e.g. setuid root is bad, setuid 21901 not so much. 8-)

Think "application cards" or, say, student terminals where the whole OS is
installed but the portable (firewire/usb/etc) drives the students use would
remain consistent and capable of running their apps.

I have many thoughts about the requirements. A callback daemon a-la hotplug
to coordinate UID and GID pools.  A shim over the "real" file system calls
(kind of like the way loop shims as a block device) to do the bidirectional
translations of ID number.  That sort of thing.

I could see wanting to drop signatures and otherwise "taint" the file system
image with a temporary/scratch file full of information during this
application, or god knows what else.  Casual wipe then applies and is highly
utilitarian because you can unlink-on-unmount and rely on the buffer flush
to do the dirty work, rather than have a window of time when the file system
is mounted but the scratch space is being de-constructed.  Yes, not Big-S
secure, but "highly utilitarian" if for no reason other than preventing an
fsck from casually restoring a scratch file with valid contents.

[/Discussion-Fork]

So meanwhile, having a simple zero-out/expunge on last unlink (ne block
free) flag for a whole file system serves the dual purpose of mistake
prevention and exceedingly trivial security, at the sole cost of "no
norton-grade casual un-erase".

Regardless of the "I don't want the government recovering evidence of my
illicit activities" elements to be gained by a cryptographically complete
solution to secure file removal; there is real and immediate utility to a
simple wipe-on-erase.  More-so if it were to become "expected to be
available" on all supported filesystem types.


Rob.



-----Original Message-----
From: Jamie Lokier [mailto:jamie@shareable.org] 
Sent: Thursday, February 12, 2004 7:41 PM
To: Robert White
Cc: 'Theodore Ts'o'; 'Pavel Machek'; 'the grugq';
linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch

Robert White wrote:
> On the more positive side this would be _*outstanding*_ for my NV-RAM
> keychain drive where the files are warranted to be small and I don't want
> some random person who finds my lost keychain even able to guess about
that
> pesky project I was working on last month.

An encrypted and/or steganographic filesystem would be much better for
your NVRAM keychain drive, because that hides your files even when you
_haven't_ deleted them.

-- Jamie



