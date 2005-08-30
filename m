Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVH3Nhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVH3Nhi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 09:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbVH3Nhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 09:37:38 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:38159 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1750796AbVH3Nhi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 09:37:38 -0400
X-IronPort-AV: i="3.96,153,1122872400"; 
   d="scan'208"; a="286641982:sNHT27471328"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: ppp_mppe+pptp for 2.6.14?
Date: Tue, 30 Aug 2005 08:37:12 -0500
Message-ID: <F437C2E521A1A546B226EEEBAC6478432F908B@ausx3mps313.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ppp_mppe+pptp for 2.6.14?
Thread-Index: AcWtGPiXmOGq51LrRa20F3le1NYoKwATojQg
From: <Matt_Domsch@Dell.com>
To: <james.cameron@hp.com>
Cc: <linux-kernel@vger.kernel.org>, <fcusack@fcusack.com>, <dsd@gentoo.org>,
       <akpm@osdl.org>, <paulus@samba.org>
X-OriginalArrivalTime: 30 Aug 2005 13:37:31.0365 (UTC) FILETIME=[F8949150:01C5AD67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

james.cameron@hp.com wrote:
> On Mon, Aug 29, 2005 at 05:10:34PM -0500, Matt Domsch wrote:
>> I've asked James Cameron, pptp project lead, to try a test to force
>> the server side to issue a CCP DOWN, to make sure the client-side
>> kernel ppp_generic module does the right thing and drops packets.
> 
> I've tested this now with a host running kernel 2.6.13 with Matt's
> SC_MUST_COMP patch to the kernel and to ppp 2.4.4b1, sending SIGUSR2
> to the pppd while flooding the connection with pings from the server.
> 
> The result is an LCP TermReq from the server to the client, after
> which no further data packets appear.  All the data packets up to the
> LCP TermReq are encrypted.  The client sends an LCP TermAck, then
> takes down the interface.  There's sign of CCP down, in that a CCP
> ConfReq appears from the server just after the LCP TermReq.    
> 
> I'm not sure this is an adequate test, and will take advice on that.
> 
> Test configuration;
> 
> - server, 2.6.13 + SC_MUST_COMP, ppp 2.4.4b1 + SC_MUST_COMP, pptpd
> 1.3.1 
> - client, 2.6.12.5 + SC_MUST_COMP, ppp 2.4.4b1 + SC_MUST_COMP, pptp
> 1.5.0 
> 
> Client side pppd log fragment;
> 
> local  IP address 10.8.0.2
> remote IP address 10.8.0.1
> Script /etc/ppp/ip-up started (pid 5036) Script /etc/ppp/ip-up
> finished (pid 5036), status = 0x0 rcvd [LCP TermReq id=0x2 "MPPE
> disabled"] LCP terminated by peer (MPPE disabled) Connect time 0.4
> minutes.   
> Sent 262920 bytes, received 262920 bytes.
> Script /etc/ppp/ip-down started (pid 5048) sent [LCP TermAck id=0x2]
> rcvd [CCP ConfReq id=0x2 <mppe +H -M +S -L -D -C>] Discarded non-LCP
> packet when LCP not open Script /etc/ppp/ip-down finished (pid 5048),
> status = 0x0 Connection terminated.   
> Modem hangup


This looks good.  One more thing I would ask, please repeat with a
server that doesn't have the SC_MUST_COMP pppd patch.  On SIGUSR2
the unmodified server should still send CCP DOWN to the client, which
should start dropping packets.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
