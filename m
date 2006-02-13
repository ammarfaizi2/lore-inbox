Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWBMQFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWBMQFn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWBMQFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:05:43 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:37350 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750798AbWBMQFm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:05:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VBV8y5VgpZann+C+ZKTXT+797ZBynyNpEWt1fEAV7lKVOwA5IpIsL5iW6IVaKwS/qut1ja65npHJiUoheLXm7FyrvxbESeByF8rngg2WeKZ38kGW8WckN5mIlXlefm4WZ865k03jYP7aR4OAkFTxnNiPlMZIHRv1oU7ggRYUpGU=
Message-ID: <5a2cf1f60602130805u537de206k22fa418ee214cf02@mail.gmail.com>
Date: Mon, 13 Feb 2006 17:05:41 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de, dhazelton@enter.net
In-Reply-To: <43F0AA83.nailKUS171HI4B@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060208162828.GA17534@voodoo> <43EC887B.nailISDGC9CP5@burner>
	 <200602090757.13767.dhazelton@enter.net>
	 <43EC8F22.nailISDL17DJF@burner>
	 <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
	 <43F06220.nailKUS5D8SL2@burner>
	 <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com>
	 <43F0A010.nailKUSR1CGG5@burner>
	 <5a2cf1f60602130724n7b060e29r57411260b04d5972@mail.gmail.com>
	 <43F0AA83.nailKUS171HI4B@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> jerome lacoste <jerome.lacoste@gmail.com> wrote:
>
> > > Sformat already includes such a mapping if you are on Solaris.
> > > Unfortunately this does cleanly work on Linux and for this
> > > reason is did not make it into cdrecord.
> >
> > Jorg,
> >
> > thanks for your answer.
> >
> > I fail to understand how it is connected to my proposal. Maybe we
> > misunderstood each other.
> >
> > I assume that you refer to the sformat/fmt.c implementation (sformat
> > 3.5) being reproduced in cdrecord/scsi_scan.c (latest cdrtools).
> >
> > Could you please elaborate on:
> > - what does the sformat scanbus code has to do with my proposal, whose
> > changes would mostly be located in the libscg modules, not in the
> > cdrecord module
>
> What has your proposal to do with libscg

The mapping I am talking about is currently done inside libscg (inside
the scsi-*.c files). Hence libscg is the one capable of exposing this
information to higher levels.

> and how would you like to implement it OS independent?

The information printed will be printed in a format such as:

b,t,l <= os_specific_name

This information is obviously not completely OS dependent (the
os_specifc_name is OS specific). But it is exactly this information
that would make your program integrable with OS specific user
interfaces. And this information would only be outputted.

Think about it in term of high level interface:

struct mapping {
  btl btl;
  char* name;
}

mapping* get_drives();
void burn(btl, ....)

To use your b,t,l naming effectively, we need to have a way to
identify it correctly. and no scanbus is not sufficient because what
is needed is the btl to os specific name.


> > - why 'it' doesn't clearly work on Linux. cdrecord clearly creates
> > this os specific to b,t,l mapping (e.g. in scsi-linux-ata.c,
> > scsi-wnt.c etc..). Why this mapping cannot be publicised in a
> > parseable format?
>
> Name a method that would work for anhy type of devices and any of the
> supported 21 OS.

I don't want to change anything cdrecord does. wrapper programs will
still use your dev=b,t,l on all platforms. The publicised mapping
would allow program to identify the correct b,t,l value.

How does that sound?

Jerome
