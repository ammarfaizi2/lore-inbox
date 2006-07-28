Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbWG1N1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbWG1N1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 09:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbWG1N1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 09:27:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21709 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161079AbWG1N1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 09:27:48 -0400
Message-ID: <44CA10A5.3030209@redhat.com>
Date: Fri, 28 Jul 2006 09:27:01 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Eric Sandeen <sandeen@sandeen.net>, Neil Brown <neilb@suse.de>,
       Andrew Morton <akpm@osdl.org>, Theodore Tso <tytso@mit.edu>,
       jack@suse.cz, 20@madingley.org, marcel@holtmann.org,
       linux-kernel@vger.kernel.org, sct@redhat.com, adilger@clusterfs.com
Subject: Re: Bad ext3/nfs DoS bug
References: <17599.2754.962927.627515@cse.unsw.edu.au> <20060720160639.GF25111@atrey.karlin.mff.cuni.cz> <17600.30372.397971.955987@cse.unsw.edu.au> <20060721170627.4cbea27d.akpm@osdl.org> <20060722131759.GC7321@thunk.org> <20060724185604.9181714c.akpm@osdl.org> <17605.32781.909741.310735@cse.unsw.edu.au> <44C7A272.8030401@sandeen.net> <17608.96.409298.126686@cse.unsw.edu.au> <44C906CB.8050100@sandeen.net> <20060727191247.GA29166@infradead.org>
In-Reply-To: <20060727191247.GA29166@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Thu, Jul 27, 2006 at 01:32:43PM -0500, Eric Sandeen wrote:
>  
>
>>Neil Brown wrote:
>>    
>>
>>>On Wednesday July 26, sandeen@sandeen.net wrote:
>>>      
>>>
>>>>Hm, with this, ext3.ko has a new dependency on exportfs.ko.  Is that 
>>>>desirable/acceptable?
>>>>        
>>>>
>>>Drat, you're right.
>>>No, I don't think that is what we want.
>>>I'll do it differently in a day or so.
>>>      
>>>
>>Would moving export_iget into fs/inode.c & exporting it from there be a 
>>reasonable way to go?  At least ext2 & ext3 both have this need (prevent 
>>nfs access to special inodes) so putting the bulk of what they need for 
>>get_dentry (i.e. export_iget) somewhere common seems like a decent 
>>option to me.
>>    
>>
>
>Nope.  The right fix is to not make ext2/3 rely on export_iget at all. Please
>implement the proper export_operations instead, similar to e.g. xfs. 
>
>export_iget is a horrible layering violation that needs to go away long-term,
>not move into core code.
>

Since export_iget() doesn't actually involve any code which has anything to
do with the NFS server exports data structures, what exactly is the 
objection?
Is it truly better to duplicate code than to use a common routine which
can be documented?

    Thanx...

       ps
