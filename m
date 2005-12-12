Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbVLLU6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbVLLU6z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbVLLU6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:58:55 -0500
Received: from jade.aracnet.com ([216.99.193.136]:22205 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S1751255AbVLLU6y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:58:54 -0500
Message-ID: <439DE488.7040703@BitWagon.com>
Date: Mon, 12 Dec 2005 12:58:48 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: control placement of vDSO page
References: <439D9767.2000208@BitWagon.com> <200512122039.29799.ioe-lkml@rameria.de>
In-Reply-To: <200512122039.29799.ioe-lkml@rameria.de>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> On Monday 12 December 2005 16:29, John Reiser wrote:
> 
>>Possible solution: a new system call  move_vdso(old_addr, new_addr, flags).
>>Check that current vDSO was at old_addr, else error.  Change vDSO page
>>under control of flags like in mmap(): new_addr is hint (place to start
>>search) or required address if MAP_FIXED.  Return value is new vDSO address.
>>
> 
> 
> What about special casing the vDSO page in mremap() ?

Hmmm...  Where can the new address [hint] be given in the call to
mremap(old_address, old_size, new_size, flags) ?
Also: probably the size is constant, perhaps even unknown to the user.
It would be nice if the old page need not exist (could have been
mmap()ed over) at the time of the move, although the proposed
move_vdso() does ask for what the old_addr used to be, as a check
on validity.

-- 
John Reiser, jreiser@BitWagon.com
