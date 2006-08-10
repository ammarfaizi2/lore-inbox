Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161223AbWHJMam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbWHJMam (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161222AbWHJMal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:30:41 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:39363 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1161223AbWHJMaj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:30:39 -0400
Message-ID: <44DB262D.2080902@aitel.hist.no>
Date: Thu, 10 Aug 2006 14:27:25 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Valerie Henson <val_henson@linux.intel.com>
CC: Arjan van de Ven <arjan@linux.intel.com>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Akkana Peck <akkana@shallowsky.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Jesse Barnes <jesse.barnes@intel.com>, Chris Wedgwood <cw@f00f.org>,
       jsipek@cs.sunysb.edu, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] [PATCH] Relative lazy atime
References: <20060803063622.GB8631@goober> <20060805122537.GA23239@lst.de> <44D49BAA.6050501@linux.intel.com> <20060809140349.GE13474@goober>
In-Reply-To: <20060809140349.GE13474@goober>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valerie Henson wrote:
> On Sat, Aug 05, 2006 at 06:22:50AM -0700, Arjan van de Ven wrote:
>   
>> Christoph Hellwig wrote:
>>     
>>> Another idea, similar to how atime updates work in xfs currently might
>>> be interesting:  Always update atime in core, but don't start a
>>> transaction just for it - instead only flush it when you'd do it anyway,
>>> that is another transaction or evicting the inode.
>>>       
>> this is sort of having a "dirty" and "dirty atime" split for the inode I 
>> suppose..
>> shouldn't be impossible to do with a bit of vfs support..
>>     
>
> This is certainly another possibility.  There may be other uses for
> the idea of a half-dirty inode.
>
> However, one thing I want to avoid is an event that would cause the
> build-up and subsequent write-out of a big list of half-dirty inodes -
> think about the worst case: grep -r of the entire file system,
> followed by some kind of memory pressure or an unmount.  Would we then
> flush out a write to every inode in the file system?  Ew. (This is
> worse than having atime on because with full atime, the writes would
> be spread out during the execution of the grep -r command.)
>   
An unmount will flush out anything that is dirty anyway.  Memory
pressure is easier, it usually don't have to flush everything,
only enough to satisfy the memory requests.

Of course you can have some mechanism that trickles out writes
of half-dirty stuff.  Similiar to how dirty stuff is flushed, but with
a much lower frequency.

Helge Hafting

