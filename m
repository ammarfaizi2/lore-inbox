Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161522AbWKES5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161522AbWKES5u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 13:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161523AbWKES5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 13:57:50 -0500
Received: from mx1.suse.de ([195.135.220.2]:7317 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161522AbWKES5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 13:57:49 -0500
From: Andi Kleen <ak@suse.de>
To: caglar@pardus.org.tr
Subject: Re: [Opps] Invalid opcode
Date: Sun, 5 Nov 2006 19:57:45 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Zachary Amsden <zach@vmware.com>,
       Gerd Hoffmann <kraxel@suse.de>, john stultz <johnstul@us.ibm.com>
References: <200611051507.37196.caglar@pardus.org.tr> <200611051740.47191.ak@suse.de> <200611051917.56971.caglar@pardus.org.tr>
In-Reply-To: <200611051917.56971.caglar@pardus.org.tr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200611051957.45260.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 November 2006 18:17, S.Çağlar Onur wrote:
> 05 Kas 2006 Paz 18:40 tarihinde, Andi Kleen şunları yazmıştı: 
> > How do you know this?
> 
> Just guessing, if im not wrong panics occur after SMP alternative switching 
> code done its job.

Can you test with "noreplacement" to make sure?

Anyways I suspect we're just getting back some variant of the old CPU setup race. 

Normally CPU booting in Linux follows a special "cpu hotplug" state machine,
but for historical reasons i386 only implements one state of  this. At one
point we had a similar bug (but not in the callback on CPU #0, but in
the timer on newly booted CPU). I don't see currently how it can happen
(but i haven't thought very deeply about it yet)

Probably your timing is just unlucky on those simulators.

Previously we avoided converting i386 cpu bootup fully to the new state 
machine because it is very fragile, but it's possible that there
is no other choice than to do it properly. Or maybe another kludge
is possible.

-Andi
