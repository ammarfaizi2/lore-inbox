Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311568AbSCTFck>; Wed, 20 Mar 2002 00:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311567AbSCTFcb>; Wed, 20 Mar 2002 00:32:31 -0500
Received: from 203-109-249-30.ihug.net ([203.109.249.30]:5134 "EHLO
	boags.getsystems.com") by vger.kernel.org with ESMTP
	id <S311566AbSCTFcX>; Wed, 20 Mar 2002 00:32:23 -0500
Date: Wed, 20 Mar 2002 16:32:15 +1100
From: Zenaan Harkness <zen@getsystems.com>
To: Paul Davis <pbd@Op.Net>
Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Alsa-devel] Re: Playback stutters
Message-ID: <20020320163214.A31970@getsystems.com>
In-Reply-To: <20020320150503.A31328@getsystems.com> <200203200412.XAA07872@renoir.op.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 11:15:12PM -0500, Paul Davis wrote:
> >I am getting the same with stock 2.4.18, DELL Inspiron laptop (Maestro
> >3i), my test is:
> >
> >copy a cd image file from one partition to another, while trying to play
> >an mp3 using mpg123.
> >
> >The mp3 skips all over the place.
> 
> since you almost certainly have IDE drivers, have you configured them
> correctly using hdparm? these are source of considerable scheduling
> latency, in ways that AFAIK are not improved by any of the "latency
> reducing" patches available. don't ask me how to configure them - i
> only use SCSI drives - but a quick google search should reveal
> relevant advice.

thanks

hdparm improves the situation, but I still get some (minimal) skips now:

zen8100a:~# hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 7296/255/63, sectors = 117210240, start = 0
 busstate     =  1 (on)


My current 'test':
 - playing an mp3
 - running make clean && make bzImage
 - copying a cd image between two partitions
 - loading up the odd application (eg. mozilla)

With hdparm settings I've tried:
 - 2.4.18 + preempt + lockbreak
 - 2.4.18 + lowlatency
 - 2.4.19-pre3-ac3 + preempt

These seem to all give the same minimal skips with above activities.

No skips with only the kernel compile (not doing the large copy).

ta
zen
