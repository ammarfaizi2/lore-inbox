Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261765AbREPBqF>; Tue, 15 May 2001 21:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261766AbREPBpz>; Tue, 15 May 2001 21:45:55 -0400
Received: from adelphi.physics.adelaide.edu.au ([129.127.36.1]:7440 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S261765AbREPBpt>; Tue, 15 May 2001 21:45:49 -0400
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200105160145.LAA11531@mercury.physics.adelaide.edu.au>
Subject: Re: Kernel 2.2.19 + VIA chipset + strange behaviour
To: kaos@ocs.com.au (Keith Owens)
Date: Wed, 16 May 2001 11:15:44 +0930 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe),
        linux-kernel@vger.kernel.org
In-Reply-To: <32518.989916932@ocs3.ocs-net> from "Keith Owens" at May 15, 2001 06:55:32 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 15 May 2001 18:04:35 +0930 (CST), 
> Jonathan Woithe <jwoithe@physics.adelaide.edu.au> wrote:
> >ksymoops 2.4.1 on i686 2.2.19.  Options used
> >Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
> 
> module_list was added to the export list in 2.2.17 so the message above
> implies that you are using kernel build information from 2.2.17 in your
> 2.2.19 build.  I suggest you follow http://www.tux.org/lkml/#s8-8 and
> see if your problems recur after a completely clean kernel build.

This is curious because the compilation was done from a completely fresh
2.2.19 tree (ie: not patched, no old .configs used).  In any case, I have
just carried out the following as per the URL above:
  mv .config ..
  make mrproper
  mv ../.config .
  make oldconfig
  make dep clean bzImage modules
  # install, boot

After going through these steps and rebooting, ksymoops still complains
about the missing symbol, and checking System.map confirms that
module_list_R__ver_module_list is indeed not present:
  auster:~>ksymoops
  ksymoops 2.4.1 on i686 2.2.19.  Options used
       -V (default)
       -k /proc/ksyms (default)
       -l /proc/modules (default)
       -o /lib/modules/2.2.19/ (default)
       -m /usr/src/linux/System.map (default)
  :
  Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not
  found in System.map.  Ignoring ksyms_base entry

/usr/src/linux is a symlink to the 2.2.19 tree.

The mystery of this ksymoops message remains.

Thanks and regards
  jonathan
-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple     *
*   and danced naked on a harpsicord singing 'subtle plans are here again'" *
