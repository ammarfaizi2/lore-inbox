Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbRG1UBu>; Sat, 28 Jul 2001 16:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267053AbRG1UBj>; Sat, 28 Jul 2001 16:01:39 -0400
Received: from color.sics.se ([193.10.66.199]:20961 "EHLO color.sics.se")
	by vger.kernel.org with ESMTP id <S267048AbRG1UBb>;
	Sat, 28 Jul 2001 16:01:31 -0400
Message-ID: <3B631A00.8E860DC1@sics.se>
Date: Sat, 28 Jul 2001 22:01:04 +0200
From: Thiemo Voigt <thiemo@sics.se>
Organization: SICS
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: Sridhar Samudrala <samudrala@us.ibm.com>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        lartc@mailman.ds9a.nl, diffserv-general@lists.sourceforge.net,
        rusty@rustcorp.com.au
Subject: Re: [PATCH] Inbound Connection Control mechanism: Prioritized Accept
In-Reply-To: <200107281912.XAA17362@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

kuznet@ms2.inr.ac.ru wrote:

> Hello!
>
> > Low priority connections can clog the accept queue only when there are no
> > high priority connection requests coming along. As soon as a slot becomes empty
> > in the accept queue, it becomes available for a high priority connection.
>
> And in presence of persistent low priority traffic, high priority connection
> will not have any chances to take this slot. When high priority connection
> arrives all the slots are permanently busy with low ones.
>
> > If that happens, TCP SYN policing can be employed to limit the rate of low
> > priority connections getting into accept queue.
>

The aim of TCP SYN policing is to prevent server overload by discarding
connection requests early when the server system is about to reach overload.
One of the indicators of overload might be that the accept queue is
close to being filled up, there is little CPU time etc.
In these cases, TCP SYN policing should adapt (i.e. lower) the acceptance rates.
In such an adaptive  system, the accept queue is not supposed to be completely
filled, thus low priority connections are not able to starve high priority
connections. By the way, different acceptance rates can be given
to different priority classes.

A more detailed discussion than on the website can be found
in the paper "In-kernel mechanisms for adaptive  control of
overloaded web servers", available at
http://wwwtgs.cs.utwente.nl/Docs/eunice/summerschool/papers/programme.html
This paper discusses TCP SYN policing and prioritized listen queue.


Cheers,
Thiemo


