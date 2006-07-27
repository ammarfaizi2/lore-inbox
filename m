Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751756AbWG0Xok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbWG0Xok (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 19:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWG0Xoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 19:44:39 -0400
Received: from styx.suse.cz ([82.119.242.94]:41425 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751756AbWG0Xoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 19:44:39 -0400
Date: Fri, 28 Jul 2006 01:44:23 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
Subject: Re: [RFC/RFT] Remove polling timer from i8042
Message-ID: <20060727234423.GC4907@suse.cz>
References: <200607270029.05066.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607270029.05066.dtor@insightbb.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 12:29:04AM -0400, Dmitry Torokhov wrote:
> Hi,
> 
> OK, I had it in works for quite some time and Dave's talk in Ottawa
> made me finish it ;)

Good work.

However I believe you need to test the AUX IRQ in this case before you
use it, otherwise you'll have a lot of people with non-working keyboards
(the input queue is shared), and probably also non-working PCI cards
(BIOSes like to assign IRQ12 to PCI if no mouse is detected by the
BIOS).

You'll see whether this test is necessary if a lot of people report
problems without i8042.noaux.

That can only be seen after extensive testing on a lot of machines,
though. Fortunately 386's and 486's are more or less extinct now, and
with them a lot of the weirder keyboard controllers.

Btw, on standard x86, the AUX and KBD IRQs cannot be shared.

> -- 
> Dmitry
> 
> Input: i8042 - get rid of polling timer
> 
> Remove polling timer that was used to detect keybord/mice hotplug and
> register both IRQs right away instead of waiting for a driver to
> attach to a port. If mouse is really missing and IRQ can be used for
> something else user can boot with i8042.noaux. 

-- 
Vojtech Pavlik
Director SuSE Labs
