Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269190AbUINHt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269190AbUINHt7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 03:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269191AbUINHt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 03:49:59 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:59917 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S269190AbUINHtz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 03:49:55 -0400
Message-ID: <4146A228.3080705@snapgear.com>
Date: Tue, 14 Sep 2004 17:47:52 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sf.net>, Andrew Morton OSDL <akpm@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>, Roger Luethi <rl@hellgate.ch>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
References: <20040908184028.GA10840@k3.hellgate.ch> <20040908184130.GA12691@k3.hellgate.ch> <20040909003529.GI3106@holomorphy.com> <20040909184300.GA28278@k3.hellgate.ch> <20040909184933.GG3106@holomorphy.com> <20040909191142.GA30151@k3.hellgate.ch> <1094941556.1173.12.camel@cube> <20040914055946.GA20929@k3.hellgate.ch> <20040914061800.GD9106@holomorphy.com> <20040914062307.GF9106@holomorphy.com>
In-Reply-To: <20040914062307.GF9106@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William, Roger,

William Lee Irwin III wrote:
> Greg, could you comment on this since there are some people having
> trouble figuring out what's going on with VM-related /proc/ fields for
> !CONFIG_MMU. Please forgive the top-posting, it made more sense to
> quote the text below in this instance.

Yeah, the !CONFIG_MMU code behind this is probably a little stale.
The thinking has mostly been to keep things as much the same as
possible, even if the fields didn't have a sensible meaning in
non-mmu space.


> On Tue, Sep 14, 2004 at 07:59:46AM +0200, Roger Luethi wrote:
> 
>>>I agree with you that those specific fields should be offered for
>>>!CONFIG_MMU. However, if for some reason they cannot carry a value
>>>that fits the field description, they should not be offered at all. The
>>>ambiguity of having 0 mean either "0" or "this field is not available"
>>>is bad. Trying to read a specific field _can_ fail, and applications
>>>had better handle that case (it's still trivial compared to having to
>>>parse different /proc file layouts depending on the configuration).

In at least one case this is true now, as you mention for the
VmXxx fields. But looking at these now I think we could actually
implement most of them in a sensible way for the no-mmu case.
Size, Exe, Lib, Stk, etc  all apply with their conventional
meanings.


> On Mon, Sep 13, 2004 at 11:18:00PM -0700, William Lee Irwin III wrote:
> 
>>Apart from doing something it's supposed to for !CONFIG_MMU and using
>>the internal kernel accounting I set up for the CONFIG_MMU=y case I'm
>>not very concerned about this. I have a vague notion there should
>>probably be some consistency with the /proc/ precedent but am not
>>particularly tied to it. We should probably ask Greg Ungerer (the
>>maintainer of the external MMU-less patches) about what he prefers
>>since it's likely we can't anticipate all of the !CONFIG_MMU concerns.
> 
> 
> On Tue, Sep 14, 2004 at 07:59:46AM +0200, Roger Luethi wrote:
> 
>>>The presumed wrong assumptions underlying broken tools of the future
>>>are not a good base for designing a new interface. My interest is in
>>>making it easy to write correct applications (or in fixing broken apps
>>>that won't work, say, on !CONFIG_MMU systems).

Reality for non-mmu targets is that most apps just won't be fixed
for them, so we try real hard to make the world look like it is
just like any other linux architecture.

I think !CONFIG_MMU case can be cleaned up to make it almost identical
to the CONFIG_MMU case, and reporting sensible values for just about
all fields.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
