Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbTIULGd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 07:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTIULGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 07:06:33 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:39309 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262377AbTIULGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 07:06:32 -0400
Date: Sun, 21 Sep 2003 13:06:29 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Norman Diamond <ndiamond@wta.att.ne.jp>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.0-test5 vs. Japanese keyboards [3]
Message-ID: <20030921110629.GC18677@ucw.cz>
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60> <20030914122034.C3371@pclin040.win.tue.nl> <206701c37ab2$6a8033e0$2dee4ca5@DIAMONDLX60> <20030916154305.A1583@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030916154305.A1583@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 03:43:05PM +0200, Andries Brouwer wrote:
 
> I do not think his patch is needed.
> 
> So the question arises: do we need a kernel patch, and if so, what patch?
> The program loadkeys exists to load the kernel keymap with the map the user
> desires. So, if you need some particular map the obvious answer is:
> "use loadkeys".
> 
> There is a small snag - until 2.4 the value of NR_KEYS was 128,
> while 2.6 uses 256. Moreover, the keys you want to change are above 128.
> So, your old precompiled loadkeys will not do - you must recompile the
> kbd package against 2.6 kernel headers, or just edit loadkeys.y and dumpkeys.c
> inserting
> 
> #undef NR_KEYS
> #define NR_KEYS 256
> 
> after all includes, and then compile on any Linux machine.
> 
> There is no need to have knowledge of the Japanese keymap in the kernel,
> just as there is no knowledge of the German or French keymap. That
> knowledge belongs in the keymap that one loads.

There is a slight problem, and that is that NR_KEYS is (KEY_MAX+1) in
recent 2.6's and that's 512. And that doesn't fit into a byte. There
were some patches floating around to enhance the keymap loading ioctls.
They will be needed, along with a new version of loadkeys.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
