Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319301AbSH2TLj>; Thu, 29 Aug 2002 15:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319299AbSH2TLj>; Thu, 29 Aug 2002 15:11:39 -0400
Received: from grace.speakeasy.org ([216.254.0.2]:30735 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S319301AbSH2TLc>; Thu, 29 Aug 2002 15:11:32 -0400
Date: Thu, 29 Aug 2002 14:15:55 -0500 (CDT)
From: Mike Isely <isely@pobox.com>
X-X-Sender: isely@grace.speakeasy.net
Reply-To: Mike Isely <isely@pobox.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre4-ac1 trashed my system
In-Reply-To: <Pine.LNX.4.44.0208291246310.13200-100000@grace.speakeasy.net>
Message-ID: <Pine.LNX.4.44.0208291412120.13200-100000@grace.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu Aug 29 13:46:10 2002, Mike Isely wrote:
>
> On Thu, 29 Aug 2002, Andre Hedrick wrote:
>
> > If you have a system which has a 28-bit limited host, and it has been
> > openly discussed on lkml for many months, why would one not use the
> > jumpon.exe from maxtor to prevent such problems.
>
> I have never used "jumpon.exe" from Maxtor.  I don't even know what it
> is (yet, I'm sure I'm going to find out awful quick now...).  When I set
> up the system, it "just worked" from day 1 with the existing IDE driver
> in the 2.4.19-preX series so I had no reason to go looking for issues
> like this.

I did some digging and I think I can answer these points a little
better now.

If "28-bit limited host" refers to a system BIOS which can't do LBA48,
then I don't think that's a problem here.  I've been successfully
booting this system without any special tweaks / fixes (hardware or
software) for quite some time now.  The Asus A7V266-E motherboard does
indeed use an Award BIOS, but it's Award version 6.0 dated 2000, not
1999 as in some previous posts about there being trouble booting >32GB
hard drives.  Note: Since I was booting from the onboard Promise
controller, the Promise BIOS was in play here too.  It's version
2.01.0 build 43, copyright 2001.

I understand now that jumpon.exe is a Maxtor utility to help boot hard
drives >32GB in systems which otherwise can't do this.  I never
learned about it before because I've never had this problem.  Indeed,
the first OS I put on the hardware was Linux (last December using a
2.4.18 kernel with additional IDE patches to support LBA48); it didn't
even see a DOS/Windows type boot disk until months later.

So I don't think any of this is an issue.

>
> I'll add more details as I learn them, but right now I must point out:
>
> The same hardware configuration ran 2.4.19-ac4 just fine.  The only
> change to the system was booting the newer kernel.  No hardware changes,
> no BIOS updates, nothing else.  Whatever went wrong got introduced
> somewhere between that version and 2.4.20-pre4-ac1.

I think the above point is extremely important.


>
> I will go back further in lkml and get up to speed on what happened back
> then with the "48 bit bomb", and I will look into your references about
> "28-bit limited host" and jumpon.exe.
>

I've done some more looking through the lkml archives and I found
discussions from March / April about LBA48 problems and the Promise
controller.  Clearly from that, exactly how well LBA48 works seems to
depend a lot on whether or not PIO vs DMA vs UltraDMA is being used.
Also it looks like if CONFIG_IDE_TASKFILE_IO is on then things may yet
be different.  To those points, I can add these details for my
situation: I believe the driver was in UltraDMA mode at the time and I
had CONFIG_IDE_TASKFILE_IO turned on.

I do understand your response here to my post.  I'm making an
extraordinary claim here for something that should just not happen at
all.  I understand the doubt.  The simple fact however is that I still
have a trashed system, and it happened only after updating the kernel.
I know that's not a lot to go on, and again I apologize for lack of
detail.  I originally wasn't going to post to lkml about this; I have
been a quiet Linux user for 8+ years and really felt that a problem of
this severity would probably already have been noticed.  I really
didn't want to jump into the fray with this sort of "information".
However several others that I work with (who are closer to the lkml
community than I) really insisted that I post this information,
however incomplete it is.  So I did.

If I'm the only one that has hit this - another reason for doubt -
then I guess have no choice but to dig deeper.  I can't really leave
the broken system like this to play with.  However I do have a smaller
spare hard drive and I'll make that the new system disk, leaving the
160GB Maxtor attached to the Promise controller (with nothing valuable
on it).  I should be able to replicate the corruption and provide more
information here, hopefully while still having a usable system.

  -Mike


                        |         Mike Isely          |     PGP fingerprint
    POSITIVELY NO       |                             | 03 54 43 4D 75 E5 CC 92
 UNSOLICITED JUNK MAIL! |   isely @ pobox (dot) com   | 71 16 01 E2 B5 F5 C1 E8
                        |   (spam-foiling  address)   |

