Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbTIYMuR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 08:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTIYMuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 08:50:17 -0400
Received: from fmr09.intel.com ([192.52.57.35]:52478 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261337AbTIYMuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 08:50:07 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Shmulik Hen <shmulik.hen@intel.com>
Reply-To: shmulik.hen@intel.com
Organization: Intel corp.
Subject: [PATCH SET][bonding] cleanup
Date: Thu, 25 Sep 2003 15:49:59 +0300
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: bonding-devel@lists.sourceforge.net,
       bonding-announce@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Cc: "Jeff Garzik" <jgarzik@pobox.com>, "Jay Vosburgh" <fubar@us.ibm.com>,
       "Noam, Amir" <amir.noam@intel.com>,
       "Mendelson, Tsippy" <tsippy.mendelson@intel.com>,
       "Noam, Marom" <noam.marom@intel.com>,
       "Shmulik, Hen" <shmulik.hen@intel.com>
Message-Id: <200309251549.59177.shmulik.hen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now that all the 2.4<->2.6 synchronizing stuff is done, we are moving 
forward with the cleanup plan. This set is similar to the previous 
set I sent on 8/27, but it is based on the latest version that was 
accepted into the kernel with the seq_file changes, a few bug fixes 
and a bit more cleanup stuff. This set is very comprehensive and 
touches almost all the code. The set is broken down to many patches 
for better tracking. It was already tested by me for functionality 
and is undergoing a more thorough set of testing by our QA group for 
any corner case bugs. A set that cleans up the 802.3ad code will 
follow shortly.

This patch applies on 2.4.23-pre5. It would also apply on 2.6.0 after 
Amir's patch 2/10 from the "[bonding 2.6] propagating master's 
settings to slaves" set is accepted by Jeff and applied on 2.6.

patch set can be downloaded from:
http://osdn.dl.sourceforge.net/sourceforge/bonding/bonding-cleanup-2.4.23-pre5.tar.bz2

This will update the following files:

        Documentation/networking/bonding.txt
        Documentation/networking/ifenslave.c
        drivers/net/bonding/bond_3ad.c
        drivers/net/bonding/bond_alb.c
        drivers/net/bonding/bond_alb.h
        drivers/net/bonding/bonding.h
        drivers/net/bonding/bond_main.c
        include/linux/if_bonding.h

Description:
patch 1 - ifenslave lite - No more IP settings to slaves, unified 
          printing format, code re-org and broken to more functions.
patch 2 - convert all debug prints to use the dprintk macro and 
          consolidate format of all prints (e.g. "bonding: Error: 
          ...").
patch 3 - death of typedef. eliminate bonding_t/slave_t types and 
          consolidate casting.
patch 4 - remove dead code, old compatibility stuff and redundant 
          checks.
patch 5 - consolidate timers initialization, error checking and 
          re-queuing.
patch 6 - convert too long if-else to a switch-case. Fix all locations 
          that handles bond->primary.
patch 7 - eliminate the multicast_mode module param. settings are now 
          done only according to mode.
patch 8 - slave list iteration - bond is no longer part of the list, 
          added cyclic list iteration macros.
patch 9 - consolidate function declarations:
          o all functions begin with bond_
          o return value, function name and all params are on the same 
            line.
          o change some function names to be more descriptive.
patch 10 - consolidate names of function params and variables (e.g. 
           bond_dev instead of dev/master/master_dev).
patch 11 - change names/types for some of the members in struct 
           bonding. change position of members.
patch 12 - consolidate return values of functions.
patch 13 - put curly braces around all if, else, for, while, switch 
           statements. change conditions to short format.
           e.g. (ptr == NULL) ==> (!ptr)
patch 14 - consolidate error handling in all xmit functions.
patch 15 - chomp all trailing white space.
patch 16 - remove duplicate empty lines. add empty lines where needed 
           to improve readability.
patch 17 - fix indentations.
patch 18 - code re-organization in bond_main.c according to context
           (e.g. module initialization, bond initialization, device 
           entry points, monitoring, etc.). some last minute minor 
           changes and fixes.

-- 
| Shmulik Hen   Advanced Network Services  |
| Israel Design Center, Jerusalem          |
| LAN Access Division, Platform Networking |
| Intel Communications Group, Intel corp.  |

