Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUELUew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUELUew (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbUELUew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:34:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:24777 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263713AbUELUeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:34:50 -0400
Date: Wed, 12 May 2004 13:32:51 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, davidel@xmailserver.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-ID: <20040512203251.GA16336@kroah.com>
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com> <40A26FFA.4030701@pobox.com> <20040512193349.GA14936@elte.hu> <Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com> <20040512200305.GA16078@elte.hu> <20040512132050.6eae6905.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512132050.6eae6905.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 01:20:50PM -0700, Andrew Morton wrote:
> How about we do:
> 
> #if HZ=1000
> #define	MSEC_TO_JIFFIES(msec) (msec)
> #define JIFFIES_TO_MESC(jiffies) (jiffies)
> #elif HZ=100
> #define	MSEC_TO_JIFFIES(msec) (msec * 10)
> #define JIFFIES_TO_MESC(jiffies) (jiffies / 10)
> #else
> #define	MSEC_TO_JIFFIES(msec) ((HZ * (msec) + 999) / 1000)
> #define	JIFFIES_TO_MSEC(jiffies) ...
> #endif
> 
> in some kernel-wide header then kill off all the private implementations?

Looks good to me.

thanks,

greg k-h
