Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbVJEEGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbVJEEGh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 00:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVJEEGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 00:06:37 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:17558 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751210AbVJEEGg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 00:06:36 -0400
Date: Wed, 5 Oct 2005 09:30:30 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Christopher Friesen" <cfriesen@nortel.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Roland Dreier <rolandd@cisco.com>,
       Sonny Rao <sonny@burdell.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>, bharata@in.ibm.com,
       trond.myklebust@fys.uio.no, Andi Kleen <ak@suse.de>
Subject: Re: dentry_cache using up all my zone normal memory -- also seen on 2.6.14-rc2
Message-ID: <20051005040030.GA24474@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <4331C9B2.5070801@nortel.com> <20050921210019.GF4569@in.ibm.com> <4331CFAD.6020805@nortel.com> <52ll1qkrii.fsf@cisco.com> <20050922031136.GE7992@ftp.linux.org.uk> <43322AE6.1080408@nortel.com> <20050922041733.GF7992@ftp.linux.org.uk> <4332CAEA.1010509@nortel.com> <20051004194349.GA6039@in.ibm.com> <4342DFDF.9010206@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4342DFDF.9010206@nortel.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 02:02:39PM -0600, Christopher Friesen wrote:
> Dipankar Sarma wrote:
> 
> >Since then, I have done some testing myself, but I can't reproduce
> >this problem in two of my systems - x86 and x86_64. I ran rename14
> >in a loop too, but after exhausting a lot of free memory, dcache
> >does get shrunk and I don't see dentries stuck in RCU queues at all.
> >I tried UP kernel too.
> 
> I've only managed to reproduce it on a UP system with HIGHMEM.
> 
> >So, there must be something else in your system that I
> >am missing in my setup. Could you please mail me your .config ?
> 
> Sent privately.

Chris pointed out privately that the LTP rename14 test always
creates a directory in /tmp and runs from there (hidden
in an ltp library call tst_tmpdir()), not from the current
working directory. So, my tests weren't really running on
tmpfs. So, I commented out the tst_tmpdir() call in the test
forcing it to run on tmpfs and immediately I got the following
errors -

llm22:/test # ./rename14
Bad page state at prep_new_page (in process 'rename14', page ffff810008000000)
flags:0x4000000000000090 mapping:0000000000000000 mapcount:0 count:0
Backtrace:
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'syslogd', page ffff8100080002a0)
flags:0x4000000000000000 mapping:0000000000000000 mapcount:0 count:-26471
Backtrace:
Trying to fix it up, but a reboot is needed

Bad page state at prep_new_page (in process 'rename14', page ffff810008001538)

llm22 kernel: Bflags:0x4000000000000000 mapping:0000005500005555 mapcount:0 count:0
ad page state atBacktrace:
 prep_new_page (Trying to fix it up, but a reboot is needed
in process 'renaBad page state at prep_new_page (in process 'rename14', page ffff810008002aa8)
me14', page ffffflags:0x4000000000000090 mapping:0000000000000000 mapcount:0 count:0
810008000000)
Backtrace:
Trying to fix it up, but a reboot is needed

Message from syslogd@llm22 at Tue Oct  4 19:41:42 2005 ...
llm22 kernel: fBad page state at prep_new_page (in process 'rename14', page ffff810008005550)
lags:0x400000000flags:0x4000005500009090 mapping:0000000000000000 mapcount:0 count:0
0000090 mapping:Backtrace:
0000000000000000Trying to fix it up, but a reboot is needed
 mapcount:0 count:0

Andi, does this look any familiar ? This is on a 2-CPU x86_64 system
running 2.6.14-rc3 (UP kernel though).

Thanks
Dipankar
