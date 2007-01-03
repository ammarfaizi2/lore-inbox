Return-Path: <linux-kernel-owner+w=401wt.eu-S1750729AbXACMHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbXACMHn (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 07:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbXACMHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 07:07:43 -0500
Received: from montreal.eicon.com ([192.219.17.124]:39602 "EHLO
	EICONMTL.eicon.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbXACMHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 07:07:42 -0500
X-Greylist: delayed 847 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 07:07:42 EST
Date: Wed, 3 Jan 2007 11:54:26 +0000
From: Steve Hill <steve.hill@dialogic.com>
X-X-Sender: shill@shill1-mobl.eicon.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Intermittent SCTP multihoming breakage
Message-ID: <Pine.CYG.4.58.0701031132110.3128@shill1-mobl.eicon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Jan 2007 11:54:18.0250 (UTC) FILETIME=[E60576A0:01C72F2D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Apologies if I'm posting to the wrong list - the lksctp lists seem to be a
bit dead these days and a bit of Googling seemed to inidicate that SCTP
developemnt discussions might have moved here.

I'm running under the 2.6.16.1 kernel and have an intermittent problem
with the SCTP stack.  Having reviewed the git logs I can't see any
indication that the problem has been fixed in more recent kernels, but it
is very difficult to test since it is so intermittent.

I am running a multihomed connection between 2 machines, (2 NICs on
each machine, so 2 paths for the connection) and tcpdump shows heartbeat
requests and acks on both paths.  Putting data over the link correctly
sends it over the first path.

If I drop the traffic on one of the NICs then most of the time it
correctly fails over the the second path and I see the data being sent
and acknowledged correctly on the second path.  However, I also
intermittently see two failure conditions:

1. Sometimes, just after failing over to the second path I see an ABORT.
2. More frequently, the association stays up indefinately, with heartbeat
requests and acks on the second path, but no data chunks are sent even
though the transmit queue on the transmitting end appears to be full and
the socket is blocking writes.

I have been adding debugging to the kernel in an attempt to track down the
source of the second failure condition, and I am wondering if anyone else
has seen similar behaviour?

-- 
 - Steve Hill
   Software Engineer
   Dialogic
   Fordingbridge, Hampshire, UK
   +44-1425-651392
   steve.hill@dialogic.com
