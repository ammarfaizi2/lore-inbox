Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbTI3Mjs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbTI3Mjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:39:48 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:224 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261432AbTI3Mjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:39:44 -0400
Date: Tue, 30 Sep 2003 14:37:10 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200309301237.h8UCbAgU004367@burner.fokus.fraunhofer.de>
To: axboe@suse.de, schilling@fokus.fraunhofer.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From axboe@suse.de  Tue Sep 30 14:06:29 2003

>> >> >/usr/include/scsi/scsi.h looks fine on my system, probably also on
>> >> >yours. You should not include kernel headers in your user space program.
>> >> 
>> >> Looks like you did not understand the background :-(
>> 
>> >I think I do.
>> 
>> Sorry, but you just verified that you don't :-(

>No, you continue to show you don't understand why you should not include
>kernel headers in user space.

You continue to verify that you don't understand how kernel <-> user level
interfaces are used by user level programs. 

The Linux kernel constantly adds new interfaces or changes old ones.
A user program that is going to use these interfaces _needs_ to include
up-to-date kernel include interface definitions.

If the kernel is not integral part of the whole system (which is definitely true
for a Linux based system) user level programs _need_ to include the kernel 
include files from the same snapshot as the kernel.

The basic concept of hiding kernel (only) data structures from user level 
programs is to put them between #ifdef __KERNEL__ #endif.
It is definitely typically not done by editing kernel level files later and by 
creating a different set (and thus potentially out of sync) of include files.

If you don't understand this bacic concept, then it makes not sense to continue
this discussion :-(

>> >> In order to use kernel interfaces you _need_ to include kernel include
>> >> files.
>> 
>> >False. You need to include the glibc kernel headers.
>> 
>> 
>> False: as glibc kernel headers are not part of the kernel distribution.

>How is that an argument? By your logic, you need one huge package with
>basically everything in it, how else do you know your application works
>with that given kernel?

Did you ever do a 'du' on /usr/include/sys and compare with 'du' on
/usr/src/linux? It seems that not :-(

A kernel source that uses internal include files that deviate (how ever) 
from the ones that are present in /usr/include/sys/ needs to include include
files that are consistent for user level use. The _way_ how you do this does 
not matter!

If you decide to have a different set of hand edited files, create them
but _always_ include them with the Linux kernel sources....

However, it is easily to understand that it makes more sense to just keep
the internal include files from the Linux kernel constsistent.
The current include files inside the Linux kernel definitely are not
consistent.


>I asked you one simple question: when did the kernel/user interface
>break, and how? You happily chose to ignore that. A pity, since that
>would be the core of your argument.

Well, this has been discussed several times and it would make sense if you
try to e.g. search the Linux kernel mailing lists or the cdrecording mailing 
lists.....

Search for failing cdrecord compilations and runs that are caused from Linux
kernel changes ....

I don't like that an important discussion about Linux include files to be
converted into rants....so let us stay with the topic.

I also told you that the addition of a single feature to an interface
does not make sense as long as user level programs cannot use them. If you like
to use them you need up to date include files for the kernel interfaces.

...please don't try to tell me that Linux never adds new features that
result at least in extended interfaces...

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
