Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318194AbSHZWcT>; Mon, 26 Aug 2002 18:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318236AbSHZWcS>; Mon, 26 Aug 2002 18:32:18 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:63174 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S318194AbSHZWcS>; Mon, 26 Aug 2002 18:32:18 -0400
Message-ID: <3D6AACB7.4030506@quark.didntduck.org>
Date: Mon, 26 Aug 2002 18:33:27 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make raid5 checksums preempt-safe
References: <1030392363.905.418.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> Linus,
> 
> The raid5 xor checksums use MMX/SSE state and are not preempt-safe.
> 
> Attached patch disables preemption in FPU_SAVE and XMMS_SAVE and
> restores it in FPU_RESTORE and XMMS_RESTORE - preventing preemption
> while in fp mode.
> 
> Please, apply.
> 
> 	Robert Love

Use kernel_fpu_begin() and kernel_fpu_end() instead of reinventing the 
wheel.  The current code is broken wrt SSE as well.

--
				Brian Gerst


