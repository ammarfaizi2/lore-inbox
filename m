Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWBJMle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWBJMle (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWBJMle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:41:34 -0500
Received: from smtp.enter.net ([216.193.128.24]:29189 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751245AbWBJMld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:41:33 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Thu, 9 Feb 2006 07:37:46 -0500
User-Agent: KMail/1.8.1
Cc: mrmacman_g4@mac.com, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net
References: <73d8d0290602060706o75f04c1cx@mail.gmail.com> <233CD3FF-0017-4A74-BE6A-0487DF3F4EA8@mac.com> <43EC83EC.nailISD91HRFF@burner>
In-Reply-To: <43EC83EC.nailISD91HRFF@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602090737.47747.dhazelton@enter.net>
X-Virus-Checker-Version: Enter.Net Virus Scanner 1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 07:15, Joerg Schilling wrote:
> Kyle Moffett <mrmacman_g4@mac.com> wrote:
> > Joerg Schilling wrote:
> > > -	how to use /dev/hd* in order to scan an image from a scanner
> > > -	how to use /dev/hd* in order to talk to a printer
> > > -	how to use /dev/hd* in order to talk to a jukebox
> > > -	how to use /dev/hd* in order to talk to a graphical device
> >
> > Does cdrecord scan images, print files, or talk to SCSI graphical
>
> Are you _completely_ ingnoring the facts that have been discused here?
>
> This does not apply to cdrecord but to libscg.
>
> You either need to approach reality or stop this thread.

I've taken the time to look through the libscg code and I see only one reason 
why it needs to use the BTL mappings at all - Joerg has a clean interface 
that is consistent across all the platforms.

Not that I'm going to defend him. I've kept quiet and tracked this thread from 
the beginning, hoping he would "see the light" as it were and realise that he 
can export a stable interface across almost all platforms with a few ifdefs 
and a bit of trickery to use various OS quirks to handle the work.

I am no expert on Windows, so I cannot comment on that, but I can, have and do 
read relevant sections of the POSIX and SuS when looking at problems and know 
that the _proper_, _portable_ and _UNIX_ way of accessing devices is via the 
block device special file. For SCSI cd burners the only way (I know of) to 
access them for writing (as /dev/sr0 cannot be opened for "write") is via the 
"SCSI Generic" (/dev/sg*) nodes, and to find and cross-map which /dev/sr* is 
which /dev/sg* is by the BTL. Needless to say, that should all be transparent 
to the user.

And, much to my surprise, Joerg's assertion that using /dev/hd* for accessing 
ATA/PI devices would require patching libscg is bunk. All he'd have to do is 
modify cdrecord to _internally_ (if it has to) perform the BTL mapping it 
wants. What's more, said interface code can be compiled out if it isn't a 
Linux system with a simple ifdef. 

But please note that libscg _is_ a generic SCSI access library. If needed it 
_can_ be used to access any SCSI device (and any ATA/PI device, at this 
point) via hand-crafted command packets. Not useful to the generic 
programmer, who is happy with the interfaces an OS provides, but for people 
doing things like data forensics...

(No disrespect meant for anyone, but if my tone comes off a bit rant-like it's 
because I'm sick of seeing one developer (of a GPL'd program) drag so many 
people down.)

DRH

PS: If I thought I had the knowledge of SCSI/ATAPI protocol to do so, I'd fork 
the code myself.
