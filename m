Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263957AbTDIWti (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263958AbTDIWti (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:49:38 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:21632 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S263957AbTDIWte (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 18:49:34 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Randy.Dunlap" <rddunlap@osdl.org>
Date: Thu, 10 Apr 2003 01:00:51 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.5.67-mm1 cause framebuffer crash at bootup
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <1C68BF606C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9 Apr 03 at 15:55, Randy.Dunlap wrote:
> On Wed, 9 Apr 2003 23:52:51 +0200 "Petr Vandrovec" <VANDROVE@vc.cvut.cz> wrote:
> 
> | On  9 Apr 03 at 14:45, Randy.Dunlap wrote:
> | >  [<c029367a>] fbcon_set_display+0x33a/0x4c0
> | >  [<c01f8031>] set_inverse_transl+0x41/0xa0
> | 
> | Can you remove 'printk(KERN_DEBUG "%s: %ux%u, vt=%u, init=%u, ...'
> | from fbcon_set_display (drivers/video/console/fbcon.c)? On my system
> | printk(KERN_DEBUG) does not print nothing to the console even before
> | syslogd is started (one wonders why...), but on your system it apparently
> | triggers output to console before video mode was set.
> 
> Yes, I did that and can report that this one printk() kills it for me.
> I.e., it boots and runs fine with this line commented out, but when I
> put it back and rebuild, that kernel gets the same oops during boot.

Thanks. It looks like that I missed that there is still large window where
we use fbcon before mode is set on underlying fbdev, even after reorg.
I did at console level. For now it is easier to remove this printk...
                                                            Petr
                                                            

