Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265555AbTFMV6a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 17:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265559AbTFMV6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 17:58:30 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:2222 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265555AbTFMV60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 17:58:26 -0400
Date: Sat, 14 Jun 2003 00:12:09 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Dave Jones <davej@codemonkey.org.uk>, OverrideX <overridex@punkass.com>,
       vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 hangs on boot
Message-ID: <20030614001209.E10851@ucw.cz>
References: <1055466518.29294.10.camel@nazgul> <20030613214944.GA10406@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030613214944.GA10406@suse.de>; from davej@codemonkey.org.uk on Fri, Jun 13, 2003 at 10:49:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 10:49:44PM +0100, Dave Jones wrote:
> On Thu, Jun 12, 2003 at 09:08:39PM -0400, OverrideX wrote:
>  > Hi all, 
>  > 
>  > I've tried 2.5.70, 2.5.70-mm8 and 2.5.70-bk17.  All of them hang while
>  > booting, the last message they display is "Uncompressing Linux... Ok,
>  > booting the kernel." then they just sit blank and boot no further.  I've
>  > booted previous 2.5.x kernels on this system, the last I had used was
>  > 2.5.63. My Hardware and other info is below, .config is attached. Is
>  > anyone else experiencing this problem?  Is there any other information I
>  > can provide to help debuging?  Please cc me any replies as my mailbox
>  > can't take the full brunt of this mailing list, thanks -Dan
> 
> Ugh, what a mess. Take a look at http://www.codemonkey.org.uk/post-halloween-2.5.txt
> You'll notice that your .config doesn't contain most of those in the
> 'gotchas' section that it suggests you make sure you have.
> 
> The root cause of this is that you have CONFIG_INPUT=m.
> 
> CONFIG_VT only shows up if you have CONFIG_INPUT=y.
> With it set to =m a whole bunch of options never ever show up in the
> configuration.
> 
> This really wants fixing badly. The source of this problem seems to be
> people taking 2.4 configs (where CONFIG_INPUT=m was fine), and it all
> going pear-shaped when people make oldconfig.  I'm aware of the problems
> that oldconfig can't override variables set in .config, so how about 
> just renaming CONFIG_INPUT to something else ?

I'm considering CONFIG_INPUT_ADVANCED, which would default to 'n', like
with the font and parition config and if set to 'n', all the modules
needed for 2.4 functional compatibility would be automatically built in.
What do you think?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
