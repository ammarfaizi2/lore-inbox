Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbWCTQ12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbWCTQ12 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbWCTQ10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:27:26 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:4281 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751150AbWCTQ1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:27:23 -0500
Message-ID: <441ED776.2000108@cfl.rr.com>
Date: Mon, 20 Mar 2006 11:25:26 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: fix uid/gid options and add uid/gid=ignore and forget
 options
References: <441E142F.2030305@cfl.rr.com> <20060319200424.5a3647aa.akpm@osdl.org>
In-Reply-To: <20060319200424.5a3647aa.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Mar 2006 16:29:50.0619 (UTC) FILETIME=[82B306B0:01C64C3B]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14335.000
X-TM-AS-Result: No--12.790000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I didn't see that update, and I don't miss much.
> 

See http://lkml.org/lkml/2006/3/5/171

> Please provide a description of this change.  What problem is it fixing? 
> How does it fix it?  What are the consequences of not making this change?

In the initial patch I made a typo.  As Pekka Enberg pointed out, with 
the if still following the else, you can still get a null uid written to 
the disk if you specify a default uid= without uid=forget.  In other 
words, if the desktop user is uid=1000 and the mount option uid=1000 is 
given ( which is done on ubuntu automatically and probably other 
distributions that use hal ), then if any other user besides uid 1000 
owns a file then a 0 will be written to the media as the owning uid 
instead.  This is exactly what the original patch was trying to prevent.

