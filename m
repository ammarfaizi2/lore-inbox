Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbULUV2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbULUV2L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 16:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbULUV2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 16:28:11 -0500
Received: from waste.org ([216.27.176.166]:10414 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261796AbULUV2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 16:28:07 -0500
Date: Tue, 21 Dec 2004 13:27:37 -0800
From: Matt Mackall <mpm@selenic.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Mark Broadbent <markb@wetlettuce.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Lockup with 2.6.9-ac15 related to netconsole
Message-ID: <20041221212737.GK5974@waste.org>
References: <20041217215752.GP2767@waste.org> <20041217233524.GA11202@electric-eye.fr.zoreil.com> <36901.192.102.214.6.1103535728.squirrel@webmail.wetlettuce.com> <20041220211419.GC5974@waste.org> <20041221002218.GA1487@electric-eye.fr.zoreil.com> <20041221005521.GD5974@waste.org> <52121.192.102.214.6.1103624620.squirrel@webmail.wetlettuce.com> <20041221123727.GA13606@electric-eye.fr.zoreil.com> <49295.192.102.214.6.1103635762.squirrel@webmail.wetlettuce.com> <20041221204853.GA20869@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041221204853.GA20869@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 09:48:53PM +0100, Francois Romieu wrote:
> Mark Broadbent <markb@wetlettuce.com> :
> [...]
> > Using the patch supplied I get no hang, just the message 'netconsole
> > raced' output to the console and the packet capture proceeds as normal.
> > Thanks
> 
> The patch is more a bandaid for debugging than a real fix. The netconsole
> will drop some messages until its locking is fixed

Unfortunately there's no good way to fix its locking in this
circumstance (or the harder case of driver-private locks). I think
I'll just have to come up with some scheme for queueing messages that
arrive when the queue lock is held.

> If you can issue one more test, I'd like to know if some messages appear
> on the VGA console around the time at which tcpdump is started (the test
> assumes that netconsole is not used/insmoded at all). Please check that
> the console log_level is set high enough as it will be really disappointing
> if nothing appears :o)

I think it's the promiscuous mode message itself that's the problem
but I've not had time to reproduce it.

-- 
Mathematics is the supreme nostalgia of our time.
