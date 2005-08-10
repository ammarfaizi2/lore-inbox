Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965190AbVHJQ1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbVHJQ1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 12:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbVHJQ1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 12:27:24 -0400
Received: from rgminet03.oracle.com ([148.87.122.32]:31358 "EHLO
	rgminet03.oracle.com") by vger.kernel.org with ESMTP
	id S965187AbVHJQ1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 12:27:24 -0400
Date: Wed, 10 Aug 2005 09:26:18 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: Christoph Hellwig <hch@infradead.org>, Zach Brown <zab@zabbo.net>,
       David Teigland <teigland@redhat.com>, Pekka Enberg <penberg@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS
Message-ID: <20050810162618.GH21228@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050802071828.GA11217@redhat.com> <84144f0205080203163cab015c@mail.gmail.com> <20050803063644.GD9812@redhat.com> <courier.42F768D5.000046F2@courier.cs.helsinki.fi> <42F7A557.3000200@zabbo.net> <1123598983.10790.1.camel@haji.ri.fi> <20050810072121.GA2825@infradead.org> <courier.42F9AD38.000018F9@courier.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <courier.42F9AD38.000018F9@courier.cs.helsinki.fi>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 10:31:04AM +0300, Pekka J Enberg wrote:
> It seems to me that the distributed locks must be acquired in ->nopage 
> anyway to solve the problem with memcpy() between two mmap'd regions. One 
> possible solution would be for the lock manager to detect deadlocks and 
> break some locks accordingly. Don't know how well that would mix with 
> ->nopage though... 
Yeah, my experience with ->nopage so far has indicated to me that we are to
avoid erroring out if at all possible which I believe is what we'd have to
do if a deadlock is found.
Also, I'm not sure how multiple dlms would coordinate deadlock detection in
that case.
This may sound naive, but so far OCFS2 has avoided the nead for deadlock
detection... I'd hate to have to add it now -- better to try avoiding them
in the first place.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
