Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWEHPZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWEHPZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 11:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWEHPZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 11:25:51 -0400
Received: from dvhart.com ([64.146.134.43]:53985 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932386AbWEHPZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 11:25:51 -0400
Message-ID: <445F62F8.3030200@mbligh.org>
Date: Mon, 08 May 2006 08:25:44 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Jason Schoonover <jasons@pioneer-pra.com>, linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
References: <200605051010.19725.jasons@pioneer-pra.com> <20060507095039.089ad37c.akpm@osdl.org> <445F548A.703@mbligh.org> <1147100149.2888.37.camel@laptopd505.fenrus.org> <20060508152255.GF1875@harddisk-recovery.com>
In-Reply-To: <20060508152255.GF1875@harddisk-recovery.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> On Mon, May 08, 2006 at 04:55:48PM +0200, Arjan van de Ven wrote:
> 
>>On Mon, 2006-05-08 at 07:24 -0700, Martin J. Bligh wrote:
>>
>>>>It's pretty harmless though.  The "load average" thing just means that the
>>>>extra pdflush threads are twiddling thumbs waiting on some disk I/O -
>>>>they'll later exit and clean themselves up.  They won't be consuming
>>>>significant resources.
>>>
>>>If they're waiting on disk I/O, they shouldn't be runnable, and thus
>>>should not be counted as part of the load average, surely?
>>
>>yes they are, since at least a decade. "load average" != "cpu
>>utilisation" by any means. It's "tasks waiting for a hardware resource
>>to become available". CPU is one such resource (runnable) but disk is
>>another. There are more ... 
> 
> 
> ... except that any kernel < 2.6 didn't account tasks waiting for disk
> IO. Load average has always been somewhat related to tasks contending
> for CPU power. It's easy to say "shrug, it changed, live with it", but
> at least give applications that want to be nice to the system a way to
> figure out the real cpu load.

I had a patch to create a real, per-cpu load average. I guess I'll dig
it out again, since it was also extremely useful for diagnosing
scheduler issues.

Maybe I'm confused about what the loadavg figure in Linux was in 2.6,
I'll go read the code again. Not sure it's very useful to provide only
a combined figure of all waiting tasks without separated versions as
well, really.
