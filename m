Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263331AbTIAW3h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 18:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbTIAW3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 18:29:37 -0400
Received: from main.gmane.org ([80.91.224.249]:5835 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263331AbTIAW3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 18:29:35 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Charles Lepple <clepple@ghz.cc>
Subject: Re: dontdiff for 2.6.0-test4
Date: Mon, 01 Sep 2003 18:29:37 -0400
Message-ID: <bj0h8a$ev5$1@sea.gmane.org>
References: <Pine.GSO.4.44.0309010754480.1106-100000@north.veritas.com> <20030901163958.A24464@infradead.org> <20030901162244.GA1041@mars.ravnborg.org> <3F537CDD.3040809@pobox.com> <20030901171806.GB1041@mars.ravnborg.org> <20030901214738.GF31760@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
In-Reply-To: <20030901214738.GF31760@matchmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
[...]
>>mrproper:
>>        @find . $(RCS_FIND_IGNORE) \
>>                \( -name '*.orig' -o -name '*.rej' -o -name '*~' \
>>                -o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
>>                -o -name '.*.rej' -o -size 0 \
>>                -o -name '*%' -o -name '.*.cmd' -o -name 'core' \) \
>>                -type f -print | xargs rm -f
>>        $(call cmd,mrproper)
>>
> 
> 
> But dontdiff is a list of files that must be skipped, not a regex, right?
> Then dontdiff will be useless until a build has been done on that kernel tree.

Not really. From the diff manpage:

        -X FILE  --exclude-from=FILE
               Exclude files that match any pattern in FILE.

You may want to take a look at a copy of dontdiff (noting the shell 
patterns). It looks like dontdiff could be generated from mrproper's 
list of scratch files (with the exception of the '-size 0' test in the 
'find' command) but I could be wrong.

FWIW, the $(RCS_FIND_IGNORE) part skips some version-control directories 
that dontdiff doesn't mention. I guess the party line is that you should 
use the version control system for doing diffs in that case, but whatever.

If you try to replace dontdiff with a dynamically generated list, be 
sure and have a few folks test it out on different trees (including ones 
managed by BK and SVN) to make sure you haven't broken anything.

-C


