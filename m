Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265574AbRFVX3R>; Fri, 22 Jun 2001 19:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265575AbRFVX3H>; Fri, 22 Jun 2001 19:29:07 -0400
Received: from mx01.uni-tuebingen.de ([134.2.3.11]:274 "EHLO
	mx01.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S265574AbRFVX26>; Fri, 22 Jun 2001 19:28:58 -0400
Date: Sat, 23 Jun 2001 00:09:12 +0200
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Pavel Machek <pavel@suse.cz>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: spindown
Message-ID: <20010623000912.A415@pelks01.extern.uni-tuebingen.de>
Mail-Followup-To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Pavel Machek <pavel@suse.cz>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010615152306.B37@toy.ucw.cz> <20010618222131.A26018@paranoidfreak.co.uk> <20010619124627.A202@bug.ucw.cz> <20010621180701.B4523@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.12i
In-Reply-To: <20010621180701.B4523@pcep-jamie.cern.ch>; from lk@tantalophile.demon.co.uk on Thu, Jun 21, 2001 at 06:07:01PM +0200
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 06:07:01PM +0200, Jamie Lokier wrote:
> Pavel Machek wrote:
> > > Isn't this why noflushd exists or is this an evil thing that shouldn't
> > > ever be used and will eventually eat my disks for breakfast?
> > 
> > It would eat your flash for breakfast. You know, flash memories have
> > no spinning parts, so there's nothing to spin down.
> 
> Btw Pavel, does noflushd work with 2.4.4?  The noflushd version 2.4 I
> tried said it couldn't find some kernel process (kflushd?  I don't
> remember) and that I should use bdflush.  The manual says that's
> appropriate for older kernels, but not 2.4.4 surely.

That's because of my favourite change from the 2.4.3 patch:

-       strcpy(tsk->comm, "kupdate");
+       strcpy(tsk->comm, "kupdated");

noflushd 2.4 fixed this issue in the daemon itself, but I had forgotten about 
the generic startup skript. (Rpms and debs run their customized versions.)

Either the current version from CVS, or

ed /your/init.d/location/noflushd << EOF
%s/kupdate/kupdated/g
w
q
EOF

should get you going.

Regards,

Daniel.

