Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268031AbTB1R0u>; Fri, 28 Feb 2003 12:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268034AbTB1R0t>; Fri, 28 Feb 2003 12:26:49 -0500
Received: from franka.aracnet.com ([216.99.193.44]:58759 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268031AbTB1R0t>; Fri, 28 Feb 2003 12:26:49 -0500
Date: Fri, 28 Feb 2003 09:37:08 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 420] New: Divide by zero (/proc/sys/net/ipv4/neigh/DEV/base_reachable_time)
Message-ID: <27440000.1046453828@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=420

           Summary: Divide by zero
                    (/proc/sys/net/ipv4/neigh/DEV/base_reachable_time)
    Kernel Version: 2.4.20, 2.5.63
            Status: NEW
          Severity: normal
             Owner: davem@vger.kernel.org
         Submitter: usui_mi@ybb.ne.jp


Distribution:Debian GNU/Linux 3.0, Vine Linux 2.6
Hardware Environment:
Software Environment:
Problem Description:
  Divide by zero (/proc/sys/net/ipv4/neigh/DEV/base_reachable_time)
Steps to reproduce:
  I found the problem of neigh_rand_reach_time() in net/core/neighbour.c.
  This function called by neigh_periodic_timer() each 300 seconds, 
  and argument of neigh_periodic_timer() is p->base_reachable_time.
  base_reachable_time can set to 0 by below sequence.

    echo 0 > /proc/sys/net/ipv4/neigh/DEV/base_reachable_time

  But neigh_rand_reach_time() divide by its argument.

    unsigned long neigh_rand_reach_time(unsigned long base)
    {
	return (net_random() % base) + (base>>1);
    }


