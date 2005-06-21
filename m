Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVFUQ3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVFUQ3w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbVFUQ0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:26:43 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:39583 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262175AbVFUQZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:25:37 -0400
Subject: Re: -mm -> 2.6.13 merge status (HZ -> 250?)
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050620235458.5b437274.akpm@osdl.org>
References: <20050620235458.5b437274.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 12:26:31 -0400
Message-Id: <1119371192.19357.40.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-20 at 23:54 -0700, Andrew Morton wrote:
> CONFIG_HZ for x86 and ia64: changes default HZ to 250, make HZ
> Kconfigurable.
> 
>     Will merge (will switch default to 1000 Hz later if that seems
> necessary) 

How about delaying this until the high res timers patches are ready?
That way you can save power and avoid the latency regression, in fact it
would be a huge improvement from user POV.

Consider a program with a 5ms RT constraint, like a game or mplayer.
Currently it uses the RTC on 2.4/HZ=100 systems and usleep() on
2.6/HZ=1000.  Allowing HZ to regress to 250 would force us to handle
2.4, 2.6.1 - 2.6.12, and 2.6.13+ separately.  It would be a huge mess.

Lee

