Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030489AbWFJSP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030489AbWFJSP0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 14:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030490AbWFJSP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 14:15:26 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:11217 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030489AbWFJSPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 14:15:25 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <448B0B82.8000202@s5r6.in-berlin.de>
Date: Sat, 10 Jun 2006 20:12:18 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Ben Collins <bcollins@ubuntu.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       weihs@ict.tuwien.ac.at, linux1394-devel@lists.sourceforge.net,
       bcollins@debian.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kthread conversion: convert ieee1394 from kernel_thread
References: <20060610143100.GA15536@sergelap.austin.ibm.com> <20060610144205.GA13850@infradead.org> <448AE12E.5060002@s5r6.in-berlin.de> <20060610154213.GA19077@infradead.org> <1149957286.4448.542.camel@grayson> <20060610163859.GA24081@infradead.org>
In-Reply-To: <20060610163859.GA24081@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.045) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sat, Jun 10, 2006 at 12:34:46PM -0400, Ben Collins wrote:
>>1394 bus rescanning takes a _lot_ longer than a PCI rescan. If we don't
>>do this in a kthread, then we have to do it as a tasklet, and take a
>>chance of stalling for a few seconds (not ms), preventing other
>>tasklet's from running. Suboptimal, IMO.
> 
> This is just user-initiated FC rescans.  And I doubt they take as long
> as parallel scsi rescans which can go into the minutes range easily.
> Nothing will be stalled by calling this except the caller, which would
> usually be echo called from some shell, something the user can put in
> the background using job control.

There is no such userspace caller yet.

Note, the task of nodemgr, or of a hypothetical userspace replacement, 
is not only to scan the ROMs of nodes and initiate attachment of 
protocol drivers but also
  - to rescan the ROMs of nodes after bus resets (necessary for protocol
    drivers to reconnect, which has restrictions WRT latency),
  - IEEE 1394 bus management (which has hard latency restrictions too).
We also started using nodemgr to determine the correct speed at which 
IEEE 1394b nodes can be reached, i.e. for fairly low-level tasks. And 
there are further plans for nodemgr like optimization of bus arbitration 
gaps, or parallelized node scanning.

I am not sure that this can really be loaded off to userspace. And if we 
would do so, deployment would become painful.
-- 
Stefan Richter
-=====-=-==- -==- -=-=-
http://arcgraph.de/sr/
