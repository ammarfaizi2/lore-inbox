Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161475AbWFWBPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161475AbWFWBPJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 21:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161476AbWFWBPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 21:15:09 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:6463 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1161475AbWFWBPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 21:15:07 -0400
Date: Thu, 22 Jun 2006 19:13:28 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Dropping Packets in 2.6.17
In-reply-to: <fa.Ze3oSnDYEMz3/ITqeLQ2m0GF5wk@ifi.uio.no>
To: danial_thom@yahoo.com
Cc: =?ISO-8859-1?Q?=22=5C=22P=E1draig=5C=22Brady=22?= 
	<P@draigBrady.com>,
       linux-kernel@vger.kernel.org
Message-id: <449B4038.3040101@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.zPWsMAz4l0d9j5Voaw6Pdkcf//M@ifi.uio.no>
 <fa.Ze3oSnDYEMz3/ITqeLQ2m0GF5wk@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danial Thom wrote:
>>
>> I didn't use ITR, I used NAPI.
>>
> 
> If thats the case then your "system" would have
> the same problem that I'm encountering, since
> polling results in buckets of packets being
> dropped with heavy userland activity.

This is to some extent by design. If you processed all packets purely in 
interrupt context, at some point you can start receiving so many packets 
that you never leave interrupt context to perform any other useful work, 
no matter if your adapter can avoid generating an interrupt for every 
packet. Packet floods can completely hang the machine. Pushing the work 
into a softirq and disabling NIC interrupts in the interim allows the 
machine to continue performing other useful work.

If you want to give more priority to processing network packets at the 
expense of user processes then you likely need to increase the priority 
of the ksoftirqd thread(s). These compete for CPU time like any other 
processes.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

