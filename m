Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbUJZXPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbUJZXPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 19:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbUJZXPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 19:15:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:15331 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261534AbUJZXPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 19:15:03 -0400
Date: Tue, 26 Oct 2004 16:15:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Zachary Amsden <zach@vmware.com>
cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, hpa@zytor.com
Subject: Re: [PATCH] faster signal handling on x86
In-Reply-To: <417EC7BA.3050604@vmware.com>
Message-ID: <Pine.LNX.4.58.0410261610380.28839@ppc970.osdl.org>
References: <417EC7BA.3050604@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Oct 2004, Zachary Amsden wrote:
>
> I noticed an unneeded write to dr7 in the signal handling path for x86.  
> We only need to write to dr7 if there is a breakpoint to re-enable, and 
> MOVDR is a serializing instruction, which is expensive.  Getting rid of 
> it gets a 33% faster signal delivery path (at least on Xeon - I didn't 
> test other CPUs, so your gain may vary).

I'm suprised it is _that_ slow, but sure, no problem, the patch just makes 
it match all the other paths. 

I suspect Xeon is alone in being _that_ slow - I bet Netburst flushes the 
whole trace cache on db7 writes.

		Linus
