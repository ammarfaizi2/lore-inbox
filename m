Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVANEBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVANEBn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 23:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVANEBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 23:01:43 -0500
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:2539 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261882AbVANEBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 23:01:39 -0500
Message-ID: <41E743F3.3090201@kolivas.org>
Date: Fri, 14 Jan 2005 15:00:51 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au, lkml@s2y4n2c.de,
       rlrevell@joe-job.com, arjanv@redhat.com, joq@io.com, chrisw@osdl.org,
       mpm@selenic.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <200501140351.j0E3pdpe027121@localhost.localdomain>
In-Reply-To: <200501140351.j0E3pdpe027121@localhost.localdomain>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig15DD32CB5125007FDC76EC2D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig15DD32CB5125007FDC76EC2D
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Paul Davis wrote:
>>>its a fine answer, but its the answer to a slightly different
>>>question. if anyone (maybe us audio freaks, maybe someone else) comes
>>>up with a reason to want "The Real SCHED_FIFO", the original question
>>>will have gone unanswered.
>>
>>Ah then  you missed something. You can set the max cpu of SCHED_ISO to 
>>100% and then you have it.
> 
> 
> true, i missed that :) but i also recall you saying you were thinking
> of having no prioritization within SCHED_ISO ... or am i remembering
> wrong? 

Nothing is set in stone.  I wont even look at code until Ingo or Linus 
rules on this. Ingo has expressed interest in SCHED_ISO on a previous 
thread with me.

> also, is it just me, or having to ways to achieve the exact
> same result seems very un-linux-like ... and if they are not exact
> same results, how does a regular user get the SCHED_FIFO ones? is the
> answer just "they don't" ?

To answer your question, the second of my proposals was to not have a 
separate scheduling class at all. To let normal users set SCHED_FIFO and 
SCHED_RR, possibly with all their priorities intact, but for there to be 
limits placed on their usage of these classes. The reason I suggested 
not supporting priorities is that proper real time scheduling would 
entail being able to say "I need x cycles, to complete by y time and I 
can or cannot be preempted". With these QoS requirements, a whole new 
scheduling style (EDF) would need to be implemented. Without actually 
implementing this, if you set a limit of cpu to 70%, all it takes is one 
FIFO process to run long enough at high enough priority and all your 
other soft real time tasks go to SCHED_NORMAL, which is nothing like 
what happens with true RT scheduling. Forcing all soft RT threads to 
round robin at the same priority would make them sort themselves out. 
It's a compromise either way, and in fact this latter way is what OSX 
does and works well in practice as well as theory.

Cheers,
Con

--------------enig15DD32CB5125007FDC76EC2D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB50PzZUg7+tp6mRURAod1AKCUOtD9E87t86cQDEDBwdiNg9EYmwCfbeaC
wEqsGTATuHsZUMGWleh0/pU=
=k1R2
-----END PGP SIGNATURE-----

--------------enig15DD32CB5125007FDC76EC2D--
