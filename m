Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWHJVAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWHJVAX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 17:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWHJVAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 17:00:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50889 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932254AbWHJVAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 17:00:19 -0400
Message-ID: <44DB9E5E.3000207@redhat.com>
Date: Thu, 10 Aug 2006 17:00:14 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060726)
MIME-Version: 1.0
To: Xin Zhao <uszhaoxin@gmail.com>
CC: Matthew Wilcox <matthew@wil.cx>, Neil Brown <neilb@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: Urgent help needed on an NFS question, please help!!!
References: <4ae3c140608092204n1c07152k52010a10e209bb77@mail.gmail.com>	 <17626.49136.384370.284757@cse.unsw.edu.au>	 <4ae3c140608092254k62dce9at2e8cdcc9ae7a6d9f@mail.gmail.com>	 <17626.52269.828274.831029@cse.unsw.edu.au>	 <4ae3c140608100815p57c0378kfd316a482738ee83@mail.gmail.com>	 <20060810161107.GC4379@parisc-linux.org> <4ae3c140608100923j1ffb5bb5qa776bff79365874c@mail.gmail.com>
In-Reply-To: <4ae3c140608100923j1ffb5bb5qa776bff79365874c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xin Zhao wrote:
> That makes sense.
>
> Can we make the following two conclusions?
> 1. In a single machine, inode+dev ID+i_generation can uniquely 
> identify a file
> 2. Given a stored file handle and an inode object received from the
> server,  an NFS client can safely determine whether this inode
> corresponds to the file handle by checking the inode+dev+i_generation.
>

#1 seems to safe enough to assume.

#2 either doesn't make sense to me or is assuming things about the file 
handle
that the client is not allowed to assume.  A file handle is an opaque string
of bytes to the client.  The only entity allowed to interpret the contents
is the entity which generated the file handle.

---

Is this situation any different than an application opens file, "A".  
Another
process then renames "A" to "B".  Now, the original application is 
reading and
writing from and to a file called "B" and has no knowledge of this.

---

The bottom line is that the file handle uniquely identifies a particular
entity on a file system on the server.  The name of the entity does not
matter.

    Thanx...

       ps
