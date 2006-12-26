Return-Path: <linux-kernel-owner+w=401wt.eu-S932764AbWLZTQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932764AbWLZTQU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 14:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWLZTQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 14:16:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40192 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932761AbWLZTQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 14:16:19 -0500
Message-ID: <459174FB.3050107@redhat.com>
Date: Tue, 26 Dec 2006 14:16:11 -0500
From: Jeff Layton <jlayton@redhat.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: =?UTF-8?B?SsO2cm4gRW5nZWw=?= <joern@lazybastard.org>,
       Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] ensure unique i_ino in filesystems without permanent
 inode numbers (introduction)
References: <457891E7.10902@redhat.com> <45829D94.1090304@redhat.com> <20061215140057.GF30508@lazybastard.org> <4582B8AF.9060707@redhat.com>
In-Reply-To: <4582B8AF.9060707@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton wrote:
 >  >
 >  > I'm still unsure whether idr has a sufficient advantage over simply
 >  > hashing the inodes.  Hch has suggested that keeping the hashtable
 >  > smaller is good for performance.  But idr adds new complexity, which
 >  > should be avoided on its own right.  So is the performance benefit big
 >  > enough to add more complexity?  Is it even measurable?
 >  >
 >  > Jörn
 >  >
 >
 >
 > A very good question. Certainly, just hashing them would be a heck of a
 > lot simpler. That was my first inclination when I looked at this, but as
 > you said, HCH NAK'ed that idea stating that it would bloat out the
 > hashtable. I tend to think that it's probably not that significant, but
 > that might very much depend on workload.
 >
 > I'm OK with either approach, though I'd like to have some sort of buyin
 > from Christoph on hashing the inodes before I start working on patches to
 > do that.
 >
 > Christoph, care to comment?
 >
 > -- Jeff
 >
 >

I'm still in limbo on this patchset and could use some guidance. It's not
clear to me that IDR is really a big enough win over just hashing the inodes.
It seems like the inode hash is pretty well optimized for fast lookups such
that even if we get some extra hash collisions it shouldn't be too awful.

Perhaps the best thing to do is to start with a patch that just hashes the
inodes and then fall back to using IDR (or some other scheme) if it turns out
that it impacts performance too much?

Anyone have an opinion on what approach they think would be best here?

-- Jeff

