Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUCQVf5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 16:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbUCQVf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 16:35:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3011 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262078AbUCQVfv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 16:35:51 -0500
Message-ID: <4058C4A8.5040304@pobox.com>
Date: Wed, 17 Mar 2004 16:35:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Scott Long <scott_long@adaptec.com>
CC: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-raid@vger.kernel.org,
       "Gibbs, Justin" <justin_gibbs@adaptec.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: "Enhanced" MD code avaible for review
References: <459805408.1079547261@aslan.scsiguy.com> <4058A481.3020505@pobox.com> <4058C089.9060603@adaptec.com>
In-Reply-To: <4058C089.9060603@adaptec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Long wrote:
> Jeff Garzik wrote:
>> Modulo what I said above, about the chrdev userland interface, we want
>> to avoid this.  You're already going down the wrong road by creating
>> more untyped interfaces...
>>
>> static int raid0_raidop(mdk_member_t *member, int op, void *arg)
>> {
>>          switch (op) {
>>          case MDK_RAID_OP_MSTATE_CHANGED:
>>
>> The preferred model is to create a single marshalling module (a la
>> net/core/ethtool.c) that converts the ioctls we must support into a
>> fully typed function call interface (a la struct ethtool_ops).
>>
> 
> These OPS don't exist soley for the userland ap.  They also exist for
> communicating between the raid transform and metadata modules.

Nod -- kernel internal calls should _especially_ be type-explicit, not 
typeless ioctl-like APIs.


>> One overall comment on merging into 2.6:  the patch will need to be
>> broken up into pieces.  It's OK if each piece is dependent on the prior
>> one, and it's OK if there are 20, 30, even 100 pieces.  It helps a lot
>> for review to see the evolution, and it also helps flush out problems
>> you might not have even noticed.  e.g.
>>         - add concept of member, and related helper functions
>>         - use member functions/structs in raid drivers raid0.c, etc.
>>         - fix raid0 transform
>>         - add ioctls needed in order for DDF to be useful
>>         - add DDF format
>>         etc.
>>
> 
> We can provide our Perforce changelogs (just like we do for SCSI).

What I'm saying is, emd needs to be submitted to the kernel just like 
Neil Brown submits patches to Andrew, etc.  This is how everybody else 
submits and maintains Linux kernel code.  There needs to be N patches, 
one patch per email, that successively introduces new code, or modifies 
existing code.

Absent of all other issues, one huge patch that completely updates md 
isn't going to be acceptable, no matter how nifty or well-tested it is...

	Jeff



