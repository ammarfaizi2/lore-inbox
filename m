Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVFQBxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVFQBxU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 21:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVFQBxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 21:53:19 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:51090 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261892AbVFQBwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 21:52:53 -0400
Message-ID: <42B22CD3.9080600@nortel.com>
Date: Thu, 16 Jun 2005 19:52:19 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>
Subject: Re: why does fsync() on a tmpfs directory give EINVAL?
References: <42B1DBF1.4020904@nortel.com>	<20050616135708.4876c379.akpm@osdl.org>	<42B20317.6000204@nortel.com> <20050616162933.25dee57b.akpm@osdl.org>
In-Reply-To: <20050616162933.25dee57b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Chris Friesen <cfriesen@nortel.com> wrote:

>>Currently tmpfs reuses the simple_dir_operations from libfs.c.
>>
>>Would it make sense to add the empty fsync() function there, and have 
>>all other users pick it up as well?  Is this likely to break stuff?
>  
> Isn't simple_sync_file() suitable?

I think it would be fine.  The issue is that currently for directories 
tmpfs doesn't have it's own set of operations--it reuses the 
simple_dir_operations set of file ops from libfs.

We could make a tmpfs-specific set of operations that is identical to 
simple_dir_operations but with the addition of setting the fsync 
function to simple_sync_file().

Alternately, if it makes sense for all the users of 
simple_dir_operations we could modify it directly and all of the other 
users of simple_dir_operations would get the change for free.  I don't 
know enough about the other filesystems to know if this makes sense or not.

Chris
