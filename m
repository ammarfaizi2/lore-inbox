Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbUCJQja (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 11:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbUCJQja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 11:39:30 -0500
Received: from outbound03.telus.net ([199.185.220.222]:58793 "EHLO
	priv-edtnes12-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id S262686AbUCJQjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 11:39:24 -0500
Message-ID: <404F44B6.8030202@bcgreen.com>
Date: Wed, 10 Mar 2004 08:39:18 -0800
From: Stephen Samuel <samuel@bcgreen.com>
Organization: Just Another Radical
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
CC: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>,
       linux-admin@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Redirection of STDERR
References: <20040308111349.030feea6.Christoph.Pleger@uni-dortmund.de>	<404DEAFD.8090802@bcgreen.com> <jehdwylz0x.fsf@sykes.suse.de>
In-Reply-To: <jehdwylz0x.fsf@sykes.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, you're right.  I was tired when I wrote it,

however, the exec command still isn't quite
complete.  Normally, you'd want a command to be
exec'ing.

In theory, the exec command by itself should (I think) just
redirect for the rest of your commands... However, it would
appear that there's a bug in bash for that syntax.
(i.e. If I type it in on the command line, It doesn't work for me, either).

In this case, I think you're going to be better off to just start
your processes with the output going direct  logger...

my (more successful) way of doing this is:

{
	command 1
	command2
	command3
} | logger -t $0[$$]

(needs a semicolon before the '}' if it's a one-liner.

It's also more portable (compatible with old bourne shells)
I prefer to save things like the named pipe syntax for the really
ornery situations where bourne-compatible syntax jusr doesn't
do the job.

Andreas Schwab wrote:
 > Stephen Samuel <samuel@bcgreen.com> writes:
 >>Christoph Pleger wrote:
 >>>Hello,
 >>>In my initialization scripts for hotplug (written for bash) the
 >>>following command is used to redirect output which normally goes to
 >>>stderr to the system logger:
 >>>"exec 2> >(logger -t $0[$$])"
 >>
 >>I don't remember this syntax as legal.
 >
 > That's the process substitution feature of bash, quite handy when you want
 > to get an fd connected to a pipe.


-- 
Stephen Samuel +1(604)876-0426                samuel@bcgreen.com
		   http://www.bcgreen.com/~samuel/
    Powerful committed communication. Transformation touching
      the jewel within each person and bringing it to light.
