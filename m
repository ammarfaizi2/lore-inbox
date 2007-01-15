Return-Path: <linux-kernel-owner+w=401wt.eu-S1751798AbXAODr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbXAODr6 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 22:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbXAODr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 22:47:58 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:43623 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbXAODr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 22:47:57 -0500
In-Reply-To: <45AAF3AC.3070600@gentoo.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, stable@kernel.org
MIME-Version: 1.0
Subject: Re: 2.6.19.2 regression introduced by "IPV4/IPV6: Fix inet{,6} device
 initialization order."
X-Mailer: Lotus Notes Release 7.0 HF277 June 21, 2006
Message-ID: <OF0ECEC103.470302BB-ON88257264.00142A49-88257264.0014DC27@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Sun, 14 Jan 2007 19:47:49 -0800
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 7.0.2HF32 | October 17, 2006) at
 01/14/2007 20:47:55,
	Serialize complete at 01/14/2007 20:47:55
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I expect this is the failure to join the all-nodes multicast group,
in which case the fix has already been posted to netdev. I
believe the router advertisements are sent to that, and if the
join failed, it wouldn't receive any of them.

I think it's better to add the fix than withdraw this patch, since
the original bug is a crash.

Details:
The IPv6 code passes the "dev" entry to the multicast group
incrementer and uses it to dereference to get the in6_dev.
IPv4, by contrast, passes the in_dev directly to its equivalent
functions.

IPv6 joins the required "all-nodes" multicast group in the
multicast device initialization function, which due to the fix
won't have a dev entry at that time. The patch posted by
Yoshifuji Hideaki moves the all-nodes join until after the
ip6_ptr is added to the dev.

                                        +-DLS

