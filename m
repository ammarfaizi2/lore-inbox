Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315545AbSECDNI>; Thu, 2 May 2002 23:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315546AbSECDNH>; Thu, 2 May 2002 23:13:07 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:25002 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S315545AbSECDNG>; Thu, 2 May 2002 23:13:06 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 2 May 2002 20:21:56 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alexander Viro <viro@math.psu.edu>
cc: John Covici <covici@ccs.covici.com>, Dave Jones <davej@suse.de>,
        tomas szepe <kala@pinerecords.com>, Keith Owens <kaos@ocs.com.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <Pine.GSO.4.21.0205022217290.17171-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0205022006430.1641-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2002, Alexander Viro wrote:

> Fix your application.  The rules are very simple - /usr/include/linux contains
> versions of headers used to build libc.  If you are linking against libc,
> you don't want to have different parts of resulting executable to be
> compiled with different versions of these headers.  If you want several
> definitions from headers of your current kernel - extract them (and make
> damn sure that you don't pull a conflict with libc headers).

i do not know how glibc uses to export things but they should not export
any kernel related structure. the theory that went around in various
kernel update howto was to make linux, asm and scsi links to kernel
include dirs. even if glibc would export kernel dependent stuff ( ie
ioctl() params ) it should let the pointer go through w/out any
manipulation, otherwise it would be linked to a specific kernel version.

# find /usr/include/ -name '*.h' -exec grep -H 'include <linux/' \{} \;

/usr/include/pci/pci.h:#include <linux/pci.h>
/usr/include/pci/pci.h:#include <linux/types.h>
/usr/include/apm.h:#include <linux/apm_bios.h>
/usr/include/a.out.h:# include <linux/a.out.h>
/usr/include/bits/errno.h:# include <linux/errno.h>
/usr/include/bits/local_lim.h:#include <linux/limits.h>
/usr/include/net/ethernet.h:#include <linux/if_ether.h>
/usr/include/net/if_slip.h:#include <linux/if_slip.h>
/usr/include/net/ppp-comp.h:#include <linux/ppp-comp.h>
/usr/include/net/ppp_defs.h:#include <linux/ppp_defs.h>
/usr/include/netatalk/at.h:#include <linux/atalk.h>
/usr/include/netinet/if_ether.h:#include <linux/if_ether.h>
/usr/include/netinet/if_fddi.h:#include <linux/if_fddi.h>
/usr/include/netinet/if_tr.h:#include <linux/if_tr.h>
/usr/include/netinet/igmp.h:#include <linux/igmp.h>
/usr/include/nfs/nfs.h:#include <linux/nfs.h>
/usr/include/sys/kd.h:#include <linux/kd.h>
/usr/include/sys/param.h:#include <linux/limits.h>
/usr/include/sys/param.h:#include <linux/param.h>
/usr/include/sys/pci.h:#include <linux/pci.h>
/usr/include/sys/prctl.h:#include <linux/prctl.h>
/usr/include/sys/soundcard.h:#include <linux/soundcard.h>
/usr/include/sys/sysctl.h:#include <linux/sysctl.h>
/usr/include/sys/sysinfo.h:#include <linux/kernel.h>
/usr/include/sys/ultrasound.h:#include <linux/ultrasound.h>
/usr/include/sys/vt.h:#include <linux/vt.h>
/usr/include/libnet.h:#include <linux/igmp.h>


i've always used the symlink approach and if you're right i should
consider spending some time in Las Vegas ;)




- Davide



