Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160277AbQHAVbW>; Tue, 1 Aug 2000 17:31:22 -0400
Received: by vger.rutgers.edu id <S160269AbQHAVaf>; Tue, 1 Aug 2000 17:30:35 -0400
Received: from enterprise.cistron.net ([195.64.68.33]:1973 "EHLO enterprise.cistron.net") by vger.rutgers.edu with ESMTP id <S160312AbQHAVaC>; Tue, 1 Aug 2000 17:30:02 -0400
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: RLIM_INFINITY inconsistency between archs
Date: 1 Aug 2000 21:50:47 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <8m7gnn$c8k$1@enterprise.cistron.net>
References: <7iw6kYsXw-B@khms.westfalen.de> <8m54u3$dh0$1@cesium.transmeta.com> <8m65np$mm3$1@enterprise.cistron.net> <8m6vsk$er6$1@cesium.transmeta.com>
X-Trace: enterprise.cistron.net 965166647 12564 195.64.65.200 (1 Aug 2000 21:50:47 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.rutgers.edu
Sender: owner-linux-kernel@vger.rutgers.edu

In article >8m6vsk$er6$1@cesium.transmeta.com>,
H. Peter Anvin <hpa@zytor.com> wrote:
>Followup to:  <8m65np$mm3$1@enterprise.cistron.net>
>By author:    miquels@cistron.nl (Miquel van Smoorenburg)
>In newsgroup: linux.dev.kernel
>> 
>> Why? As I said you can use a glue layer. Note that you still
>> cannot mix /usr/include/net and /usr/src/linux/include/net anyway,
>> so clashes will always exist with the current system.
>> I agree it should probably be fixed.
>
>A GLUE LAYER IS FREQUENTLY NOT AN OPTION,

No need to shout, I did say I agreed with you ;)

>because you have no data
>types to carry around the semantic contents in.  You really *DO* need
>to mix both types.

Yes. So it should be fixed, right? Perhaps in 2.5 then we should
look into:

- moving kernel headers around: linux/include now contains

  o linux
  o asm
  o net
  o scsi
  o video

  To make sure we _can_ use libc headers and kernel headers we must
  eliminate clashes. linux/include/net isn't the same as /usr/include/net,
  same goes for /usr/include/scsi etc. So it's probably best to move
  everything one level to:

  o linux/kernel/*.h (this was most of linux/*.h)
  o linux/public/*.h (contains public interfaces to the kernel)
  o linux/asm/*.h
  o linux/net/*.h
  o linux/scsi/*.h
  o linux/video/*.h

  Hmm, perhaps that is not nessecary. If we're going to have a
  linux/public hierarchy, you wouldn't need the rest of the
  headers anyway, so they don't need to be moved. Cool ;)

- We need a script in /lib/modules/version/kernel-config that prints
  the CFLAGS used to compile that kernel on stdout to compile modules.

Now, I think that all of this has been mentioned before on this
list, those are not completely my ideas. Somebody mentioned marking
structures/defines/etc that need to be exported with a special
comment so that a script could generate a set of headers with the
public interfaces. That is about the same as the public/ idea,
and perhaps a bit easier, since it wouldn't annoy the hell out
of all those device driver writers that see the interface change again..

Mike.
-- 
Cistron Certified Internetwork Expert #1. Think free speech; drink free beer.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
