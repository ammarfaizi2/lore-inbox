Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRCWBgN>; Thu, 22 Mar 2001 20:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129051AbRCWBgD>; Thu, 22 Mar 2001 20:36:03 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:41815 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129066AbRCWBfu>; Thu, 22 Mar 2001 20:35:50 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Frank de Lange <frank@unternet.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2-ac21 
In-Reply-To: Your message of "Fri, 23 Mar 2001 00:02:54 BST."
             <20010323000254.A25375@unternet.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 23 Mar 2001 12:35:03 +1100
Message-ID: <4514.985311303@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001 00:02:54 +0100, 
Frank de Lange <frank@unternet.org> wrote:
>Linux 2.4.2-ac21 does not like my box, or the other way around:
>
>loading the agpgart module (MGA G400 AGP) -> system hangs
>loading the SCSI module (53c875) -> system hangs
>
>In both cases, the magic SysRq sequence does not work, but it is still possible
>to ping the box from the outside. Connecting to it (ssh) does not work,
>however. I backed out both the SCSI driver patches as well as the agpgart
>patches, but this did not fix the symptoms. Looks more like a module-loading
>related issue, but I have not found it yet.
>
>All this on an SMP (Abit BP6) box by the way...

Activate the nmi watchdog with nmi_watchdog=1 in the boot parameters[*].
That will trip after 5 seconds and point to where it is hanging.  If
the nmi watchdog alone does not give enough data, add the kdb patch
(with nmi watchdog on) and start debugging.
http://oss.sgi.com/projects/kdb/download/ix86/, the -ac20 patch should
fit -ac21 as well.

Am I the only person who is annoyed that nmi watchdog is now off by
default and the only way to activate it is by a boot parameter?  You
cannot even patch the kernel to build a version that has nmi watchdog
on because the startup code runs out of the __setup routine, no boot
parameter, no watchdog.

