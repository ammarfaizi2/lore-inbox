Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVBJWEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVBJWEl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 17:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVBJWEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 17:04:40 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:11667 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261871AbVBJWE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 17:04:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=CTdNvqJMKoq7nSQ+oIIqv4jFMmdWQ/qOeNt1xI8b0H+VL9E9kvvLk4Cd2CkJpLeQosQErNo3abEIvvbOinYBCQZvSbPdPXCH1ZuN0bGwFvPSEj/UKM/VvN/9RCuTXIU9/rER+h7n0SqJJFWfWrLXiowbORDQM7yRYxyObOLKr+Q=
Message-ID: <58cb370e0502101404e4ddefa@mail.gmail.com>
Date: Thu, 10 Feb 2005 23:04:09 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
Cc: Jeff Garzik <jgarzik@pobox.com>, Arjan van de Ven <arjan@infradead.org>,
       Martins Krikis <mkrikis@yahoo.com>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <58cb370e05021012051518e912@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <420631BF.7060407@pobox.com> <420582C6.7060407@pobox.com>
	 <58cb370e05020607197db9ecf4@mail.gmail.com> <420BB77B.3080508@tmr.com>
	 <58cb370e05021012051518e912@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005 21:05:13 +0100, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> On Thu, 10 Feb 2005 14:35:23 -0500, Bill Davidsen <davidsen@tmr.com> wrote:
> > Bartlomiej Zolnierkiewicz wrote:
> > > On Sun, 06 Feb 2005 10:03:27 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> > >
> > >>Arjan van de Ven wrote:
> > >>
> > >>>>I consider it not a new feature, but a missing feature, since otherwise
> > >>>>user data cannot be accessed in the RAID setups.
> > >>>
> > >>>
> > >>>the same is true for all new hardware drivers and hardware support
> > >>>patches. And for new DRM (since new X may need it) and new .. and
> > >>>new ... where is the line?
> > >>>
> > >>>for me a deep maintenance mode is about keeping existing stuff working;
> > >>>all new hw support and derivative hardware support (such as this) can be
> > >>>pointed at the new stable series... which has been out for quite some
> > >>>time now..
> > >>
> > >>Red herring.
> > >>
> > >>2.4.x has ICH5/6 support -- but is missing the RAID support component.
> > >>
> > >>We are talking about hardware that is ALREADY supported by 2.4.x kernel,
> > >>not new hardware.
> > >>
> > >>We are also talking about inability to access data on hardware supported
> > >>by 2.4.x, not something that can easily be ignored or papered over with
> > >>a compatibility mode.
> > >
> > >
> > > the same arguments can be used for crypto support etc.,
> > > answer is - use 2.6.x or add extra patches to get 2.4.x working
> >
> > It's fix in a sense. The hardware is supported now, just not very well.
> > If an IDE chipset was capable of UDA4 and the driver only allowed UDA2
> > it would be a fix, in this case thehardware is supported partially, the
> > RAID conponent isn't working, and this is the fix.
> 
> The so called "RAID component" is 100% *software* solution.
> 
> BTW What is UDA?

[ This mail is just to explain why I don't like iswraid,
  I don't care if it gets merged that much... ]

another BTW: this driver adds another incompatibility between
2.4.x and 2.6.x.  Also most 2.4.x users will want (or have to) migrate
to 2.6.x one day and they will have to switch to using device mapper
and dmraid anyway.  From my POV merging/supporting iswraid
in any way is a lost of time for EVERYBODY in the long-term.
Martins, I appreciate all hard work that went into iswraid driver but
please face the simple fact, this driver was already obsoleted in
the moment it was created (from Linux development process POV).

I previously (October?) asked about merging device-mapper
instead as it provides easier way to migrate to 2.6.x (not only for
Intel "RAID component" users but for ALL "RAID components" users)
as they would be able to use the same method for accessing their
data in both kernels.  I was said that it is too late for such changes
(I consider device-mapper a new driver, changes to existing code
are REALLY minimal AFAIR) and that 2.4.x should stick to ataraid while
2.6.x to device-mapper which was just silly argument IMHO (why we
don't stick to IDE drivers for SATA in 2.4.x?).  I finally gave up because
I didn't want to waste more my time on this and didn't want to go into
politics etc... but damn iswraid wasn't merged so I feel stupid now. :-)

Regards,
Bartlomiej
