Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279313AbRKIFeb>; Fri, 9 Nov 2001 00:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279317AbRKIFeU>; Fri, 9 Nov 2001 00:34:20 -0500
Received: from rj.sgi.com ([204.94.215.100]:48324 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S279313AbRKIFeK>;
	Fri, 9 Nov 2001 00:34:10 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modutils can't handle long kernel names 
In-Reply-To: Your message of "Thu, 08 Nov 2001 20:42:10 -0800."
             <20011108204210.A514@mikef-linux.matchmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 09 Nov 2001 16:34:00 +1100
Message-ID: <7712.1005284040@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001 20:42:10 -0800, 
Mike Fedyk <mfedyk@matchmail.com> wrote:
>EXTRAVERSION=-pre1+freeswan-1.91+xsched+netdev_random+ext3-0.9.15-2414+ext3-mem_acct+elevator
>
>Unfortunately, with this long kernel version number, modutils (I've noticed
>depmod and modutils so far...) choke on it.
>
>depmod:
>depmod: Can't open /lib/modules/2.4.15-pre1+freeswan-1.91+xsched+netdev_random+ext3-0.9.15-2414+e#1 SMP Thu Nov 8 20:18:04 PST 2001/modules.dep for writing
>
>uname -r:
>2.4.15-pre1+freeswan-1.91+xsched+netdev_random+ext3-0.9.15-2414+e#1 SMP Thu Nov 8 20:18:04 PST 2001

It is not a modutils problem, it is a fixed restriction on the size of
the uname() fields, modutils just uses what uname -r gives it.

         struct utsname {
                      char sysname[SYS_NMLN];
                      char nodename[SYS_NMLN];
                      char release[SYS_NMLN];
                      char version[SYS_NMLN];
                      char machine[SYS_NMLN];
                      char domainname[SYS_NMLN];
                      };

SYS_NMLN maps to _UTSNAME_LENGTH.
/* Length of the entries in `struct utsname' is 65.  */
#define _UTSNAME_LENGTH 65

Like you said, don't do that :).

