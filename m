Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130470AbRCPTLb>; Fri, 16 Mar 2001 14:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130517AbRCPTLW>; Fri, 16 Mar 2001 14:11:22 -0500
Received: from mercury.ultramaster.com ([208.222.81.163]:3968 "EHLO
	mercury.ultramaster.com") by vger.kernel.org with ESMTP
	id <S130470AbRCPTLK>; Fri, 16 Mar 2001 14:11:10 -0500
Message-ID: <3AB264F2.7D19842F@dm.ultramaster.com>
Date: Fri, 16 Mar 2001 14:09:38 -0500
From: David Mansfield <lkml@dm.ultramaster.com>
Organization: Ultramaster Group LLC
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pierre Etchemaite <petchema@concept-micro.com>
CC: Jani Jaakkola <jjaakkol@cs.Helsinki.FI>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] fix a bug in ioctl(CDROMREADAUDIO) in cdrom.c in 2.2
In-Reply-To: <XFMail.20010315140400.petchema@concept-micro.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Etchemaite wrote:
> 
> Le 14-Mar-2001, Jani Jaakkola écrivait :
> >
> > Using ioctl(CDROMREADAUDIO) with nframes argument being larger than 8 and
> > not divisible by 8 causes kernel to read and return more audio data than
> > was requested. This is bad since it clobbers up processes memory
> > (I noticed this when my patched cdparanoia segfaulted).
> 
> Same thing for 2.4.2.
> 
> Is my allocation loop "over engineering", or just plain bad thing to do ?
> 

I've been running this (or close: my version tries 8 frames, then jumps
immediately to 1, without trying 4 and 2 in between if the kmalloc
fails) since it was changed.  Without such a patch, my CDDA read speed
drops to 25% the original rate.  You also have the fix that started the
thread!

Jens (cdrom maintainer) said he was working on a more elegant solution,
but to me, such a simple fix as yours should go in the kernel in the
meantime.  Jens?

-- 
David Mansfield                                           (718) 963-2020
david@ultramaster.com
Ultramaster Group, LLC                               www.ultramaster.com
