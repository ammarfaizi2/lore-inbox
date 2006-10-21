Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992795AbWJUFY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992795AbWJUFY1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 01:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992796AbWJUFY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 01:24:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17610 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S2992795AbWJUFY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 01:24:27 -0400
Date: Sat, 21 Oct 2006 01:24:23 -0400
From: Dave Jones <davej@redhat.com>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: futex hang with rpm in 2.6.17.1-2174_FC5
Message-ID: <20061021052423.GF21948@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ben Greear <greearb@candelatech.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <453917C2.8010201@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453917C2.8010201@candelatech.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 11:38:58AM -0700, Ben Greear wrote:
 > I had a dead nfs server that was causing some programs to pause,
 > in particular 'yum install foo' was paused.  I kill -9'd the
 > yum related processes.
 > 
 > I fixed up the nfs server and was able to un-mount the file system.
 > I subsequently killed many backed up updatedb and similar processes.
 > 
 > Now, there are no rpm processes, but if I try 'rpm [anything]' it
 > hangs trying to open a futex:
 > 
 > open("/var/lib/rpm/Packages", O_RDONLY|O_LARGEFILE) = 4
 > fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
 > fstat64(4, {st_mode=S_IFREG|0644, st_size=41390080, ...}) = 0
 > futex(0xb7ba178c, FUTEX_WAIT, 1, NULL <unfinished ...>
 > 
 > Is there any way to figure out what is causing this futex-wait?

The dead rpm you killed left behind locks in its databases.
rm -f /var/lib/rpm/__db* and it should work again.

	Dave

-- 
http://www.codemonkey.org.uk
