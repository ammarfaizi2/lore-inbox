Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWHMII4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWHMII4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 04:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWHMII4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 04:08:56 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:15744 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750749AbWHMII4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 04:08:56 -0400
Date: Sun, 13 Aug 2006 10:08:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1 make -j4 does not run parallel
Message-ID: <20060813080848.GA7811@mars.ravnborg.org>
References: <3740.1155437931@ocs10w.ocs.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3740.1155437931@ocs10w.ocs.com.au>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 12:58:51PM +1000, Keith Owens wrote:
> Dual cpu system.
> 'echo $$' reports current id is 4972
> export KBUILD_OUTPUT=../obj
> make -j4
> 
> Building a 2.6.17.7 tree, 'LANG= pstree -pl 4972' shows multiple tasks
> running in parallel.  Even here it is only running 2 instead of the 4
> that I expect.
> 
> bash(4972)---make(7519)---make(7522)-+-make(7721)---make(8198)---make(8513)---sh(8565)---gcc(8566)---gcc(8572)-+-as(8574)
>                                      |                                                                         `-cc1(8573)
>                                      `-make(8077)---sh(8558)---gcc(8559)---gcc(8569)-+-as(8571)
>                                                                                      `-cc1(8570)
> 
> build a 2.6.18-rc1 or later tree, make -j4 does not run parallel.  All
> pstree output shows a single branch, like this.
> 
> bash(4972)---make(30031)---make(30034)---make(31797)---make(2840)---sh(3678)---gcc(3681)---gcc(3682)---cc1(3683)
> 
> Using 'make -j' without a number or 'make -j<n>' where <n> is greater
> than 4 does show parallel build behaviour.  Looks like something is
> decrementing -j<n> as you go down the make tree and decrementing it
> enough that it ends up in a serial build.

Thanks. I will try to look into this within a few days - it looks
strange. But you pstree is a great way to see when it happens.

I have been tossing around with an idea to do some of the veru initial
steps in a shell script rather than in make. This should allow us to
bring down the make invocations but this bug needs to be understood
first.

	Sam
