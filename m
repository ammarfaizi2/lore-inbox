Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTJGQE1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 12:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbTJGQE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 12:04:27 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:23250 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262451AbTJGQEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 12:04:22 -0400
Date: Tue, 7 Oct 2003 17:03:47 +0100
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: paul.devriendt@amd.com, kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: powernow-k8: don't crash system at boot
Message-ID: <20031007160346.GD29736@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, paul.devriendt@amd.com,
	kernel list <linux-kernel@vger.kernel.org>,
	Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>
References: <20031005190056.GA863@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031005190056.GA863@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 05, 2003 at 09:00:57PM +0200, Pavel Machek wrote:

<Please don't send these to Rusty, such changes are far from trivial.
 Not that I don't trust Rusty to pass on them, but it's one less thing
 he has to worry about..>

 > powernow-k8 module fails to initialize government on boot, leading to
 > nasty crash at boot.

See below.

 > This fixes it. Plus find_closest_find really wants to be static. Fix
 > it, too.

Applied. Thanks.

 > @@ -971,6 +971,7 @@
 >  	pol->cpuinfo.max_freq = 1000 * find_freq_from_fid(ppst[numps-1].fid);
 >  	pol->min = 1000 * find_freq_from_fid(ppst[0].fid);
 >  	pol->max = 1000 * find_freq_from_fid(ppst[batps - 1].fid);
 > +	pol->governor = CPUFREQ_DEFAULT_GOVERNOR;
 >  
 >  	printk(KERN_INFO PFX "cpu_init done, current fid 0x%x, vid 0x%x\n",
 >  	       currfid, currvid);

Already fixed differently. Dominik's patch also nuked the setting of ->policy
a few lines above.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
