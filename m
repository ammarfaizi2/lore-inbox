Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbUCRHrr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 02:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbUCRHrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 02:47:47 -0500
Received: from gizmo08bw.bigpond.com ([144.140.70.18]:62894 "HELO
	gizmo08bw.bigpond.com") by vger.kernel.org with SMTP
	id S261979AbUCRHrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 02:47:45 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: linux-kernel@vger.kernel.org
Subject: Re: add lowpower_idle sysctl
Date: Thu, 18 Mar 2004 17:49:39 +1000
User-Agent: KMail/1.5.1
Cc: akpm@osdl.org, kenneth.w.chen@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403181749.39300.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
> OK, so why not give us: 
 > 
 > #define IDLE_HALT 0 
 > #define IDLE_POLL 1 
 > #define IDLE_SUPER_LOW_POWER_HALT 2 
 > 
 > and so forth (are there any others?).

#define IDLE_C1HALT ?
 
I created another one for Athlon Nforce2 to prevent lockups in apic mode.
It is proving more useful than I thought.
It has also been used on SIS740 to prevent same problem.
I know such a workaround should not be required but it works well.

It modifies C1 state idle behaviour by being a little more intelligent about
when it is worthwhile to do into disconnect and has a crude but effective
delay in case of back to back disconnect reconnect cycles.
Recent post.
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-03/4278.html
Patch is here.
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-02/6520.html 

Currently it is kernel arg activated by  "idle=C1halt".
 
 > 
 > Set some system-wide integer via a sysctl and let the particular 
 > architecture decide how best to implement the currently-selected idle mode? 
 
A lockup detector on Athlon systems could conceivably invoke above idle state
after a manual reboot as not all systems of the same chipset have the problem.

Ross.

