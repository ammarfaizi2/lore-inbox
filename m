Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263427AbTCNRbE>; Fri, 14 Mar 2003 12:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263428AbTCNRbD>; Fri, 14 Mar 2003 12:31:03 -0500
Received: from otter.mbay.net ([206.55.237.2]:16147 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S263427AbTCNRa7> convert rfc822-to-8bit;
	Fri, 14 Mar 2003 12:30:59 -0500
From: John Alvord <jalvo@mbay.net>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Jens Axboe <axboe@suse.de>, Oleg Drokin <green@namesys.com>,
       Oleg Drokin <green@linuxhacker.ru>, alan@redhat.com,
       linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: [2.4] init/do_mounts.c::rd_load_image() memleak
Date: Fri, 14 Mar 2003 09:40:49 -0800
Message-ID: <fq447vk4b4q823ihqbvakl8g05cnogor86@4ax.com>
References: <20030313210144.GA3542@linuxhacker.ru> <20030314110421.A28273@namesys.com> <20030314080911.GY836@suse.de> <200303141008.h2EA8gu08535@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200303141008.h2EA8gu08535@Port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Forte Agent 1.92/32.570
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Mar 2003 12:05:40 +0200, Denis Vlasenko
<vda@port.imtp.ilyichevsk.odessa.ua> wrote:

>On 14 March 2003 10:09, Jens Axboe wrote:
>> No that would just be another pointless exercise in causing more
>> annoyance for someone who has to look through patches finding that
>> one hunk that breaks stuff. The recent spelling changes come to mind.
>
>How we should do such global small cleanups?
>Maybe grep the source and bring the list of affected files
>to maintainers' attention, letting the to gradually push
>changes to Linus...
>
>I suspect "bring the list to maintainers' attention"
>will be a trickier part ;)
>
>> But just because you don't seem to have seen any kfree(NULL) in the
>> kernel does not mean they are not there. And should a good trend not
>> allow to grow?
>
>"if(p) free(p)" => "free(p)" is mostly ok, less code.
>
>But free is called now unconditionally. Make an exception
>for performance-critical places where p is almost always 0.

The one implementation I looked at carefully (SAS/C) looked like this:

 	free(p);
	---------
	if (p)
		malloc(p);

so 
	if (p) free(p);
	-------------
	if (p)
	     if (p)
		malloc(p);

which seems fairly worthless.

john
