Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbTH0GnV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 02:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbTH0GnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 02:43:21 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:45737 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S263158AbTH0GnT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 02:43:19 -0400
Date: Wed, 27 Aug 2003 09:43:02 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Cc: tejun@aratech.co.kr, skraw@ithnet.com
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1 solid hangs)
Message-ID: <20030827064301.GF150921@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org, tejun@aratech.co.kr, skraw@ithnet.com
References: <20030729073948.GD204266@niksula.cs.hut.fi> <20030730071321.GV150921@niksula.cs.hut.fi> <Pine.LNX.4.55L.0307301149550.29648@freak.distro.conectiva> <20030730181003.GC204962@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730181003.GC204962@niksula.cs.hut.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 09:10:03PM +0300, you [Ville Herva] wrote:
> 
> However, I just realized that all of those kernel were compiled with fairly
> dubious gcc, version 2.96-85. I just compiled otherwise identically
> configured 2.4.21-jam1 with gcc-3.2.1-2. It'll take some time to tell
> whether this cures it. This is my main suspect now.

I celebrated too early.

The kernel compiled with gcc 3.2.1 20021207 (Red Hat Linux 8.0 3.2.1-2) hung
too, it just happened to take a little longer.

Short summary:

  - The hangs are solid: 
    - nothing in the log, nothing on the screen
    - no ctrl-alt-del, numlock
    - no sysrq-s, sysrq-u, sysrq-b 
    - nmi watchdog doesn't trigger
  - The hangs mostly happen when the nightly oracle backup dump is in
    progress
    - the oracle database is on an ide disk, oracle app and the dump
      destination are on an scsi disk (Adaptec 2940, SEAGATE ST19171W)
  - HW: Intel 815EEA2LU mobo, i815, Celeron Tualatin 1.3GHz. Adaptec 2940,
    9GB Seagate, HP C1537A tapedrive (not used), IBM-DTLA-305030 ide disk.
  - The aic7xxx driver has been acting up in past: crashes on boot and 
    sometimes at runtime too. I don't know if this is at all related to the
    lock ups.
  - Kernels tried: 2.4.22-pre8/gcc-2.96-85, 2.4.21-jam1/2.4.21-jam1, 
    2.4.21-jam1/gcc-3.2.1-2, 2.4.20pre7 -- all hang.

Perhaps this is related to the "Race condition in 2.4 tasklet handling
(cli() broken?)" problem TeJun Huh and Stephan von Krawczynski have been
discussing?

Any ideas?


-- v --

v@iki.fi
