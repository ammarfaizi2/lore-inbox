Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWBJPiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWBJPiv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 10:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWBJPiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 10:38:51 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:5820 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932129AbWBJPiu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 10:38:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J307I8WpSxLt20TomQtpiZw7eTxiMAJx1qKtUSPAOvU6ePoQ0/nFiZtVnHEj0mNSFuf4OWxZ8El4QrsTv0WO90FkAPwQlsc0Otypu+MZ6Mdlnn/vevSWiz5khBYQjvj0+RYjBgMQIn9smy9AU+Z78+oC123BVslr4UDz/YlTt8I=
Message-ID: <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
Date: Fri, 10 Feb 2006 16:38:48 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: dhazelton@enter.net, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
In-Reply-To: <43EC8F22.nailISDL17DJF@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060208162828.GA17534@voodoo>
	 <20060210114721.GB20093@merlin.emma.line.org>
	 <43EC887B.nailISDGC9CP5@burner>
	 <200602090757.13767.dhazelton@enter.net>
	 <43EC8F22.nailISDL17DJF@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> "D. Hazelton" <dhazelton@enter.net> wrote:
>
> > And does cdrecord even need libscg anymore? From having actually gone through
> > your code, Joerg, I can tell you that it does serve a larger purpose. But at
> > this point I have to ask - besides cdrecord and a few other _COMPACT_ _DISC_
> > writing programs, does _ANYONE_ use libscg? Is it ever used to access any
> > other devices that are either SCSI or use a SCSI command protocol (like
> > ATAPI)?  My point there is that you have a wonderful library, but despite
> > your wishes, there is no proof that it is ever used for anything except
> > writing/ripping CD's.
>
> Name a single program (not using libscg) that implements user space SCSI and runs
> on as many platforms as cdrecord/libscg does.


I have 2 technical questions, and I hope that you will take the time
to answer them.

1) extract from the README of the latest stable cdrtools package:

        Linux driver design oddities ******************************************
        Although cdrecord supports to use dev=/dev/sgc, it is not recommended
        and it is unsupported.

        The /dev/sg* device mapping in Linux is not stable! Using dev=/dev/sgc
        in a shell script may fail after a reboot because the device you want
        to talk to has moved to /dev/sgd. For the proper and OS independent
        dev=<bus>,<tgt>,<lun> syntax read the man page of cdrecord.

My understanding of that is you say to not use dev=/dev/sgc because it
isn't stable. Now that you've said that bus,tgt,lun is not stable on
Linux (because of a "Linux bug") why is the b,t,l scheme preferred
over the /dev/sg* one ?


2) design question:

- cdrecord scans then maps the device to the b,t,l scheme.
- the libsg uses the b,t,l ids in its interface to perform the operations

So now, if cdrecord could have a new option called -scanbusmap that
displays the mapping it performs in a way that people can parse the
output, I think that will solve most issues.

cdrecord already has this information available, it just doesn't display it:

$ cdrecord debug=2 dev=ATAPI -scanbus 2>&1 | grep INFO
INFO: /dev/hdc, (host0/bus1/target0/lun0) will be mapped on the
schilly bus No 0 (0,0,0)
INFO: /dev/hdd, (host0/bus1/target1/lun0) will be mapped on the
schilly bus No 0 (0,1,0)

It could perform in the following way:

$ cdrecord dev=ATAPI  -scanbusmap
...

0,0,0 <= /dev/hdc
0,1,0 <= /dev/hdd


Are you accepting such a patch?

Jerome
