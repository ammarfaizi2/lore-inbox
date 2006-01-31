Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWAaOXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWAaOXW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 09:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWAaOXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 09:23:21 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:62748 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750890AbWAaOXV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 09:23:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AjIpK2jIehYgmzOubOvBAVUAis8UOzQPM0Kc69JoF+Aha/6YMNGYnquoGh9QjOQq7a5/oloOnmX2bxy8/q1/nT3iWyyhDsNx8Wb6JmOk5eCMzicCGZ2hKI3o2lSQMAZ2ndZD6j1K4JWfAnKtZ9wr3l095lUDeA5MEBfyakfA/Gk=
Message-ID: <58cb370e0601310623ic220d27q3bfd4642cd0538fb@mail.gmail.com>
Date: Tue, 31 Jan 2006 15:23:19 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
In-Reply-To: <43DF678E.nail3B431CUWJ@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
	 <43D7B1E7.nailDFJ9MUZ5G@burner>
	 <20060125230850.GA2137@merlin.emma.line.org>
	 <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner>
	 <1138642683.7404.31.camel@juerg-pd.bitron.ch>
	 <43DF3C3A.nail2RF112LAB@burner>
	 <58cb370e0601310410r46210e8dvc66f631f208e9b8d@mail.gmail.com>
	 <43DF678E.nail3B431CUWJ@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
>
> >   Joerg, I don't see any sense in providing users with fake SCSI
> >   lun and bus numbers for ATAPI devices.  I think that what users
> >   would like is the list of devices consisting of "fd" and actual vendor
> >   name of device (+ optionally serial no + optionally "x:y:z" for real
> >   SCSI).  Nobody wants to see some artificial "x:y:z" for her/his
> >   ATAPI device (it has always annoyed me in Windows), not to say
> >   that the majority of desktop users have absolutely no idea of meaning
> >   of these numbers.
>
> This is called integration and it is done by Linux e.g. for 1394 and USB SCSI
> devices. So why not for ATAPI?

Because we have native drivers which do not require SCSI stack et all.

> > * ide-* drivers for ATAPI devices are needed (some devices just doesn't
> >   work with ide-scsi ATM) so please accept this fact that we cannot just
> >   now simply switch over everything to using ide-scsi and we have to use
> >   SG_IO ioctl for ide-cd (and ide-{floppy,tape} if anybody cares to add
> >   support for it).  I'm not saying this won't change in future but this requires
> >   doing actual work and people seem to be more interested in discussing
> >   stupid naming issues than doing it so...
>
> Well, the problem with ide-scsi is not a general one but caused by a simple
> bug that needs to be fixed.

Please _reread_ this paragraph:
* some devices (not cd-writers) doesn't work with ide-scsi
* they require quirks which are in ide-cd so it ide-cd needs to stay as a driver
* if is very useful if cd-writing can be done with ide-cd and without SCSI stack
  (a hack but very useful one)

[ more below ]

> > > If the Linux folks could give technical based explanations for the questions
> > > from above and if they would create a new completely orthogonal view on SCSI [*]
> > > I had no problem. But up to now, the only answer was: "We do it this
> > > way because we do it this way".
> >
> > The answer is - we do this this way because of historical reasons and we
> > simply lack resources to change it immediately (be it your "everything is
> > SCSI" or mine "block layer devices claiming supported transport types").
>
> This is obviously not true: There _was_ (and still is) a useful implementation
> with minor bugs. But instead of fixing the minor bugs, a lot of work has been
> done to introduce a new and unneded new interface.

>From technical point of view:

pros:
* you don't need SCSI stack (a lot of code saved!)
* you use subsystem native driver (a lot of complexity with locking
etc avoided!)
* you don't need to provide users with fake data (SCSI lun and bus)

cons:
* user-space applications need to support it

What are the _technical_ problems with SG_IO interface besides
issue with enumaration of devices available in the system?

I know that you don't like SG_IO but it is hardly technical argument.

Thanks,
Bartlomiej
