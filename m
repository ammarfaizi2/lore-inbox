Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262889AbUKXXF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262889AbUKXXF5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbUKXXEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:04:22 -0500
Received: from zeus.kernel.org ([204.152.189.113]:3005 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262895AbUKXXAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:00:30 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.28 -> ch..ch...changes....
Date: Wed, 24 Nov 2004 19:57:14 +0000
User-Agent: KMail/1.7
References: <Pine.LNX.4.44.0411241744210.5172-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0411241744210.5172-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411241957.14527.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 November 2004 17:48, Hugh Dickins wrote:
> On Wed, 24 Nov 2004, Marcelo Tosatti wrote:
> > On Tue, Nov 23, 2004 at 09:36:36PM +0000, Nick Warne wrote:
> > > I updated three boxes today to 2.4.28 (from .27), one at work, and two
> > > here at home (Redhat 7.1+, Slackware 10)
> > >
> > > I am intrigued terribly by the small footprint of memory usage now.  I
> > > have gone through the changes file, but can really see nothing (to me,
> > > a n00b) that would alter that?
> > >
> > > Can anyone enlighten me?
> >
> > What do you mean by "memory usage"? SLAB (/proc/slabinfo) buffers
> > or pagecache ?
> >
> > Whats your workload and what drivers are you using ?
> >
> > Nothing that I am aware of explains this.
>
> _If_ it's a reduction in /proc/slabinfo's dentry_cache, and
> _if_ these boxes do a lot of removing files from tmpfs,
> then it would be the "tmpfs: stop negative dentries".

I dunno, no real scientific measures at all, but I have noticed using 'free' 
all boxes from boot load load like 40%  less in memory.  As time goes on, 
memory usage grows (of course), but now it 'drops off' when not being used... 
2.4.2x never done that.

I tested today on my Slackware box especially:

Linux linuxamd 2.4.28 #1 Tue Nov 23 17:46:52 GMT 2004 i686 unknown unknown 
GNU/Linux  (HM, append="1280M").

An Athlon 1.2Ghz  running all up to date Slack 10 stable with KDE 3.3.0 
upgrade.

I ran Celestia for over an hour, burnt a few knoppix ISO's, and then ISO'ed a 
big directory to burn all using 'BashBurn'.

Just played Quake2 for three maps running full chat.

Normally memory slowly fills up, perhaps using swap for a bit under these 
circumstances - but looking afterwards:
 
root@linuxamd:~# free
             total       used       free     shared    buffers     cached
Mem:       1292348     520012     772336          0      38596     327304
-/+ buffers/cache:     154112    1138236
Swap:      1959888          0    1959888

I would normally expect 'free' to report 900000 odd (with Celestia pushing 
toward swap) by now... but it doesn't.

Another box,:

Linux quake.ddayuk.dyndns.org 2.4.28 #1 Tue Nov 23 17:28:32 GMT 2004 i686 
unknown

Runs a Quake2 server and Teamspeak.  Again, usually after 2 hours uptime 
nearly hits peak, but now:

             total       used       free     shared    buffers     cached
Mem:        516440      45368     471072          0       6296      25556
-/+ buffers/cache:      13516     502924
Swap:       265032          0     265032

The box at work is a back-up httpd (apache) web server running NTPD for whole 
sub-net, mrtg, and a lot of other stuff (I use for testing stuff until I push 
to main web server)... this always has 30/40MB disk swap.  Today only 6MB.

I build all kernels with no modules, all built in (expect USB for memory 
sticks on slack).  The only change I done this time from previous kernel 
upgrades was download the full 2.4.28 bz2 file rather than apply patches to 
existing build trees (make oldconfig).

But whatever, I am impressed indeed - somethings changed for the good!!!

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
