Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268106AbTBMVrG>; Thu, 13 Feb 2003 16:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268104AbTBMVrF>; Thu, 13 Feb 2003 16:47:05 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:39663 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268106AbTBMVrF>;
	Thu, 13 Feb 2003 16:47:05 -0500
Subject: Re: IPSec: AH/ESP combination problems
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OFBA809B11.11A01039-ON86256CCC.0073A2BB-86256CCC.0075F426@pok.ibm.com>
From: "Tom Lendacky" <toml@us.ibm.com>
Date: Thu, 13 Feb 2003 15:28:22 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 02/13/2003 04:56:10 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After some more reading of the RFC I realized that my logic is incorrect in
regards to what I called Problem #1 and #2 and that those are not problems.
I don't believe that it is valid to have a combination of [IP][AH][ESP][IP]
for tunnel mode and that the test I used to drive that needs to be changed.

   You can enforce the ordering exactly when the xfrm templates
   are built, this ensures that any fully resolved xfrm state
   created from them have the correct ordering as well.

As for the ordering of the modes (transport then tunnel) and the ordering
of the protocols within transport mode (IPCOMP then ESP then AH) I see
where that fix can be incorporated (in parse_ipsecrequests of af_key.c).
My question is should I do any ordering of the protocols within tunnel
mode.  While the ordering within transport mode is specified in the RFCs
(2401 and 3173), tunnel mode has no such requirement that I can tell.  Any
suggestions or should the order just be how the request is received by the
pfkey interface?

Also, the general direction I am looking at for the fix is to loop through
the requests multiple times processing IPCOMP transport first, then ESP
transport, then AH transport, and then the tunnel mode protocols.

Tom



