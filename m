Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263041AbUEKGiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUEKGiB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUEKGgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:36:53 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:15749 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S263062AbUEKGd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:33:58 -0400
Message-ID: <40A073CA.9090805@myrealbox.com>
Date: Mon, 10 May 2004 23:33:46 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
References: <fa.j4d62qo.1144tpk@ifi.uio.no> <fa.gg699ad.b2omr9@ifi.uio.no>
In-Reply-To: <fa.gg699ad.b2omr9@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris Wright wrote:
> * Chris Wedgwood (cw@f00f.org) wrote:
> 
>>On Mon, May 10, 2004 at 03:02:03PM -0700, Andrew Morton wrote:
>>
>>
>>>Capabilities are broken and don't work.  Nobody has a clue how to
>>>provide the required services with SELinux and nobody has any code
>>>and we need the feature *now* before vendors go shipping even more
>>>ghastly stuff.
>>
>>eh? magic groups are nasty...  and why is this needed?  can't
>>oracle/whatever just run with a wrapper to give the capabilities out
>>as required until a better solution is available
> 
> 
> I agree.  I have a patch that at least fixes this bit of capabilities
> (currently, what you suggest doesn't work right), which could easily be
> dusted off and resent.

I'll try and get my patch ready for testing soon.  It got sidetracked by 
the compute_creds race (erm... and my inability to fix it right the 
first time).

Before I clean it up and rediff it, here's a question:

I would like to make the inheritable mask mean "these are the only 
capabilities that this process or its children may ever hold."  That 
means tweaking setuid to disable itself if the inheritable mask is not 
full to avoid auditing every setuid program ever written..  The benefit 
is that cap_bset can be removed and securelevel can done sanely (by 
adding a sysctl that means "setuid needs this set of capabilities").  It 
also means that servers could drop inheritable caps, so, if they are 
hacked, the attacker can't try to exploit setpcap / setuid / 
(eventually) vfs caps.  The downside is added complexity.

If I don't do that, I'm not quite sure what to do with the inheritable 
mask.  It seems to be only marginally useful.

Thoughts?

--Andy
