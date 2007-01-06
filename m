Return-Path: <linux-kernel-owner+w=401wt.eu-S932157AbXAFUTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbXAFUTG (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 15:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbXAFUTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 15:19:06 -0500
Received: from terminus.zytor.com ([192.83.249.54]:48264 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932157AbXAFUTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 15:19:05 -0500
Message-ID: <45A0041F.4060903@zytor.com>
Date: Sat, 06 Jan 2007 12:18:39 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Nicholas Miell <nmiell@comcast.net>,
       Randy Dunlap <randy.dunlap@oracle.com>, "J.H." <warthog9@kernel.org>,
       Willy Tarreau <w@1wt.eu>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
References: <20061214223718.GA3816@elf.ucw.cz>	<20061216094421.416a271e.randy.dunlap@oracle.com>	<20061216095702.3e6f1d1f.akpm@osdl.org>	<458434B0.4090506@oracle.com>	<1166297434.26330.34.camel@localhost.localdomain>	<20061219063413.GI24090@1wt.eu>	<1166511171.26330.120.camel@localhost.localdomain>	<20070106103331.48150aed.randy.dunlap@oracle.com>	<459FF60D.7080901@zytor.com>	<1168112266.2821.2.camel@entropy> <20070106121301.d07de0c9.akpm@osdl.org>
In-Reply-To: <20070106121301.d07de0c9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>>>
>>> The most fundamental problem seems to be that I can't tell currnt Linux 
>>> kernels that the dcache/icache is precious, and that it's way too eager 
>>> to dump dcache and icache in favour of data blocks.  If I could do that, 
>>> this problem would be much, much smaller.
> 
> Usually people complain about the exact opposite of this.

Yeah, but we constantly have all-filesystem sweeps, and being able to 
retain those in memory would be a key to performance, *especially* from 
the upload latency standpoint.

>> Isn't setting the vm.vfs_cache_pressure sysctl below 100 supposed to do
>> this?

Just tweaked it (setting it to 1).  There really should be another 
sysctl to set the denominator instead of hardcoding it at 100, since the 
granularity of this sysctl at the very low end is really much too coarse.

I missed this sysctl since the name isn't really all that obvious.

	-hpa
