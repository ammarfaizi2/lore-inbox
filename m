Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287794AbSA2AGR>; Mon, 28 Jan 2002 19:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287817AbSA2AGH>; Mon, 28 Jan 2002 19:06:07 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:13336 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S287794AbSA2AFx>; Mon, 28 Jan 2002 19:05:53 -0500
Date: Mon, 28 Jan 2002 19:05:51 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Jesper Juhl <jju@dif.dk>
Cc: "'linux-kernel@vger.kernel.org '" <linux-kernel@vger.kernel.org>
Subject: Re: Encountered a Null Pointer Problem on the SCSI Layer
Message-ID: <20020128190551.A4236@devserv.devel.redhat.com>
In-Reply-To: <8A43C34093B3D5119F7D0004AC56F4BCC3448C@difpst1a.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <8A43C34093B3D5119F7D0004AC56F4BCC3448C@difpst1a.dif.dk>; from jju@dif.dk on Tue, Jan 29, 2002 at 12:57:02AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jesper Juhl <jju@dif.dk>
> Date: Tue, 29 Jan 2002 00:57:02 +0100

> > -       if (!dpnt)
> > +       if (!dpnt->device)
> >                 return NULL;    /* No such device */
> 
> Maybe I don't understand this right, but shouldn't that be 
> 
> if (!dpnt || !dpnt->device)
>         return NULL;    /* No such device */

In both cases, the code is like this:

  dpnt = &rscsi_disks[dev_nr];
  if (!dpnt->device)
    return NULL;

So, it is unlikely that dpnt would be zero. It could be if rscsi_disks
were NULL, and in such case whole logics is toast.

-- Pete
