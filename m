Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292130AbSCRTPc>; Mon, 18 Mar 2002 14:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292231AbSCRTPX>; Mon, 18 Mar 2002 14:15:23 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:4270 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S292130AbSCRTPM>; Mon, 18 Mar 2002 14:15:12 -0500
Reply-To: <robertp@ustri.com>
From: "Robert Pfister" <robertp@ustri.com>
To: <prade@cs.sunysb.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Trapping all Incoming Network Packets 
Date: Mon, 18 Mar 2002 12:15:07 -0700
Message-ID: <003901c1ceb1$37268890$1e00a8c0@nomaam>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.GSO.4.33.0203181330530.5841-100000@compserv3>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

prade@cs.sunysb.edu writes:

>To do it in user space, you have to use the raw socket interface. This
>by-passes the entire TCP/IP stack. I want to sniff the packets, and make a
>decision based on certain characteristics of each packet. So I need to
>have a filter between the IP and link-layer. Also, I do not want the
>filter to slow down traffic. Hence I believe implementing inside kernel
>will be more efficient.

I've looked at an implementation of something similar. The approach was as
follows:

* insert a "hook" into the netif_rx that would act as a filter
* use a module that:
	* activates hook
	* apply filtering
	* sends back packets to netif_rx for normal processing
* when module is unloaded, deactivate the "hook"


