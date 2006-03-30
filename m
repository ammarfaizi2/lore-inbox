Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWC3NlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWC3NlA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 08:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWC3NlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 08:41:00 -0500
Received: from wproxy.gmail.com ([64.233.184.238]:13341 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932210AbWC3Nk7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 08:40:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nwXuzg2pTUtsoaI8Ptj5J2YSetCTLmbv1eJewsZ5/gYsKa1BUNFAPCs2EhfmOmvg/1H9mn5vi8hi2EdGFOFUjmIZDAqgQ7yqk04kbzFj9ogT2+L6JiT3jSiQcG7usAoXd4SobD3vjGhsBQnLRiACXsK1UzctD2XFcqAE18+1hTU=
Message-ID: <d120d5000603300540jb27eca6s56e9debddee0fc94@mail.gmail.com>
Date: Thu, 30 Mar 2006 08:40:58 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Romano Giannetti" <romanol@upcomillas.es>,
       "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: ALPS stop worked between 2.6.13 and 2.6.16
In-Reply-To: <20060330080551.GA19056@pern.dea.icai.upcomillas.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060327153624.GC8679@pern.dea.icai.upcomillas.es>
	 <d120d5000603270805u40916079ufe12eb22d478c954@mail.gmail.com>
	 <20060327190826.GA18193@pern.dea.icai.upcomillas.es>
	 <d120d5000603271112r35ba7100jceb8aaf3e8bf8c70@mail.gmail.com>
	 <20060329164330.GA8977@pern.dea.icai.upcomillas.es>
	 <d120d5000603290855u40c0cc22vac326da31bf5f8aa@mail.gmail.com>
	 <20060330080551.GA19056@pern.dea.icai.upcomillas.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/06, Romano Giannetti <romanol@upcomillas.es> wrote:
>
> On Wed, Mar 29, 2006 at 11:55:03AM -0500, Dmitry Torokhov wrote:
> > On 3/29/06, Romano Giannetti <romanol@upcomillas.es> wrote:
> > >
> > > but then nothing happened, no devices etc. So evidently the new udev is
> > > unable to cope with the old and maybe buggy Mandriva 2005 configuration[1].
> > > I unfortunately have no time to desentangle the dependency mess, so it's
> > > time to stop testing new kernels... unless anyone can point me to a "howto".
> > >
> >
> > I am sorry to hear that. You might want to check on the hotplug list,
> > maybe someone there could offer you some guidance. To tell you the
> > truth I am still running with static /dev...
> >
>
> Well, if you can hint a "mknod" I can add to my rc scripts to have the ALPS
> touchpad working with the old udev, I wouldn't mind sticking it in my
> system. I have /dev/psaux created ok, but then it seems that the synapctics
> drivers seraches for a /dev/input/event? which do not exists. It is possible
> to have a static entry "working everytime" (I mean, booting with/without
> external mouse, with/withour external keypad etc.)? If so I paint myself
> happy.

Yes, you need to create /dev/input/event0 to /dev/input/event31:

mknod /dev/input/event0 c 13 64
mknod /dev/input/event1 c 13 65
mknod /dev/input/event2 c 13 66
mknod /dev/input/event3 c 13 67
...
mknod /dev/input/event31 c 13 95

>
> Romano
>
> PD: totally unrelated. I was toying with the idea of trasforming a IR remote
> control in a "keyboard". I think there is a way to create a userspace input
> device and then feeding back the "keypresses" to the kernel... can you point
> me to more info on this? Thanks!
>

You need uinput driver (drivers/input/misc/uinput.c). Alternatively
you might want to change your IR driver to be able to change keycodes
it emits (you need to properly set up dev->keytable and
dev->keytablesize) abnd then you can use EVIOCSKEYCODE ioctl on
corresponding even device to change mapping.

--
Dmitry
