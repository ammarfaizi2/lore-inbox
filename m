Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267839AbUHUUxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267839AbUHUUxz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 16:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267834AbUHUUxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 16:53:22 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:58005 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S267822AbUHUUq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 16:46:59 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Kalin KOZHUHAROV'" <kalin@thinrope.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sat, 21 Aug 2004 23:46:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <cg73b2$8bs$1@sea.gmane.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcSHXrz07pxlm4ArTXSIBiviM7vyHwAaQu7A
Message-Id: <S267822AbUHUUq7/20040821204944Z+889@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I thought that just returning "0" from these function would
successfully disable checksumming, but now the situation is as such;

- TCP still does the checksum and seems as if no patch is applied at all
- UDP now does not do checksum if it should return a destination unreachable
error. (that means, when I inject a packet to a closed socket, regardless of
the checksum in the packet, the system now sends a destination unreachable
error). However this is the only change, still the application do not
receive UDP packets with wrong checksum. (Such as netcat or snmpget etc.)

Perhaps this is not the way?

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Kalin KOZHUHAROV
Sent: Saturday, August 21, 2004 11:07 AM
To: linux-kernel@vger.kernel.org
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level

Josan Kadett wrote:
> Here is the very original linux-kernel mailing list, and if I cannot find
an
> answer here, then nowhere on earth can this answer be found. I also saw
some
> other messages regarding the same issue on the net. None of them is
answered
> correctly; and also as if this is a very "forbidden" thing to disable the
> checksums, most replies are as if they are "unbreakable rules of god".
> Really, I am losing my patience with this. It is also very odd to write a
> low-level application in order to just disable a "feature" of the kernel
to
> deal with a faulty piece of embedded firmware.

OK, try this, not tested:

replace the return statements with "return 0;" in:

net/ipv4/udp.c, function __udp_checksum_complete, about line 759
net/ipv4/icp_input.c, function __tcp_checksum_complete_user, about line 4070

* line numbers above are for linux-2.6.7

Kalin.

-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



