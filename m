Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbVHYKDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbVHYKDe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 06:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVHYKDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 06:03:34 -0400
Received: from main.gmane.org ([80.91.229.2]:59023 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964910AbVHYKDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 06:03:34 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Daniel Brockman <daniel@brockman.se>
Subject: Re: Where do packets sent to 255.255.255.255 go?
Date: Thu, 25 Aug 2005 12:01:06 +0200
Message-ID: <873boys5ct.fsf@wigwam.deepwood.net>
References: <87ek8isual.fsf@wigwam.deepwood.net> <430D7E8D.2070305@lifl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-46b670d5.028-10-67766c2.cust.bredbandsbolaget.se
X-Face: :&2UWGm>e24)ip~'K@iOsA&JT3JX*v@1-#L)=dUb825\Fwg#`^N!Y*g-TqdS
 AevzjFJe96f@V'ya8${57/T'"mTd`1o{TGYhHnVucLq!D$r2O{IN)7>.0op_Y`%r;/Q
 +(]`3F-t10N7NF\.Mm0q}p1:%iqTi:5]1E]rDF)R$9.!,Eu'9K':y9^U3F8UCS1M+A$
 8[[[WT^`$P[vu>P+8]aQMh9giu&fPCqLW2FSsGs
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Cancel-Lock: sha1:WNmgvaTPCC+JdKG9ffR6icHoOIg=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

>> If I understand correctly, packets sent to the all-ones
>> broadcast address only go out through a single interface.
>
> I have some blur memories about this kind of issue, so my
> answer my be wrong on some points...

It turns out you are exactly right on all points. :-)

>> My question is threefold:
>>
>>  1. Why doesn't Linux send 255.255.255.255 packages
>>     through all network interfaces?  (I realize that
>>     this is probably not a Linux-specific question.)
>
> IIRC, Linux treats 255.255.255.255 as a normal IP address.
> Therefore it will follow the route for such an address and
> select the interface it is associated (probably eth0 if
> you are on a LAN).

That makes a lot of sense, and it appears to be the case.

>>  2. How does it choose which interface to send through?
>>     My first guess was that it just took the first
>>     Ethernet interface and used that for broadcasting.
>>     But playing around with nameif, this seems not to
>>     be the case.
>
> cf 1
>
>>  3. Can I set the default broadcast interface explicitly?
>>     For example, say I wanted broadcasts to go out over
>>     eth1 by default, instead of over eth0.  What if I
>>     wanted them to get sent through tap0?
>
> Again, I'm not sure, but I think that you can force the
> interface by adding a special route for IP 255.255.255.255
> and with mask 255.255.255.255 to the interface you want.

Yes, this works!  It's so simple --- I can't believe I
didn't try it before.  I did mess around with iptables,
trying to add some weird PREROUTEing DNAT that would
redirect the packets, but I didn't know what I was doing.

> Hope this help, even if my memory is a bit confused,

Yes, it did help.  Thanks a bunch, Eric!  Your memory seems
to be in great shape. :-)


Regards,

-- 
Daniel Brockman <daniel@brockman.se>

