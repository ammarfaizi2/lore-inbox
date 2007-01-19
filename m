Return-Path: <linux-kernel-owner+w=401wt.eu-S932802AbXASAqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932802AbXASAqK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932830AbXASAqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:46:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45294 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932809AbXASAqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:46:08 -0500
Date: Fri, 19 Jan 2007 01:45:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Kawai, Hidehiro" <hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de, james.bottomley@steeleye.com,
       Satoshi OSHIMA <soshima@redhat.com>,
       "Hideo AOKI@redhat" <haoki@redhat.com>,
       sugita <yumiko.sugita.yf@hitachi.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] binfmt_elf: core dump masking support
Message-ID: <20070119004548.GE10351@elf.ucw.cz>
References: <457FA840.5000107@hitachi.com> <20061213132358.ddcaaaf4.akpm@osdl.org> <20061220154056.GA4261@ucw.cz> <45A2EADF.3030807@hitachi.com> <20070109143912.GC19787@elf.ucw.cz> <45A74B89.4040100@hitachi.com> <20070114200157.GA2582@elf.ucw.cz> <45B01387.7010207@hitachi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45B01387.7010207@hitachi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2007-01-19 09:40:39, Kawai, Hidehiro wrote:
> Hi Pavel,
>  
> >>>Well, you can have it as set of 0-1 "limits"...
> >>
> >>I have come up with a similar idea of regarding the ulimit
> >>value as a bitmask, and I think it may work.
> >>But it will be confusable for users to add the new concept of
> >>0-1 limitation into the traditional resouce limitation feature.
> >>Additionaly, this approach needs a modification of each shell
> >>command.
> >>What do you think about these demerits?
> > 
> >>The /proc/<pid>/ approach doesn't have these demerits, and it
> >>has an advantage that users can change the bitmask of any process
> >>at anytime.
> > 
> > Well... not sure if it is advantage. 
> 
> For example, consider the following case:
>   a process forks many children and system administrator wants to
>   allow only one of these processes to dump shared memory.
> 
> This is accomplished as follows:
> 
>  $ echo 1 > /proc/self/coremask
>  $ ./some_program
>  (fork children)
>  $ echo 0 > /proc/<a child's pid>/coremask
> 
> With the /proc/<pid>/ interface, we don't need to modify the
> user program.  In contrast, with the ulimit or setrlimit interface,
> the administrator can't do it without modifying the user program
> to call setrlimit.  This will not be preferred.

Yep, otoh process coremask setting can change while it is running,
that is not expected. Hmm, it can also change while it is dumping
core, are you sure it is not racy?

(run echo 1 > coremask, echo 0 > coremask in a loop while dumping
core. Do you have enough locking to make it work as expected?)


								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
