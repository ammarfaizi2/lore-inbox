Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbVJBGEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbVJBGEw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 02:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbVJBGEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 02:04:51 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:5812 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1750979AbVJBGEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 02:04:51 -0400
Message-ID: <433F7877.1060707@nortel.com>
Date: Sun, 02 Oct 2005 00:04:39 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       "Theodore Ts'o" <tytso@mit.edu>, dipankar@in.ibm.com,
       viro@ftp.linux.org.uk
Subject: Re: dentry_cache using up all my zone normal memory
References: <433189B5.3030308@nortel.com> <433DB64B.70405@nortel.com> <20051001232211.GA21518@xeon.cnet>
In-Reply-To: <20051001232211.GA21518@xeon.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Oct 2005 06:04:41.0902 (UTC) FILETIME=[2DF344E0:01C5C717]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo wrote:

> How can this be reproduced? (point to a URL if you already explained
> that in detail).

I mentioned this earlier in the thread.  I'm running 2.6.14-rc4 on a 
pentium-M based atca blade with a bit over 3GB of memory.  When I run 
the "rename14" test from LTP with /tmp mounted on tmpfs, the system runs 
out of zone normal memory and the OOM killer starts killing processes.

If I have /tmp mounted nfs, the problem doesn't occur.  If I use the 
boot args to limit the memory to 896MB the problem doesn't occur.  If I 
run the testcase on a dual Xeon with multiple gigs of memory, the 
problem doesn't occur.

> Someone else on the thread said you had zillions of file descriptors
> open?

This does not appear to be the case.  The testcase has two threads.

thread 1 loops doing the following:
fd = creat("./rename14", 0666);
unlink("./rename14");
close(fd);

thread 2 loops doing:
rename("./rename14", "./rename14xyz");

> Need to figure out they can't be freed. The kernel is surely trying it
> (also a problem if it is not trying). How does the "slabs_scanned" field
> of /proc/vmstats looks like?

That's something I haven't checked...will have to get back to you.

> Bharata maintains a patch to record additional statistics, haven't 
> you tried it already?

Already tried.  You should be able to find results earlier in this thread.

Chris
