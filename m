Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265064AbUD3EIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265064AbUD3EIL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 00:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbUD3EIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 00:08:10 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:25184 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265064AbUD3EIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 00:08:07 -0400
Message-ID: <4091D123.9070606@yahoo.com.au>
Date: Fri, 30 Apr 2004 14:08:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Singer <elf@buici.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40904A84.2030307@yahoo.com.au> <20040429005801.GA21978@buici.com> <40907AF2.2020501@yahoo.com.au> <20040429042047.GB26845@buici.com> <409083E9.2080405@yahoo.com.au> <20040429144941.GC708@buici.com>
In-Reply-To: <20040429144941.GC708@buici.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Singer wrote:
> On Thu, Apr 29, 2004 at 02:26:17PM +1000, Nick Piggin wrote:
> 
>>Yes it includes something which should help that. Along with
>>the "split active lists" that I mentioned might help your
>>problem when WLI first came up with the change to the
>>swappiness calculation for your problem.
>>
>>It would be great if you had time to give my patch a run.
>>It hasn't been widely stress tested yet though, so no
>>production systems, of course!
> 
> 
> As I said, I'm game to have a go.  The trouble was that it doesn't
> apply.  My development kernel has an RMK patch applied that seems to
> conflict with the MM patch on which you depend.
> 

You would probably be better off trying a simpler change
first actually:

in mm/vmscan.c, shrink_list(), change:

if (res == WRITEPAGE_ACTIVATE) {
	ClearPageReclaim(page);
	goto activate_locked;
}

to

if (res == WRITEPAGE_ACTIVATE) {
	ClearPageReclaim(page);
	goto keep_locked;
}

I think it is not the correct solution, but should narrow
down your problem. Let us know how it goes.
