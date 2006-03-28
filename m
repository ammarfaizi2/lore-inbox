Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWC1WUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWC1WUK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWC1WUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:20:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2263 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932440AbWC1WUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:20:08 -0500
Date: Wed, 29 Mar 2006 00:19:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Romano Giannetti <romanol@upcomillas.es>, linux-kernel@vger.kernel.org
Subject: Re: Good news --- jump from 2.6.13-rc3 to 2.6.16  (almost) ok (swsusp, input)
Message-ID: <20060328221956.GA5760@elf.ucw.cz>
References: <20060327120706.GA838@pern.dea.icai.upcomillas.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060327120706.GA838@pern.dea.icai.upcomillas.es>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I finally tried to install 2.6.16 on my portable PC, jumping directly from
> 2.6.13-rc3, and there are good news. The most critical thing, namely swsusp,
> did work ok and seems faster than before. A little problem is that when
> starting the suspend, no messages are printed (the screen goes blank and
> after a bit the machine poweroff). But then resume is ok . The same goes for
> -ck1,  which has a really nice feeling.

See FAQ:

Q: How do I make suspend more verbose?

A: If you want to see any non-error kernel messages on the virtual
terminal the kernel switches to during suspend, you have to set the
kernel console loglevel to at least 4 (KERN_WARNING), for example by
doing

        # save the old loglevel
        read LOGLEVEL DUMMY < /proc/sys/kernel/printk
        # set the loglevel so we see the progress bar.
        # if the level is higher than needed, we leave it alone.
        if [ $LOGLEVEL -lt 5 ]; then
                echo 5 > /proc/sys/kernel/printk
                fi

        IMG_SZ=0
        read IMG_SZ < /sys/power/image_size
        echo -n disk > /sys/power/state
        RET=$?
        #
        # the logic here is:
        # if image_size > 0 (without kernel support, IMG_SZ will be
zero),
        # then try again with image_size set to zero.
        if [ $IMG_SZ -ne 0 ]; then # try again with minimal image size
                echo 0 > /sys/power/image_size
                echo -n disk > /sys/power/state
                RET=$?
        fi

        # restore previous loglevel
        echo $LOGLEVEL > /proc/sys/kernel/printk
        exit $RET


-- 
Picture of sleeping (Linux) penguin wanted...
