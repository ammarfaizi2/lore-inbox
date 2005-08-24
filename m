Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVHXQMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVHXQMf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbVHXQMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:12:35 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:30817 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751102AbVHXQMd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:12:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ClF3tLJjbTg/cFWKq7VH8AKuoYg+4Svp/KAbnn5ogEg7W3tuacyLzT6TUsy87YPSn1iLl5cU1+AYljbHmp5vQfDiBgB4ZHJBSW5aocy2QT0LzNCQYLvGgujCK/EnTe2hiTXFk4e3Qr6QjeVCVl2Venizt5JfmW8jmFiTuIIm9IU=
Message-ID: <4789af9e05082409121cc6870@mail.gmail.com>
Date: Wed, 24 Aug 2005 10:12:31 -0600
From: Jim Ramsay <jim.ramsay@gmail.com>
To: Lukasz Kosewski <lkosewsk@gmail.com>
Subject: Re: [PATCH 3/3] Add disk hotswap support to libata RESEND #2
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-scsi@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <4789af9e05082408111c4a6294@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <355e5e5e05080103021a8239df@mail.gmail.com>
	 <4789af9e050823124140eb924f@mail.gmail.com>
	 <4789af9e050823154364c8e9eb@mail.gmail.com>
	 <430BA990.9090807@mvista.com> <430BCB41.5070206@s5r6.in-berlin.de>
	 <355e5e5e05082407031138120a@mail.gmail.com>
	 <4789af9e05082408111c4a6294@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/05, Jim Ramsay <jim.ramsay@gmail.com> wrote:
> On 8/24/05, Lukasz Kosewski <lkosewsk@gmail.com> wrote:
> > On 8/24/05, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> > > >> Timers appear to operate in an atomic context, so timers should not be
> > > >> allowed to call scsi_remove_device, which eventually schedules.
> > > >>
> > > >> Any suggestions on the best way to fix this?
> > > >
> > > > Workqueue, perhaps.
> >
> > Perhaps.  Actually, of course :)
> 
> How about the existing ata_wq workqueue?  This makes sense.  When the
> timer expires, it adds a task to this queue.

Note to self - No, you cannot use the exsting 'ata_wq' workqueue - The
plug-in events need to put other work on the queue during the hotplug
event... and of course this deadlocks since you're in the queuethread
already.

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
