Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266555AbUHTLmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUHTLmv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 07:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266347AbUHTLmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 07:42:51 -0400
Received: from [195.23.16.24] ([195.23.16.24]:50885 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S266565AbUHTLmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 07:42:49 -0400
Message-ID: <4125E3B6.6090406@grupopie.com>
Date: Fri, 20 Aug 2004 12:42:46 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
Cc: jmerkey@comcast.net, linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: kallsyms 2.6.8 address ordering
References: <081920041810.18883.4124ED110002BABC000049C32200748184970A059D0A0306@comcast.net> <20040819190029.GC1313@lnx-holt.americas.sgi.com>
In-Reply-To: <20040819190029.GC1313@lnx-holt.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.21; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt wrote:
>....
> 
> It must be useful for people using small memory footprint machines.
> Check with the folks doing embedded stuff.
> 
> I remember a discussion about kallsyms and scaling problems with
> top reading some /proc/<pid> file.
> 
> Look at this:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108758995727517&w=2
> 

I posted recently (exactly one week ago) a different approach to this 
problem that increased kallsyms_lookup performance about 100 times, 
without a cache and without locking.

The patch is currently in Ingo Molnar's tree (I think). It works by 
doing binary search on tha address table and then using pre-calculated 
markers on the stem stream to search closer to the target. After that it 
copies only the stems before the searched symbol that actually 
contribute to the final result.

You can check the thread here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109245918613781&w=2

(Please note that the original patch broke handling of aliased symbols 
which was corrected later in the thread)

I'm working on an even better approach right now and I should have a 
patch ready this weekend.

This however has nothing to do with _module_ symbol names, which is a 
different problem altogether.

-- 
Paulo Marques - www.grupopie.com
