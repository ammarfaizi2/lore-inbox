Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbVKGP7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbVKGP7e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 10:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbVKGP7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 10:59:34 -0500
Received: from mailgw2.fnal.gov ([131.225.111.12]:32477 "EHLO mailgw2.fnal.gov")
	by vger.kernel.org with ESMTP id S964852AbVKGP7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 10:59:33 -0500
Date: Mon, 07 Nov 2005 09:59:32 -0600 (CST)
From: Steven Timm <timm@fnal.gov>
Subject: RE: rpc-srv/tcp: nfsd: sent only -107 bytes (fwd)
In-reply-to: <EXCHG2003o4lB4BwOZx000005bd@EXCHG2003.microtech-ks.com>
To: Roger Heflin <rheflin@atipa.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.62.0511070943420.6791@snowball.fnal.gov>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
References: <EXCHG2003o4lB4BwOZx000005bd@EXCHG2003.microtech-ks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Nov 2005, Roger Heflin wrote:
>>
>> I am seeing repeated errors of rpc-srv/tcp: nfsd: sent only
>> -107 bytes in the /var/log/messages of my machine.  Full
>> configuration info is below.  Only suggestion I have seen
>> thus far increase the number of nfsd that are running.  we
>> have done this, raising from 8 to 64, the problem persists.
>> Are there any other suggestions that could help this problem?
>>
>> Thanks
>>
>
> I have only seen this problem with large numbers of NFS clients, given
> your address I suspect that would be the issue.

wc -l on /var/lib/nfs/rmtab gives 744 lines.  There are 203 client 
machines, each mounting on the average of 3 mounts, but obviously
some mount a few more.  Most of the mounts are done via automount, which
as you can guess is timing out on the average of 10-12 attempts in
the course of the day.
>
> What kernel are you running?  I saw this issue on the 2.4 series, the
> large 2.6 things we have built avoided using TCP given that we had
> seen this issue.

Currently running 2.4.21-32.0.1 as put out by RedHat with XFS file
system patches.  will upgrade to 2.4.21-37 later this week.
>
> There is a calculation someplace in nfs that determines how many of these
> things exist, is is some base + so many per nfs thread.  If you
> search for message you have there are some posts on the NFS lists
> about it that I made last year.
>
> On the client side each separate mount against a server counts as
> one, so if each client is mounting /opt and /home and /data and
> you have 100 machines you need at least 300.
>
Are you suggesting in such a scenario we would need 300 nfsd?

> The solution that I came to was to use UDP mounts, as this limit
> is not there.   In the situation I had we would have had to change
> the number of nfsd to 256 and even that was going to be close,
> and the 256 caused some other failures.  To not have the issue you
> will need to use UDP mounts everywere if you have enough tcp mounts
> to cause the error it will affect the udp mounts in a similar bad way.
>
> We also could have changed the thread to resource count, but we had
> some other process starvation issue with TCP that seemed to not be
> duplicatable with UDP.

We had changed from UDP to TCP due to our network's propensity to drop
UDP packets.  The same mount options we are using now against a Linux 
server were working fine when our NFS server was a much-less-powerful SGI 
IRIX server.  No doubt, as you say, that switching back to UDP would
make this rpc-srv/tcp message go away.

Steve Timm



>
>                     Roger
>                     Atipa Technologies
>
>

-- 
------------------------------------------------------------------
Steven C. Timm, Ph.D  (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Div/Core Support Services Dept./Scientific Computing Section
Assistant Group Leader, Farms and Clustered Systems Group
Lead of Computing Farms Team
