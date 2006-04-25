Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbWDYTBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWDYTBI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 15:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWDYTBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 15:01:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:4543 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751497AbWDYTBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 15:01:06 -0400
Subject: Re: [PATCH 3/3] Assert notifier_block and notifier_call are not in
	init section
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <Pine.LNX.4.64.0604241945570.3701@g5.osdl.org>
References: <20060425023509.7529.84752.sendpatchset@localhost.localdomain>
	 <20060425023527.7529.9096.sendpatchset@localhost.localdomain>
	 <Pine.LNX.4.64.0604241945570.3701@g5.osdl.org>
Content-Type: text/plain
Organization: IBM
Date: Tue, 25 Apr 2006 12:01:03 -0700
Message-Id: <1145991663.16539.8.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 19:47 -0700, Linus Torvalds wrote:
> 
> On Mon, 24 Apr 2006, sekharan@us.ibm.com wrote:
> > 
> > 	Feel free to drop this patch if you think it is not needed.
> 
> It's incorrect.
> 
> The init section will be free'd, and as a result can be re-allocated to 
> other uses. Thus testing that data is not in the init-section makes no 
> sense.
>
> Testing for _code_ not being in the init section can be sensible, since 
> code never gets re-allocated (modulo module code, but that's never in the 
> init section). So checking the "notifier_call" part may be sensible, but 
> checking the notifier block data pointer definitely is not.

Two questions:
1) related to this patch: Do you want me to generate a patch that
asserts only notifier calls ?

2) Unrelated to this patch: If the _code_ section is never reallocated
or reused, what is the purpose of putting _code_ in the init section ?
Only to make sure that the init calls are called in order ?

Thanks

chandra
PS: I fixed my mailer to put my name. sorry about that.

> 
> Patches 1-2 applied.
> 
> 		Linus
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


