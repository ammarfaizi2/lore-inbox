Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbUKJFFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbUKJFFl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 00:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUKJFFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 00:05:40 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:20622 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261883AbUKJFFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 00:05:31 -0500
Date: Wed, 10 Nov 2004 16:05:43 +1100 (EST)
From: Mark Goodwin <markgw@sgi.com>
X-X-Sender: markgw@woolami.melbourne.sgi.com
To: Matthew Dobson <colpatch@us.ibm.com>
cc: Erich Focht <efocht@hpce.nec.com>, Jack Steiner <steiner@sgi.com>,
       Takayoshi Kochi <t-kochi@bq.jp.nec.com>, linux-ia64@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Externalize SLIT table
In-Reply-To: <1100044724.3980.23.camel@arrakis>
Message-ID: <Pine.LNX.4.61.0411101532350.15897@woolami.melbourne.sgi.com>
References: <20041103205655.GA5084@sgi.com>  <20041104.105908.18574694.t-kochi@bq.jp.nec.com>
  <20041104141337.GA18445@sgi.com>  <200411041631.42627.efocht@hpce.nec.com>
  <1100029381.3980.12.camel@arrakis>  <Pine.LNX.4.61.0411100722070.14545@woolami.melbourne.sgi.com>
 <1100044724.3980.23.camel@arrakis>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Nov 2004, Matthew Dobson wrote:
> On Tue, 2004-11-09 at 12:34, Mark Goodwin wrote:
>> Once again however, it depends on the definition of distance. For nodes,
>> we've established it's the ACPI SLIT (relative distance to memory). For
>> cpus, should it be distance to memory? Distance to cache? Registers? Or
>> what?
>>
> That's the real issue.  We need to agree upon a meaningful definition of
> CPU-to-CPU "distance".  As Jesse mentioned in a follow-up, we can all
> agree on what Node-to-Node "distance" means, but there doesn't appear to
> be much consensus on what CPU "distance" means.

How about we define cpu-distance to be "relative distance to the
lowest level cache on another CPU". On a system that has nodes with
multiple sockets (each supporting multiple cores or HT "CPUs" sharing
some level of cache), when the scheduler needs to migrate a task it would
first choose a CPU sharing the same cache, then a CPU on the same node,
then an off-node CPU (i.e. falling back to node distance).

Of course, I have no idea if that's anything like an optimal or desirable
task migration policy. Probably depends on cache-trashiness of the task
being migrated.

-- Mark
