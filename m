Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWHBGhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWHBGhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 02:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWHBGhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 02:37:23 -0400
Received: from percy.comedia.it ([212.97.59.71]:11492 "EHLO percy.comedia.it")
	by vger.kernel.org with ESMTP id S1750889AbWHBGhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 02:37:23 -0400
Date: Wed, 2 Aug 2006 08:37:21 +0200
From: Luca Berra <bluca@comedia.it>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: Neil Brown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: let md auto-detect 128+ raid members, fix potential race condition
Message-ID: <20060802063721.GC28815@percy.comedia.it>
Mail-Followup-To: Alexandre Oliva <aoliva@redhat.com>,
	Neil Brown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
References: <ork65veg2y.fsf@free.oliva.athome.lsd.ic.unicamp.br> <20060730124139.45861b47.akpm@osdl.org> <orac6qerr4.fsf@free.oliva.athome.lsd.ic.unicamp.br> <17613.16090.470524.736889@cse.unsw.edu.au> <ord5blcyg0.fsf@free.oliva.athome.lsd.ic.unicamp.br> <17614.44057.322945.156592@cse.unsw.edu.au> <orpsflrxmb.fsf@free.oliva.athome.lsd.ic.unicamp.br> <orac6p870v.fsf@free.oliva.athome.lsd.ic.unicamp.br> <oru04wfakx.fsf@free.oliva.athome.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <oru04wfakx.fsf@free.oliva.athome.lsd.ic.unicamp.br>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 05:46:38PM -0300, Alexandre Oliva wrote:
>Using the mkinitrd patch that I posted before, the result was that
>mdadm did try to bring up all raid devices but, because the raid456
>module was not loaded in initrd, the raid devices were left inactive.

probably your initrd is broken, it should not have even tried to bring
up an md array that was not needed to mount root.

>Then, when rc.sysinit tried to bring them up with mdadm -A -s, that
>did nothing to the inactive devices, since they didn't have to be
>assembled.  Adding --run didn't help.
>
>My current work-around is to add raid456 to initrd, but that's ugly.
>Scanning /proc/mdstat for inactive devices in rc.sysinit and doing
>mdadm --run on them is feasible, but it looks ugly and error-prone.
>
>Would it be reasonable to change mdadm so as to, erhm, disassemble ;-)
>the raid devices it tried to bring up but that, for whatever reason,
>it couldn't activate?  (say, missing module, not enough members,
>whatever)

this would make sense if it were an option, patches welcome :)

L.

-- 
Luca Berra -- bluca@comedia.it
        Communication Media & Services S.r.l.
 /"\
 \ /     ASCII RIBBON CAMPAIGN
  X        AGAINST HTML MAIL
 / \
