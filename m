Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVCUWx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVCUWx0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVCUWvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:51:23 -0500
Received: from sta.galis.org ([66.250.170.210]:41360 "HELO sta.galis.org")
	by vger.kernel.org with SMTP id S261947AbVCUWsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:48:16 -0500
From: "George Georgalis" <george@galis.org>
Date: Mon, 21 Mar 2005 17:48:15 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Paul Jarc <prj@po.cwru.edu>
Subject: Re: problem with linux 2.6.11 and sa
Message-ID: <20050321224815.GA4041@ixeon.local>
References: <20050303173459.GC952@ixeon.local> <20050321142555.47b1e5a1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321142555.47b1e5a1.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 02:25:55PM -0800, Andrew Morton wrote:
>"George Georgalis" <george@galis.org> wrote:
>>
>> I'm very defiantly seeing a problem with the 2.6.11
>> kernel and my spamassassin setup. However, it's not
>> clear exactly where the problem is, seems like sa
>> but it might be 2.6.11 with daemontools + qmail +
>> QMAIL_QUEUE.
>> 
>> A sure sign of it is no logs (with debug) for
>> remote sa connections which score "0/0" and correct
>> operation with local "cat spam.txt | spamc -R"; fix
>> is to use the older kernel.
>> 
>> SA has stopped stdout logging completely with 2.6.11
>> in addition to the all pass score. But the message
>> seems to go through my temp queue (for testing) and
>> sent on to my local MDA. I'm not sure if it's a sa
>> problem with the kernel or the new kernel doing
>> something new with pipes from tcp connections.
>> Maybe the new kernel is not making files available
>> (eg 0 bytes), until the writing pipe is closed?
>> That would make my SA test a zero byte file, which
>> would pass, close, become full, and the file piped
>> to local MDA is full? ...humm then I'd get a score
>> of "0/5"... this sounds like a SA problem with the
>> new kernel, ideas?
>
>George, did you end up getting to the bottom of this?  I'd be suspecting a
>bug in the new pipe code, or an application bug which was triggered by the
>new pipe code.

Hi! No resolution, I've been overloaded on a work related project.  The
best I can say is no problem noticed with 2.6.8.1, 2.6.10 works for smtp
code below but fails mplayer commands; 2.6.11 failed smtp code, didn't
test mplayer on 2.6.11 and haven't tried any newer kernels.

while read file; do mplayer $file ; done <mediafiles.txt # fails

for file in `cat mediafiles.txt`; do mplayer $file ; done # works

mplayer foo.mpg # works 
mplayer foo.mpg < mediafiles.txt # confuses binary for keboard input

This is the code that seems to fail per quote above, stdin is the smtp
DATA

tmp="${scq}/`safecat "${scq}/tmp" "${scq}" </dev/stdin`" \
        || { echo "Error $?"; exit 71; } # put the pipeline to disk, if possible
        # ${scq}/tmp is a temp for this function ${scq} is temp for this
        # program
score=`spamc -x -c <"$tmp"` # score it with spamd
sce=$?

I saw some notes on the new multi page pipes, me thinks its related but
that's all I know...

Regards,
// George


-- 
George Georgalis, systems architect, administrator Linux BSD IXOYE
http://galis.org/george/ cell:646-331-2027 mailto:george@galis.org
