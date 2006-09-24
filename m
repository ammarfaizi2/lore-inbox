Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752065AbWIXChX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbWIXChX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 22:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbWIXChX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 22:37:23 -0400
Received: from dvhart.com ([64.146.134.43]:11754 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1752065AbWIXChV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 22:37:21 -0400
Message-ID: <4515EF28.9000805@mbligh.org>
Date: Sat, 23 Sep 2006 19:36:24 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@google.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
Subject: Re: More thoughts on getting rid of ZONE_DMA
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com> <4514441E.70207@mbligh.org> <Pine.LNX.4.64.0609221321280.9181@schroedinger.engr.sgi.com> <200609230134.45355.ak@suse.de> <Pine.LNX.4.64.0609231907360.16435@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609231907360.16435@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Sat, 23 Sep 2006, Andi Kleen wrote:
> 
>> The problem is that if someone has a workload with lots of pinned pages
>> (e.g. lots of mlock) then the first 16MB might fill up completely and there 
>> is no chance at all to free it because it's pinned
> 
> Note that mlock'ed pages are movable. mlock only specifies that pages
> must stay in memory. It does not say that they cannot be moved. So
> page migration could help there.
> 
> This brings up a possible problem spot in the current kernel: It seems 
> that the VM is capable of migrating pages from ZONE_DMA to 
> ZONE_NORMAL! So once pages are in memory then they may move out of the 
> DMA-able area.
> 
> I assume the writeback paths have some means of detecting that a
> page is out of range during writeback and then do page bouncing?
> 
> If that is the case then we could simply move movable pages out
> if necessary. That would be a kind of bouncing logic there that
> would only kick in if necessary.

If it's the 16MB DMA window for ia32 we're talking about, wouldn't
it be easier just to remove it from the fallback lists? (assuming
you have at least 128MB of memory or something, blah, blah). Saves
doing migration later.

M.

