Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWBMX0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWBMX0J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWBMX0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:26:09 -0500
Received: from smtp.enter.net ([216.193.128.24]:13324 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1030247AbWBMX0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:26:08 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 13 Feb 2006 18:35:06 -0500
User-Agent: KMail/1.8.1
Cc: cfriesen@nortel.com, tytso@mit.edu, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
References: <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr> <43ECADA8.9030609@nortel.com> <43F05FB2.nailKUS3MR1N9@burner>
In-Reply-To: <43F05FB2.nailKUS3MR1N9@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131835.07477.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 05:30, Joerg Schilling wrote:
> "Christopher Friesen" <cfriesen@nortel.com> wrote:
> > Joerg Schilling wrote:
> > > "Christopher Friesen" <cfriesen@nortel.com> wrote:
> > >>There's nothing there that says the mapping cannot change with
> > >>time...just that it has to be unique.
> > >
> > > If it changes over the runtime of a program, it is not unique from the
> > > view of that program.
> >
> > That depends on what "uniquely identified" actually means.
> >
> > One possible definition is that at any time, a particular path maps to a
> > single unique st_ino/st_dev tuple.
> >
> > The other possibility (and this is what you seem to be advocating) is
> > that a st_ino/st_dev tuple always maps to the same file over the entire
> > runtime of the system.
>
> Well it is obvious that this is a requirement.
>
> If Linux does device name mapping at high level but leaves the low level
> part unstable, then the following coul happen:
>
> Just think about a program that checks a file that is on a removable media.
>
> This media is mounted via a vold service and someone removes the USB cable
> and reinserts it a second later. The filesystem on the device will be
> mounted on the same mount point but the device ID inside the system did
> change.

Joerg, I think you've got your OS's mixed up here. AFAIK, Linux does not have 
a "vold" system.

> As a result, the file unique identification st_ino/st_dev is not retained
> and the program is confused.

I have to agree that you are correct, but then, most removable media in the 
Linux world do not actually have physical inodes. AFAIK, DVD's use the UDF 
filesystem, a lot of CDRW's are formatted the same, CD's/CDR's generally use 
the ISO9660 filesystem and other removable media, such as any floppy disc and 
the now ubiquitous "zip disk's" use FAT16. I'm not current on UDF, but from 
prior experience, I'd be willing to bet it doesn't have indoes, and the 
ISO9660 filesystem doesn't have them, even if you use the RR extensions. What 
is referred to in the Linux kernel as inodes for those systems are generally 
block indexes, and for the FAT filesystem what it calls an "inode" is just 
the name and a few other bits - and in the case of an LFN being used on said 
volume, the name is spread across several "special blocks"... invalidating 
the concept of an INODE for said filesystems.


In any case, the hypothetical case you present here seems more in tune with 
Solaris as you present it, since with UDEV the device node created for said 
removable media would stay the same, and hence st_dev would also (IIRC) 
remain the same.

DRH
