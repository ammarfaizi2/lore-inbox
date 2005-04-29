Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVD2J0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVD2J0d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 05:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVD2J0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 05:26:33 -0400
Received: from mailgate.quadrics.com ([194.202.174.11]:61108 "EHLO
	qserv01.quadrics.com") by vger.kernel.org with ESMTP
	id S262160AbVD2J03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 05:26:29 -0400
Message-ID: <4271FD9B.8000402@quadrics.com>
Date: Fri, 29 Apr 2005 10:25:47 +0100
From: David Addison <addy@quadrics.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Linux VM hooks for advanced RDMA NICs
References: <426E62ED.5090803@quadrics.com>  <42708EE9.3010503@ens-lyon.org> <1114762772.7183.285.camel@gaston>
In-Reply-To: <1114762772.7183.285.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Apr 2005 09:19:43.0640 (UTC) FILETIME=[9449C980:01C54C9C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Benjamin Herrenschmidt wrote:
>>>+ioproc_register_ops(struct mm_struct *mm, struct ioproc_ops *ip)
>>>+{
>>>+	ip->next = mm->ioproc_ops;
>>>+	mm->ioproc_ops = ip;
>>>+
>>>+	return 0;
>>>+}
>>>+
> 
> Why not use a list_head along with linux standard list primitives ?
> 
> Ben.
> 
> 
The reason we didn't use the standard list primitives was that we wanted the normal
case where no ioproc ops were registered to have minimal impact and this just comes
down to mm->ioproc_ops being checked against being zero, which is slightly lighter weight
than using the list primitives.

Also entries are rarely removed from the list using the ioproc_deregister function as
in the normal case they get removed in the call to ioproc_release.  Hence there is little
need for the doubly linked list.

Cheers,
David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
