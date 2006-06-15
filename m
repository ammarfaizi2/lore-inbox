Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030537AbWFOOwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030537AbWFOOwt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 10:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbWFOOwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 10:52:49 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:63080 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030537AbWFOOws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 10:52:48 -0400
Message-ID: <44917421.4070508@watson.ibm.com>
Date: Thu, 15 Jun 2006 10:52:17 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@engr.sgi.com>
CC: Balbir Singh <balbir@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Chris Sturtivant <csturtiv@sgi.com>,
       Jamal <hadi@cyberus.ca>, Thomas Graf <tgraf@suug.ch>
Subject: Re: ON/OFF control of taskstats accounting data at do_exit
References: <449093D6.6000806@engr.sgi.com> <4490CDC2.3090009@watson.ibm.com> <4490D515.8070308@engr.sgi.com>
In-Reply-To: <4490D515.8070308@engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:
> 
> Are you saying if there is no listener, data will not be assembled and sent
> by the kernel?  I thought kernel would always send no matter whether there
> is listener? I apologize for the noise if i made a mistake.

It will be assembled by taskstats. But afaict, the sending of data by the netlink layer will
be halted within netlink_broadcast(), which is a couple of calls down the call path from
genlmsg_multicast(), which is used by taskstats uses to send data out.

Lets discuss turning off of taskstats assembly separately.


Jamal, Thomas,

If there are no listeners on a genetlink socket, do you think overhead of kernel paths that
continue to attempt sending multicast data on genetlink sockets is an issue ?


--Shailabh

