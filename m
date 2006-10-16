Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422722AbWJPMfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422722AbWJPMfu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 08:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422723AbWJPMfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 08:35:50 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:29928 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1422722AbWJPMft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 08:35:49 -0400
Message-Id: <4533991C.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 16 Oct 2006 14:37:16 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Jiri Kosina" <jikos@jikos.cz>, "Andi Kleen" <ak@suse.de>
Cc: "Peter Zijlstra" <a.p.zijlstra@chello.nl>, "Ingo Molnar" <mingo@elte.hu>,
       "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, <khali@linux-fr.org>,
       <v4l-dvb-maintainer@linuxtv.org>, <i2c@lm-sensors.org>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: dwarf2 stuck Re: lockdep warning in i2c_transfer() with
	dibx000 DVB - input tree merge plans?
References: <Pine.LNX.4.64.0610121521390.29022@twin.jikos.cz>
 <200610161231.30705.ak@suse.de>
In-Reply-To: <200610161231.30705.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> stack backtrace:
>> [<c0103b69>] dump_trace+0x65/0x1a2
>> [<c0103cb6>] show_trace_log_lvl+0x10/0x20
>> [<c0103f84>] show_trace+0xa/0xc
>> [<c0103f99>] dump_stack+0x13/0x15
>> [<c0132ea4>] __lock_acquire+0x7bd/0xa05
>> [<c01333c1>] lock_acquire+0x5c/0x7b
>> [<c034b683>] __mutex_lock_slowpath+0xab/0x1de
>> [<f8902177>] i2c_transfer+0x23/0x40 [i2c_core]
>> [<f88fa1bf>] dibx000_i2c_gated_tuner_xfer+0x166/0x185 [dibx000_common]
>> [<f8902183>] i2c_transfer+0x2f/0x40 [i2c_core]
>> [<f891f04b>] mt2060_readreg+0x4b/0x69 [mt2060]
>> [<f891f45e>] mt2060_attach+0x40/0x1ea [mt2060]
>> [<f895f468>] dibusb_dib3000mc_tuner_attach+0x126/0x16c 
>> [dvb_usb_dibusb_common]
>> [<d10ea000>] 0xd10ea000
>> DWARF2 unwinder stuck at 0xd10ea000
>
>Hmm, no assembly code or anything. Jan, do you have any ideas?
>This looks just like a simple callback that goes over a module
>boundary.

No, except if this was compiled with gcc 4.0.x (or maybe earlier), in which
case inspection of the unwind data might be needed to tell if it's one of the
mis-generated cases that we saw earlier.

Again - a stack trace alone (as above) will never be likely to yield anything,
raw stack data and in some (most?) cases the relevant unwind data are also
needed.

Jan
