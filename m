Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264235AbUEDExJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbUEDExJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 00:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264236AbUEDExJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 00:53:09 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:23821 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264235AbUEDExG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 00:53:06 -0400
Date: Tue, 4 May 2004 06:51:33 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: wcatlan@yahoo.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Possible to delay boot process to boot from USB subsystem?
Message-ID: <20040504045133.GA25278@alpha.home.local>
References: <20040503193205.2004f249.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503193205.2004f249.rddunlap@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Mon, May 03, 2004 at 07:32:05PM -0700, Randy.Dunlap wrote:
> I wish that I had a way to test this patch.
> Apparently Willy does, so I recommend his patch.... :)

You should never recommend anything from me to anyone if you want to
keep some friends :-)

> with one change:
> 
> change
> +static int setuptime;	/* time(ms) to let devices set up before root mount */
> 
> to
> +static int setuptime = 10000;	/* time(ms) to let devices set up before root mount */
> 
> 
> or 60000 (= 1 minute).  Whatever is comfortable for you.
> 
> Willy, it seems that some default value would be good there.

It was intentionnal, I don't like to change the default kernel behaviour.
So by default it's 0 and behaves as if the patch was not applied. However,
I think that a very small value (a few seconds) may be acceptable by default.
Of course, if Bill doesn't use the patch anywhere else, he should be fine
with a higher value.

Another (dirty) hack would be to export this variable, keep it to 0 by
default, and have usb_hub_thread() set it to a reasonable value when
starting khubd.

Regards,
Willy

