Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbTLUPAK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 10:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTLUPAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 10:00:10 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:30946 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263260AbTLUPAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 10:00:06 -0500
Message-ID: <3FE5B56E.30507@colorfullife.com>
Date: Sun, 21 Dec 2003 15:59:58 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
References: <3FE492EF.2090202@colorfullife.com> <20031221113640.GF3438@mail.shareable.org> <3FE594D0.8000807@colorfullife.com> <20031221141456.GI3438@mail.shareable.org>
In-Reply-To: <20031221141456.GI3438@mail.shareable.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

>I don't think you need to change pollwait or ->poll, because the band
>information for the signal is available, as you say, by calling ->poll
>after the wakeup.
>
I'm not convinced:
The wakeup happens at irq time. The band info is necessary for 
send_sigio(). Calling f_poll at irq time is not an option - it will 
definitively cause breakage. schedule_work() for every call is IMHO not 
an option. And even that is not reliable: fasync users might expect 
seperate POLL_OUT and POLL_IN signals.


--
    Manfred


