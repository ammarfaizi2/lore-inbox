Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWFGUEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWFGUEK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 16:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWFGUEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 16:04:10 -0400
Received: from xenotime.net ([66.160.160.81]:22465 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750708AbWFGUEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 16:04:08 -0400
Date: Wed, 7 Jun 2006 13:06:53 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Diego Calleja <diegocg@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, netdev@vger.kernel.org,
       linux-xfs@oss.sgi.com, ecki@lina.inka.de, lkml@rtr.ca
Subject: Re: Updated sysctl documentation take #2
Message-Id: <20060607130653.9a4d572c.rdunlap@xenotime.net>
In-Reply-To: <20060607205316.bbb3c379.diegocg@gmail.com>
References: <20060607205316.bbb3c379.diegocg@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2006 20:53:16 +0200 Diego Calleja wrote:

> Since people didn't like the "many small files" approach, I've moved
> it to directories containing index.txt files:
> 
> Documentation/sysctl/vm/index.txt
> Documentation/sysctl/net/core/index.txt
> Documentation/sysctl/net/unix/index.txt
> Documentation/sysctl/net/ipv4/index.txt
> Documentation/sysctl/net/ipv4/conf/index.txt
> Documentation/sysctl/net/ipv4/route/index.txt
> Documentation/sysctl/net/ipv4/neigh/index.txt
> 
> and so on.
> 
> As previously, this moves all sysctl documentation (including
> XFS and network) to Documentation/sysctl/*. The patch is
> against linus tree and weights more than 200K in size
> and is place at: http://www.terra.es/personal/diegocg/sysctl-docs

~> diffstat -p1 -w 70 sysctl-docs 
 Documentation/filesystems/proc.txt            | 1210 ----------------
 Documentation/filesystems/xfs.txt             |   84 -
 Documentation/networking/00-INDEX             |    2 
 Documentation/networking/Configurable         |    2 
 Documentation/networking/decnet.txt           |    4 
 Documentation/networking/ip-sysctl.txt        |  899 -----------
 Documentation/networking/xfrm_sync.txt        |   11 
 Documentation/sysctl/README                   |  121 -
 Documentation/sysctl/abi.txt                  |   54 
 Documentation/sysctl/abi/index.txt            |   49 
 Documentation/sysctl/dev/README               |    2 
 Documentation/sysctl/fs.txt                   |  150 -
 Documentation/sysctl/fs/index.txt             |  240 +++
 Documentation/sysctl/fs/xfs/index.txt         |  170 ++
 Documentation/sysctl/kernel.txt               |  344 ----
 Documentation/sysctl/kernel/index.txt         |  628 ++++++++
 Documentation/sysctl/net/README               |    8 
 Documentation/sysctl/net/appletalk/index.txt  |   38 
 Documentation/sysctl/net/bridge/index.txt     |   44 
 Documentation/sysctl/net/core/index.txt       |  115 +
 Documentation/sysctl/net/ipv4/conf/index.txt  |  270 +++
 Documentation/sysctl/net/ipv4/index.txt       |  739 +++++++++
 Documentation/sysctl/net/ipv4/neigh/index.txt |  138 +
 Documentation/sysctl/net/ipv4/route/index.txt |  143 +
 Documentation/sysctl/net/ipv6/conf/index.txt  |  256 +++
 Documentation/sysctl/net/ipv6/icmp/index.txt  |   15 
 Documentation/sysctl/net/ipv6/index.txt       |   65 
 Documentation/sysctl/net/ipv6/neigh/index.txt |  134 +
 Documentation/sysctl/net/ipv6/route/index.txt |   78 +
 Documentation/sysctl/net/unix/index.txt       |   15 
 Documentation/sysctl/sunrpc.txt               |   20 
 Documentation/sysctl/sunrpc/index.txt         |   64 
 Documentation/sysctl/vm.txt                   |  180 --
 Documentation/sysctl/vm/index.txt             |  334 ++++
 Documentation/sysrq.txt                       |   20 
 35 files changed, 3611 insertions(+), 3035 deletions(-)
I don't know how long it takes to review such a large patch, but
I'll continue to do so.  For now:

README:

1. +Documentation for /proc/sys/, aka. sysctl

a.k.a. or just "aka".  Not "aka.".  or spell it out, or omit it,
maybe like:

Documentation for /proc/sys/ (sysctl)

2.  Limit lines to max. of 80 characters, but around 70-72 is better
IMO.  That allows someone to make minor corrections without having
to fudge the lines around.

3.  +This means there're several parameters
use "there are"

4.  +are: enabling or disabling forwading in a certain network interface
forwarding

5.  +is also used to export some stadistic information, ej: some
statistic or statistics or statistical
ej: ??  use e.g.: (preferred) or eg:

6.  +can be read but can _not_ be written.
_cannot_

7.  +own program to read them aswell)
as well)

8.  +to change '/' by '.' and ignore the '/proc/sys' part of the path, ie
s/by/to/
s/ie/i.e./

9.  +means that any tweak that you do will be lost the next time you restart  your
* collapse 2 spaces to 1

10. +_VERY_ DANGEROUS and can ruin the performance performance,
drop one "performance"

11. +As a quick 'ls /proc/sys' will show, the directory consists of several subdirs.
+Each subdir is mainly about one part of the kernel, so you can do configuration

Spell out "subdirectories" and "subdirectory".

12. +fs/		specific filesystems filehandle, inode, dentry and quota tuning

insert ":" after "filesystems"


OK, that's all for the README file.  I'll look at the rest of it
sometime this week.  I don't think that it's quite ready to be merged.

---
~Randy
