Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263754AbTDIUAe (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 16:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263758AbTDIUAe (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 16:00:34 -0400
Received: from holomorphy.com ([66.224.33.161]:52395 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263754AbTDIUAc (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 16:00:32 -0400
Date: Wed, 9 Apr 2003 13:11:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       Dave McCracken <dmccr@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix obj vma sorting
Message-ID: <20030409201100.GB30376@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@digeo.com>, Dave McCracken <dmccr@us.ibm.com>,
	linux-kernel@vger.kernel.org
References: <71580000.1049913191@flay> <Pine.LNX.4.44.0304092007040.2595-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304092007040.2595-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 08:20:28PM +0100, Hugh Dickins wrote:
> Thanks.  Yes, seems conclusive, but I'm puzzled.
> I hope a fresh pair of eyes can work it out for us.

They're pounding ->i_shared_sem, which you already knew.

Here's what I see as far as number of processes mapping what. It seems
to indicate large scale sharing occurs for a number of objects, which
could very well lead to mutual interference for several objects.

It seems to indicate more than glibc is involved, and that there's some
shm involved with large vma count files on "normal" systems as well.

-- wli

how many processes were mapping a given file
	(i.e. remove dups in /proc/$PID/maps)
---------------------------------------------
/lib/libc-2.2.5.so                                          151
/lib/ld-2.2.5.so                                            151
/lib/libnsl-2.2.5.so                                        110
/lib/libnss_compat-2.2.5.so                                 107
/lib/libdl-2.2.5.so                                         85
/lib/libm-2.2.5.so                                          70
/lib/libncurses.so.5.2                                      65
/usr/X11R6/lib/libX11.so.6.2                                44
/usr/X11R6/lib/libSM.so.6.0                                 43
/usr/X11R6/lib/libICE.so.6.3                                43
/lib/libcap.so.1.10                                         39
/usr/lib/zsh/4.0.4/zsh/zle.so                               35
/usr/lib/zsh/4.0.4/zsh/rlimits.so                           35
/usr/lib/zsh/4.0.4/zsh/complete.so                          35
/usr/lib/zsh/4.0.4/zsh/compctl.so                           35
/usr/X11R6/lib/libXpm.so.4.11                               35
/bin/zsh4                                                   35
/lib/libnss_files-2.2.5.so                                  32
/usr/lib/libz.so.1.1.4                                      31
/usr/X11R6/lib/libXext.so.6.4                               24
/lib/libcrypt-2.2.5.so                                      22
/lib/libresolv-2.2.5.so                                     21
/lib/libnss_dns-2.2.5.so                                    21


How many vma's total mapped a given file:
-----------------------------------------
/lib/libc-2.2.5.so            302
/lib/ld-2.2.5.so              302
/lib/libnsl-2.2.5.so          220
/SYSV00000000                 220
/lib/libnss_compat-2.2.5.so   214
/lib/libdl-2.2.5.so           170
/lib/libm-2.2.5.so            140
/lib/libncurses.so.5.2        130
/usr/X11R6/lib/libX11.so.6.2  88
/usr/X11R6/lib/libSM.so.6.0   86
/usr/X11R6/lib/libICE.so.6.3  86
/lib/libcap.so.1.10           78
/usr/lib/zsh/4.0.4/zsh/zle.so 70
/usr/X11R6/lib/libXpm.so.4.11 70
/bin/zsh4                     70
/lib/libnss_files-2.2.5.so    64
/usr/lib/libz.so.1.1.4        62
/usr/X11R6/lib/libXext.so.6.4 48
/lib/libcrypt-2.2.5.so        44
/lib/libresolv-2.2.5.so       42
/lib/libnss_dns-2.2.5.so      42
/usr/X11R6/lib/libXt.so.6.0   40
/usr/X11R6/bin/wterm          40
