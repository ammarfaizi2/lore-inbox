Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVE0Jpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVE0Jpn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVE0Jnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:43:35 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:61681 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S262409AbVE0Jld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 05:41:33 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 27 May 2005 11:39:38 +0200
To: schilling@fokus.fraunhofer.de, mrmacman_g4@mac.com
Cc: linux-kernel@vger.kernel.org, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <4296EADA.nail3L111R0J3@burner>
References: <4847F-8q-23@gated-at.bofh.it>
 <E1Db3zm-0004vF-9j@be1.7eggert.dyndns.org>
 <4295005F.nail2KW319F89@burner>
 <8E909B69-1F19-4520-B162-B811E288B647@mac.com>
In-Reply-To: <8E909B69-1F19-4520-B162-B811E288B647@mac.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> wrote:

> On May 25, 2005, at 18:46:55, Joerg Schilling wrote:

> > The unability to give this kind of convenience to cdrecord users is  
> > a result
> > of the refusal of the Linux kernel crew to include the kernel internal
> > device instance numbers in the ioctl structures I need to read.
>
> There is a specific reason that the numbers are _kernel_internal_!!!   

So if you really believe this, you should immediately remove all
stuff under /proc.

> I set up
> my udev so that my green CD burner is /dev/green_burner, and my blue  
> CD burner
> is /dev/blue_burner.  Please tell me again why exactly I can't just  
> give the
> option -dev=/dev/green_burner and have it use my green CD burner?   

Try to start with reading the cdrecord manual page. Your question
is answered in there.....but if you issue a command that is only
halfway correct you will never be able to get the full set of features from 
cdrtools. Using UNIX device names for SCSI devices is highly nonportable 
and for this reason not supported by a portable program like cdrecord.

Cdrecord includes the needed features to do what you like, but do not
asume that you will be able to force me to make nonportable and Linux
specific interfaces a gauge for the design of a portable program.
If you read the cdrecord man page, you know that you could
happily call cdrecord dev=green_burner.....


> That's a lot
> easier than messing with random groups of 3 numbers and trying to  
> remember in
> which order I plugged in my burners, and which kernel I'm running, so  
> I can
> remember the enumeration order, etc.

Aha, so you would prefer /dev/ftp.kernel.org also?

Before trying to make inadequate comparisons and before you request
inadequate similarities, it often helps a lot if you first try to look
around and check whether your claims are really a tautology.

>
> > Note that the fields are there but the information is intentionally  
> > obscured
> > for come of the calls just to make the life of cdrecord useers  
> > harder :-(
>
> The information is obscured because userspace shouldn't know or care

If you read the LKML archives, it would be easy for you to prove that this
is not true :-(

The numbers are obscured _only_ in order to prevent me to implement a workaround
for the fact that Linux does not implement _one_ unique interface for sending
generic SCSI commands to all devices that talk SCSI.

I aked for a non obscured interface in 2002 (note that the fields _are_ present
inside the ioctl parameter structure) in order to hide this drawback from Linux
users, but I have been told that the Linux developers don't like nice
and _unique_ interfaces for their users. 

	-	The fields are in the ioctl structures for user land 
		communication.

	-	The kernel knows the numbers that would allow libscg
		to detect duplikate drive appearances when trying to
		implement a global umbrella for all different SCSI
		interfaces in the Linux kernel

	-	The kernel hides the fact only to make it impossible for
		cdrecord to implement  a better user interface.



> > If you don't call cdrecord as root, you will not be able to lock in  
> > memory
> > and to raise priority in order to prevent buffer underuns.
>
> I burn CDs fine all the time as a user, and I _don't_ need to lock  
> memory or
> raise priority, because I have a good scheduler, plenty of RAM, and  
> dual CPUs.

Do you really believe this? It would help a lot if you did a reality check.


> It would be nice if you could let me leave on the _hardware_ BurnProof
> technology designed to prevent that sort of thing, but it doesn't  
> appear to
> fit with your ideals of 100% perfect CDs, does it?  Besides, by the  

Again, try do do some reallity check.... Cdrecord by default uses the
setup that grant best media quality. I asume you are able to read, so 
just read the man page and set up your defaults the way you like them.


> burnproof).  Personally, I'd rather have the latter.

So why do you refuse to read the manual and to setup the parameters
you like?


> Did you try submitting a list of important SCSI commands and their  
> functions?
> I suspect that if you provide a clear, concise list of harmless  
> commands,
> they would be included in the available command set.

Having such a list in inherently wrong. It never could be made correct.

There are a lot of different drives with a lot of overlapping commands
in the vendor unique part of the name space. Cdrecord needs the
vendor unique commands for old writers in order to be able to write at
all, and cdrecord needs the vendor unique commands in order to implement
the nice features people like for their convenience.

Nut even in the non vendor unique part the list in Linux is incomplete.

****
And please note: Cdrecord uses some of the commands that are used for 
firmware upgrade in order to do DMA speed metering........ This is
definitely _not_ a security issue with cdrecord.
In special on Linux, users frequelty did complain about insufficient
DMA speed before I did add this feature. Not cdrecord refuses to write
faster than possible after metering the transfer speed from/to the drive.
****

In case you don't understand this correectly, let me explain:

A security problem may only be correctly dealt with by having a 
coherent and consistent security strategy. The SCSI op code table
is not part of a security strategy but just a bad hack.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
