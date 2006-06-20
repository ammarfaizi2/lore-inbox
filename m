Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbWFTGPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbWFTGPe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 02:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWFTGPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 02:15:34 -0400
Received: from fc-cn.com ([218.25.172.144]:58376 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S965073AbWFTGPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 02:15:33 -0400
Message-ID: <4497927F.4070307@fc-cn.com>
Date: Tue, 20 Jun 2006 14:15:27 +0800
From: Qi Yong <qiyong@fc-cn.com>
Organization: FCD
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja-JP; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "Stephen C. Tweedie" <sct@redhat.com>, Jeff Garzik <jeff@garzik.org>,
       Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mingming Cao <cmm@us.ibm.com>, linux-fsdevel@vger.kernel.org,
       alex@clusterfs.com
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>  <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>  <44898EE3.6080903@garzik.org> <1149885135.5776.100.camel@sisko.sctweedie.blueyonder.co.uk> <Pine.LNX.4.64.0606091344290.5498@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606091344290.5498@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Fri, 9 Jun 2006, Stephen C. Tweedie wrote:
>  
>
>>When is the Linux syscall interface enough?  When should we just bump it
>>and cut out all the compatibility interfaces?
>>
>>No, we don't; we let people configure certain obsolete bits out (a.out
>>support etc), but we keep it in the tree despite the indirection cost to
>>maintain multiple interfaces etc.
>>    
>>
>
>Right. WE ADD NEW SYSTEM CALLS. WE DO NOT EXTEND THE OLD ONES IN WAYS THAT 
>MIGHT BREAK OLD USERS.
>
>Your point was exactly what?
>
>Btw, where did that 2TB limit number come from? Afaik, it should be 16TB 
>for a 4kB filesystem, no?
>  
>

Partition tables describe partitions in units of one sector.
2^(32+9) = 2T

To prevent integer overflow, we should use only 31 bits of a 32-bit integer.
2^(31+12) = 8T

There's _terrible_ hacks to really get to 16T.

-- qiyong
