Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbUJXKek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbUJXKek (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 06:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbUJXKek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 06:34:40 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:24581 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261431AbUJXKee
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 06:34:34 -0400
Date: Sun, 24 Oct 2004 12:35:57 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
Subject: Re: More on SMBus multiplexing
Message-Id: <20041024123557.744414cc.khali@linux-fr.org>
In-Reply-To: <20041023200215.38e375a1.khali@linux-fr.org>
References: <20041023200215.38e375a1.khali@linux-fr.org>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to myself:

> As a kind of proof of concept, I did a fake i2c-i801-vaio module to
> virtualize the SMBus on my laptop (although it doesn't have a mux
> chip). It works just OK as far as I can tell. Of course the code is
> stupidly useless (the virtual adapter doesn't do anything more than
> dumbly redirect the calls to the physical bus), and lacks the mux
> client registration part, since there is no such chip. I think that
> the idea is clear though, and at least now we have code to comment on
> ;)

I find that I am unable to actually register the mux client. Odd, since
it worked OK on a 2.4 kernel, and several tries led me nowhere on 2.6
kernels. If anyone has sample code to just occupy a given I2C address on
a given bus, please share it with me.

However, why do we even need this? Looks far easier to simply exclude
the multiplexer address from the virtual busses (which we need to do
anyway). Nobody is supposed to access the physical bus directly (it's
not in the main adapters list anyway). Again, I see no reason to protect
us from something that is just never going to happen. This makes the
whole thing even more simple, exactly as in my demo code.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
