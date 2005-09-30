Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbVI3QqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbVI3QqJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 12:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbVI3QqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 12:46:09 -0400
Received: from ns1.limegroup.com ([64.48.93.2]:30739 "EHLO ns1.limegroup.com")
	by vger.kernel.org with ESMTP id S1030368AbVI3QqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 12:46:07 -0400
Date: Fri, 30 Sep 2005 12:46:01 -0400 (EDT)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@ionlinux.tower-research.com
To: Hendrik Visage <hvjunk@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Starfire (Adaptec) kernel 2.6.13+ panics on AMD64 NFS server
In-Reply-To: <d93f04c70509300114i1757cde1x42d9fe7c453a8bbd@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0509301226140.13733@ionlinux.tower-research.com>
References: <d93f04c70509292036x269df799y7b51c5be9c3356d6@mail.gmail.com> 
 <20050929211649.69eaddee.akpm@osdl.org> <d93f04c70509300114i1757cde1x42d9fe7c453a8bbd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henrik,

On Fri, 30 Sep 2005, Hendrik Visage wrote:

> Will do, but check perhaps for some 64bit uncleanes in the scatter gather stuff
> that got enabled in 2.6.13 because of the GPL'd Adaptec firmware, as I
> recalled some skb related stuff.

There is an easy way to disable the firmware and pretty much all the 
changes that went into 2.6.13: load the starfire with enable_hw_cksum=0. 
If you can easily reproduce this problem, try doing the above and see if 
you can still hit it. Maybe it's a newly introduced problem in the upper 
layer's SG--your other network driver simply isn't using SG so it's 
not affected.

It's very suspicious that the bug would be in skb_checksum_help(), since 
the starfire driver doesn't do anything with the skb before handing it 
over to skb_checksum_help(). It would mean that the upper layer handed an 
invalid skb to the driver, or that we have some random memory corruption 
somewhere.

Thanks,
Ion

-- 
   It is better to keep your mouth shut and be thought a fool,
             than to open it and remove all doubt.
