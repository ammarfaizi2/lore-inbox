Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263310AbVBCNfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbVBCNfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 08:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbVBCNfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 08:35:51 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:37275 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263310AbVBCNfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 08:35:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=RFS7gVQ0bkzptxcQi33yYx7Vwy9q86Baz+3SjuZ8DT/efT2psBZjE4O9Hbl1QNsDlIbS19T+IT+OmNQlK6g1kzDwwFYqjdvmP7iiWvxCA8RIIcJ7W/tCLpn6Mkp+DXQ+k+qtlFKPR5ozFzYx3B209hM17dKqd7ZQwnrrzhWMOOo=
Message-ID: <58cb370e05020305354cbb16ee@mail.gmail.com>
Date: Thu, 3 Feb 2005 14:35:35 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 2.6.11-rc2 11/29] ide: add ide_drive_t.sleeping
Cc: Tejun Heo <tj@home-tj.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <20050203133228.GA2816@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202025448.GL621@htj.dyndns.org>
	 <58cb370e05020216476a8f403c@mail.gmail.com>
	 <20050203113710.GV5710@suse.de>
	 <58cb370e05020305304e5d504@mail.gmail.com>
	 <20050203133228.GA2816@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2005 14:32:29 +0100, Jens Axboe <axboe@suse.de> wrote:
> On Thu, Feb 03 2005, Bartlomiej Zolnierkiewicz wrote:
> > On Thu, 3 Feb 2005 12:37:10 +0100, Jens Axboe <axboe@suse.de> wrote:
> > > On Thu, Feb 03 2005, Bartlomiej Zolnierkiewicz wrote:
> > > > On Wed, 2 Feb 2005 11:54:48 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > > > > > 11_ide_drive_sleeping_fix.patch
> > > > > >
> > > > > >       ide_drive_t.sleeping field added.  0 in sleep field used to
> > > > > >       indicate inactive sleeping but because 0 is a valid jiffy
> > > > > >       value, though slim, there's a chance that something can go
> > > > > >       weird.  And while at it, explicit jiffy comparisons are
> > > > > >       converted to use time_{after|before} macros.
> > > >
> > > > Same question as for "add ide_hwgroup_t.polling" patch.
> > > > AFAICS drive->sleep is either '0' or 'timeout + jiffies' (always > 0)
> > >
> > > Hmm, what if jiffies + timeout == 0?
> >
> > Hm, jiffies is unsigned and timeout is always > 0
> > but this is still possible if jiffies + timeout wraps, right?
> 
> Precisely, if jiffies is exactly 'timeout' away from wrapping to 0 it
> could happen. So I think the fix looks sane.

agreed
