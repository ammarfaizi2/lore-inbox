Return-Path: <linux-kernel-owner+w=401wt.eu-S965077AbXADVef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbXADVef (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbXADVee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:34:34 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:30574 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965077AbXADVed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:34:33 -0500
To: Steve Wise <swise@opengridcomputing.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] [PATCH  v4 01/13] Linux RDMA Core Changes
X-Message-Flag: Warning: May contain useful information
References: <1167851839.4187.36.camel@stevo-desktop>
	<20070103193324.GD29003@mellanox.co.il>
	<1167855618.4187.65.camel@stevo-desktop>
	<1167859320.4187.81.camel@stevo-desktop>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 04 Jan 2007 13:34:27 -0800
In-Reply-To: <1167859320.4187.81.camel@stevo-desktop> (Steve Wise's message of "Wed, 03 Jan 2007 15:22:00 -0600")
Message-ID: <adawt424gt8.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Jan 2007 21:34:27.0442 (UTC) FILETIME=[1C546520:01C73048]
Authentication-Results: sj-dkim-8; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim8002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I'm back from vacation today.

Anyway I don't have a definitive statement on this right now.  I guess
I agree that I don't like having an extra parameter to a function that
should be pretty fast (although req notify isn't quite as hot as
something like posting a send request or polling a cq), given that it
adds measurable overhead.  (And I am surprised that the overhead is
measurable, since 3 arguments still fit in registers, but OK).

I also agree that adding an extra entry point just to pass in the user
data is ugly, and also racy.

Giving the kernel driver a pointer it can read seems OK I guess,
although it's a little ugly to have a backdoor channel like that.

I'm somewhat surprised the driver has to go into the kernel to rearm a
CQ -- what makes the operation need kernel privileges?  (Sorry for not
reading the code)
