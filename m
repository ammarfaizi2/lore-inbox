Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbUCCCaI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 21:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbUCCCaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 21:30:07 -0500
Received: from terminus.zytor.com ([63.209.29.3]:23705 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262325AbUCCC3d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 21:29:33 -0500
Message-ID: <40454300.4080803@zytor.com>
Date: Tue, 02 Mar 2004 18:29:20 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: cloos@jhcloos.com, linux-kernel@vger.kernel.org
Subject: Re: something funny about tty's on 2.6.4-rc1-mm1
References: <20040301184512.GA21285@hobbes.itsari.int>	<c2175f$6hn$1@terminus.zytor.com>	<m3u1175miy.fsf@lugabout.jhcloos.org>	<4044BC48.7060903@zytor.com> <20040302140809.6b0ef6f8.akpm@osdl.org>
In-Reply-To: <20040302140809.6b0ef6f8.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "H. Peter Anvin" <hpa@zytor.com> wrote:
> 
>>>Will patching in the old behavior wrt re-use, while not disrupting
>>>the other improvements, be a lot of work?  I've looked thru the src, 
>>>but haven't yet spotted the point where the new pis number is chosen.
>>
>>Not a lot of work, but the performance would suffer big time.
> 
> The (untested) first-fit patch I proposed uses a radix tree, so it should
> in fact be faster than the old code.
> 
> Are you now thinking that we might need to change the pty allocator?
> 

I don't; I think this is a total joke.  The utmp issue is a more severe 
one; it might be reason to stick to the old behaviour at least for 2.6.

Linear scan of utmp and not removing entries on logout is clearly bad 
chicken.  Effectively utmp seems to be tied to the current structure, 
mostly because it tries to go beyond it -- it's so bad at doing so that 
it actually *causes* problems!

	-hpa
