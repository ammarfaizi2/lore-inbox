Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUBLKkX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 05:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266330AbUBLKkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 05:40:22 -0500
Received: from columba.eur.3com.com ([161.71.171.238]:44799 "EHLO
	columba.eur.3com.com") by vger.kernel.org with ESMTP
	id S266324AbUBLKkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 05:40:18 -0500
Message-ID: <402B580E.3000404@jburgess.uklinux.net>
Date: Thu, 12 Feb 2004 10:40:14 +0000
From: Jon Burgess <lkml@jburgess.uklinux.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Jon Burgess <lkml@jburgess.uklinux.net>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interleaved
 writes
References: <Pine.LNX.4.44.0402111528140.23220-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0402111528140.23220-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> Just for fun, could you also try measuring how long it takes
> to read back the files in question ?
>
> Both individually and in parallel...
>
The original code did the read back as well, I stripped it out to make 
the code smaller to post.
It was the read back performance that I was most interested in. I found 
that ext2/3 interleave all the blocks on the disk. With 2 stream the 
read performance is 50%, 4 streams give 25% etc.

I have one really bad case where I record a TV stream at 500kByte/s + a 
radio one at 25kByte/s. These blocks are interleaved on the disk and the 
read performance of the radio stream is reduced by the data ratio, i.e. 
1:20, so I get a miserable read performance of ~ 1MB/s.

I found that ext2, ext3 and Reiserfs behave similarly. XFS and JFS 
appear to coalesce the data blocks during the write phase and can read 
the data back at near maximum performance.

    Jon

