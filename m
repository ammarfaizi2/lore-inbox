Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVA1BHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVA1BHJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 20:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVA1BHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 20:07:09 -0500
Received: from terminus.zytor.com ([209.128.68.124]:48353 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261354AbVA1BHC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 20:07:02 -0500
Message-ID: <41F9902D.8000607@zytor.com>
Date: Thu, 27 Jan 2005 17:06:53 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050127101117.GA9760@infradead.org>	<20050127101322.GE9760@infradead.org>	<41F94462.7080108@francetelecom.REMOVE.com>	<ctbvtf$305$1@terminus.zytor.com> <52u0p2wger.fsf@topspin.com>
In-Reply-To: <52u0p2wger.fsf@topspin.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Julien> Not very important but ((get_random_int() % 4096) << 4)
>     Julien> could be optimized into get_random_int() & 0xFFF0.
> 
>     HPA> .. and gcc knows that.
> 
>     HPA>    8:   25 ff 0f 00 00          and    $0xfff,%eax
>     HPA>    d:   83 c4 0c                add    $0xc,%esp
>     HPA>   10:   c1 e0 04                shl    $0x4,%eax
> 
> Actually gcc isn't quite that smart (since it obviously can't
> understand the semantics of get_random int()).  The original point was
> that the "shl $0x4" can be avoided by directly &'ing with 0xfff0, not
> that "% 4096" can be strength reduced to "& 0xfff".
> 

Oh, right.  D'oh!  :)

	-hpa

