Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWHNTQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWHNTQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 15:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWHNTQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 15:16:27 -0400
Received: from mga05.intel.com ([192.55.52.89]:48187 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932446AbWHNTQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 15:16:27 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,122,1154934000"; 
   d="scan'208"; a="116132874:sNHT5696579245"
Date: Mon, 14 Aug 2006 12:02:55 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: What's in kbuild.git for 2.6.19
Message-ID: <20060814120255.A25857@unix-os.sc.intel.com>
References: <20060813194503.GA21736@mars.ravnborg.org> <6821.1155538929@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <6821.1155538929@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Mon, Aug 14, 2006 at 12:02:09AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith, 2.4 kernel build doesn't seem to have this issue. Is this problem
specific to 2.6 kbuild?

"info make" says this.
<snip>
Note that any job that is marked recursive (*note Instead of Executing
the Commands: Instead of Execution.)  doesn't count against the total
jobs (otherwise we could get `N' sub-`make's running and have no slots
left over for any real work!)
</snip>

Are we doing something different in 2.6 kbuild?

thanks,
suresh

On Mon, Aug 14, 2006 at 12:02:09AM -0700, Keith Owens wrote:
>Sam Ravnborg (on Sun, 13 Aug 2006 21:45:03 +0200) wrote:
>>Outstanding kbuild issues (I should fix a few of these for 2.6.18):
>>o make -j N is not as parallel as expected (latest report from Keith
>>  Ownens but others has complained as well). I assume it is a kbuild
>>  thing but has no clue how to fix it or debug it further.
>
>It is the make jobserver code.  make -j<n> causes the various make
>tasks to communicate and work out how many versions are currently
>running, to avoid overrunning the -j<n> value.  Every recursive
>invocation of make subtracts one from the -j value, reducing the value
>that is left when make finally get down to doing some useful work
>instead of just recursing.  Jobserver problems are yet another reason
>why recursive make is bad.
>
>kbuild is full of recursive make.  The user cannot just add an excess
>to <n>, the number of recursive invocations changes from kernel to
>kernel as people try to fix bugs in makefile generation, so the
>required excess value keeps changing.
>
>Before somebody suggests it: the makefile cannot detect the supplied
>value of <n> and specify a modified -j<n> on recursive make commands.
>make will detect that a sub-make has -j<n>, complain about it and turn
>off the jobserver completely.
