Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUHSH0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUHSH0E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 03:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUHSH0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 03:26:04 -0400
Received: from gwout.thalesgroup.com ([195.101.39.227]:3337 "EHLO
	GWOUT.thalesgroup.com") by vger.kernel.org with ESMTP
	id S263024AbUHSHZn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 03:25:43 -0400
Message-ID: <412455F0.9080408@fr.thalesgroup.com>
Date: Thu, 19 Aug 2004 09:25:36 +0200
From: "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Reply-To: pierre-olivier.gaillard@fr.thalesgroup.com
Organization: Thales Air Defence
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: voluntary-preempt-2.6.8.1-P1 seems to lose UDP messages.
References: <41233923.80202@fr.thalesgroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P.O. Gaillard wrote:

 > Hello,
 >
 > I have a real-time application that transmits 20 MBytes/s over
 > UDP/Gigabit Ethernet between 2 PCs. The NICs are from Intel and use the
 > e1000 driver (MTU=1500). On the receive side, the computer has to
 > process the data (real-time tasks doing signal processing work and using
 > up 50% of the CPU time).
 >
 > This app works OK with 2.6.7 and 2.6.8.1 : the app does not complain
 > about lost messages.

Thanks to the support of Pádraig Brady, I have found out that the 
voluntary-preempt patch is "innocent".
In fact, it seems that the patch changes the scheduling of the application and 
reveals that the UDP reception buffer is too small for this application.

So I changed /proc/sys/net/core/rmem_default to 200KBytes as instructed and the 
problem disappeared.

It seems a bit counter-intuitive since the application has real-time threads 
that are supposed to receive and timestamp all incoming messages as soon as they 
arrive. I would therefore have expected the voluntary-preempt patch to improve 
the reactivity of these tasks.

Anyway, it seems safe to say that the losses of UDP messages were not caused by 
a bug in the voluntary-preempt patch. This is good news since it means that I 
can use this patch.

Note: after running the program for the whole night the problem seemed to come 
back after 2 hours or so. I will try with eth0/threaded=0 as Lee Revell suggested.

   thanks a lot for your help,

	P.O. Gaillard

