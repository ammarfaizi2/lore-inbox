Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315241AbSEDXId>; Sat, 4 May 2002 19:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315249AbSEDXIc>; Sat, 4 May 2002 19:08:32 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:3714 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S315241AbSEDXIc>; Sat, 4 May 2002 19:08:32 -0400
Date: Sat, 4 May 2002 19:08:30 -0400
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory leak in 2.4.19-pre7(-ac2)?\?
Message-ID: <20020504230830.GB22569@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0205041614030.31737-100001@mail.pronto.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2002 at 04:20:08PM +0200, Roy Sigurd Karlsbakk wrote:
> Below is output from free and /proc/meminfo. Attached is a screen shot
> from the 'gtop' Memory usage output. They show a computer with uptime 2
> days and 2 hours. It looks like quite a large chunk is 'missing'...

Did you check /proc/slabinfo? The 6th column lists the number of 4KB
pages used by each 'slabcache'. The following script shows meminfo as
well as the 2 (typically) large slab-users.

Jan


#!/bin/sh
cat /proc/meminfo
awk '/^inode_cache/ {printf("Inode slab:\t%6d kB\n", 4 * $6);} /^dentry_cache/ {printf("Dentry slab:\t%6d kB\n", 4 * $6);}' < /proc/slabinfo

