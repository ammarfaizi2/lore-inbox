Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267261AbTCEPmJ>; Wed, 5 Mar 2003 10:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267268AbTCEPmI>; Wed, 5 Mar 2003 10:42:08 -0500
Received: from almesberger.net ([63.105.73.239]:20491 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S267261AbTCEPmF>; Wed, 5 Mar 2003 10:42:05 -0500
Date: Wed, 5 Mar 2003 12:52:31 -0300
From: Werner Almesberger <wa@almesberger.net>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get()
Message-ID: <20030305125230.B525@almesberger.net>
References: <20030305.065341.35361286.davem@redhat.com> <200303051528.h25FSqGi006413@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303051528.h25FSqGi006413@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Wed, Mar 05, 2003 at 10:28:52AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chas williams wrote:
> sk->receieve_queue i suspect -- more on that later) while the skb are
> moved to copy.  i am afraid i dont know much about how the clip driver
> operates.

What's happening there is that new CLIP connections start as normal
native ATM VCs, owned by atmarpd. When atmarpd clears them for IP
traffic, all the data that has been queued so far (i.e. any ATMARP
messages, and any IP - typically I'd expect to find a SYN there)
is removed from the native ATM VC's queue, and fed into the non-ATM
part of the stack, for de-encapsulation, etc.

Note that ATMARP will be delivered again to the "native ATM" VC's
queue, because that's how atmarpd receives ATMARP messages.

Figure 6 of http://www.almesberger.net/cv/papers/atm_on_linux.ps
shows the overall design (some details have changed since then,
though).

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
