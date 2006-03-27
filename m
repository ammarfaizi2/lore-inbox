Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWC0Lgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWC0Lgt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 06:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWC0Lgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 06:36:49 -0500
Received: from [195.23.16.24] ([195.23.16.24]:62855 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1750907AbWC0Lgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 06:36:49 -0500
Message-ID: <4427CE4D.5010109@grupopie.com>
Date: Mon, 27 Mar 2006 12:36:45 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linda Walsh <lkml@tlinx.org>
CC: Adrian Bunk <bunk@stusta.de>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Save 320K on production machines?
References: <4426515B.5040307@tlinx.org> <Pine.LNX.4.61.0603261122410.22145@yvahk01.tjqt.qr> <20060326100639.GE4053@stusta.de> <4427BCCC.4080506@tlinx.org>
In-Reply-To: <4427BCCC.4080506@tlinx.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linda Walsh wrote:
> [...]
> The current makefile turns on the optimization only on gcc4 or higher,
> but my results were with gcc3.5.5.  Maybe defaults for 386 should
> enabler the optimization for some versions of gcc 3 as well?  -l

AFAICR, the problem with gcc3 and unit-at-a-time was stack usage with 
local variables on automatically inlined functions.

For instance, if function A called B and after B returned called C, both 
local variables of B and C would be given a reserved space on the stack 
during the execution of A if both functions were automatically inlined. 
So the space needed now was A+B+C whereas before was Max(A+B, A+C).

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?
