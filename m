Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965189AbWEaV70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbWEaV70 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965192AbWEaV7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:59:25 -0400
Received: from dvhart.com ([64.146.134.43]:14226 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S965189AbWEaV7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:59:25 -0400
Message-ID: <447E11B5.7030203@mbligh.org>
Date: Wed, 31 May 2006 14:59:17 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@google.com>,
       linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
References: <447DEF47.6010908@google.com> <20060531140823.580dbece.akpm@osdl.org> <20060531211530.GA2716@elte.hu> <447E0A49.4050105@mbligh.org> <20060531213340.GA3535@elte.hu> <447E0DEC.60203@mbligh.org> <20060531215315.GB4059@elte.hu>
In-Reply-To: <20060531215315.GB4059@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> but ... i fixed the performance problem that caused the previous 
> DEBUG_MUTEXES scalability problems. (there's no global mutex list 
> anymore) We also default to e.g. DEBUG_SLAB which is alot more costly.

OK. So what's the perf impact of the new version on a 32 cpu machine? 
;-) Maybe it's fine, maybe it's not.

> i'm wondering, why doesnt your config have DEBUG_MUTEXES disabled? Then 
> 'make oldconfig' would pick it up automatically.

Because it builds off the same config file all the time. It was created
before CONFIG_MUTEXES existed ... creating a situation where we have to
explicitly disable new options all the time becomes a maintainance
nightmare ;-(

If we don't want to do performance regression checking on -mm, that's
fine, but I thought it was useful (has caught several things already).
If we want debug options explicitly enabled, we can do a separate debug
run, I'd think, but it makes it very difficult to do automated testing
if we add random new debug options all the time on by default ...

If we really think the debug options we're turning on by default have
zero perf impact, that's fine ... but it has not been my previous
experience. People obviously haven't checked that carefully in the past,
perhaps they are now and the world fixed itself, but I'm not that
optimistic ...

M.
