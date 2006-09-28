Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751763AbWI1HtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbWI1HtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 03:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWI1HtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 03:49:13 -0400
Received: from cantor2.suse.de ([195.135.220.15]:8856 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751757AbWI1HtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 03:49:12 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [BUG] Oops on boot (probably ACPI related)
Date: Thu, 28 Sep 2006 09:49:06 +0200
User-Agent: KMail/1.9.3
Cc: Kyle McMartin <kyle@parisc-linux.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, akpm@osdl.org, jbeulich@novell.com
References: <200609271424.47824.eike-kernel@sf-tec.de> <200609272250.21925.ak@suse.de> <Pine.LNX.4.64.0609271436310.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609271436310.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609280949.06676.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 23:38, Linus Torvalds wrote:
> 
> On Wed, 27 Sep 2006, Andi Kleen wrote:
> > 
> > It doesn't matter much because these days this stuff is all out of lined
> > anyways and in a single function. And the dynamic branch predictor
> > in all modern CPUs will usually cache the decision (unlocked) there.
> 
> Ahh, good point. Once there's only one copy, the branch predictor will get 
> it right (and the code size won't much matter)

As a postscript I (unintentionally) bended the truth on that one actually
yesterday. Sorry for that. Semaphores are still inline, unlike spinlocks.

However if the spinlocks are out of line I see no reason to keep semaphores
inline either, so perhaps it would be better to just move them. Then my
argument above would actually work :)

For some reason the unwinder also still seems to get stuck on it :/

-Andi
