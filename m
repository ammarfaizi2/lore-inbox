Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132342AbRAQKtd>; Wed, 17 Jan 2001 05:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132481AbRAQKtO>; Wed, 17 Jan 2001 05:49:14 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:272 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S132411AbRAQKtM>;
	Wed, 17 Jan 2001 05:49:12 -0500
Date: Wed, 17 Jan 2001 11:48:37 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Linux not adhering to BIOS Drive boot order?
To: Andreas Dilger <adilger@turbolinux.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3A657885.6D6F64C4@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@turbolinux.com> wrote :

> David Woodhouse writes:
> > There are patches available for the 2.2 kernel which provide the facility 
> > to mount by UUID or volume label. It seems that nobody is actively 
> > maintaining those at the moment. If you want to update those to the current 
> > 2.2 and 2.4 kernels, well volunteered. 
>                    
> I'm quite interested in this patch, and have taken a good look at it.
> Some changes are in order (IMHO) to make it more usable. It should take
> parameters that are the same as in /etc/fstab (i.e. LABEL= and UUID=
> instead of L: and UUID:).

A trivial change...

> In the end I re-wrote most of the patch, so
> that we resolve ROOT_DEV before calling mount_root(), just to be a bit
> more consistent. I will release a new patch for 2.2.18 and 2.4.0 after
> David Balazic has a look at it.

Cool, send it to me !

> I know a bit about LILO, so I should be able to get the "root=LABEL=" to
> work there as well.   

There were no problems with the original patch with LILO.
You just must use append="root=xxxxx" instead of simply
root=xxx , because LILO tries to be "smart" .... at least the
version I used then did.

> I also need to do some work like this in e2fsprogs, so it may make sense
> to create a little library that can be updated to handle other kinds of
> filesystem/partition LABELs and UUIDs as the need arises. They were
> talking about putting a LABEL/UUID into reiserfs recently. This saves
> us from having to fix ext2-specific in dozens of utilities (e.g. LILO,
> mount, fsck, dump, etc). 
>        
> One reason why this may NOT ever make it into the kernel is that I know
> "kernel poking at devices" is really frowned upon.

This an ugly hack , if you ask me. The identificators ( be it labels ,
UUIDs
or whatever ) should be outside the partitions. Otherwise cases with
swap partitions , <any FS that doesn't support labels/UUIDs> unformatted
partitions etc. can not be handled.

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
