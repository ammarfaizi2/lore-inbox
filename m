Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310375AbSCLDPP>; Mon, 11 Mar 2002 22:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310380AbSCLDPG>; Mon, 11 Mar 2002 22:15:06 -0500
Received: from zok.SGI.COM ([204.94.215.101]:23497 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S310376AbSCLDPA>;
	Mon, 11 Mar 2002 22:15:00 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Shawn Starr <spstarr@sh0n.net>
Cc: Linux <linux-kernel@vger.kernel.org>
Subject: Re: uname reports 'unknown' 
In-Reply-To: Your message of "11 Mar 2002 20:43:37 CDT."
             <1015897420.3054.0.camel@coredump> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 12 Mar 2002 14:14:39 +1100
Message-ID: <6826.1015902879@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Mar 2002 20:43:37 -0500, 
Shawn Starr <spstarr@sh0n.net> wrote:
>Linux coredump 2.4.19-pre2-ac4-xfs-shawn10 #2 Mon Mar 11 03:36:35 EST
>2002 i586 unknown
>
>
>what should 'unknown' really be? I've never seen it different on Intel
>systems.

'unknown' is the output from uname -p, host processor type.  That field
is not supported in the Linux kernel.  uname.c in sh-utils has this

#if defined (HAVE_SYSINFO) && defined (SI_ARCHITECTURE)
  if (sysinfo (SI_ARCHITECTURE, processor, sizeof (processor)) == -1)
    error (1, errno, _("cannot get processor type"));
#else
  strcpy (processor, "unknown");
#endif

HAVE_SYSINFO is always false in sh-utils and SI_ARCHITECTURE is not
defined in glibc so you always get unknown.

