Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266848AbUFYSvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266848AbUFYSvx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 14:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266849AbUFYSus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 14:50:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62405 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266839AbUFYSt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 14:49:27 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16604.29494.41418.239128@segfault.boston.redhat.com>
Date: Fri, 25 Jun 2004 14:47:18 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] teach netconsole how to do syslog
In-Reply-To: <20040625183935.GC25826@waste.org>
References: <16604.26514.243458.631948@segfault.boston.redhat.com>
	<20040625183935.GC25826@waste.org>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [patch] teach netconsole how to do syslog; Matt Mackall <mpm@selenic.com> adds:

mpm> On Fri, Jun 25, 2004 at 01:57:38PM -0400, Jeff Moyer wrote:
>> Hello,
>> 
>> Here's a patch which adds the option to send messages to a remote
>> syslog, enabled via the do_syslog= module parameter.  Currently logs
>> everything at info (as did the original netconsole module).  Patch is
>> against 2.6.6, though should apply to later.

mpm> Well as it stands, it's already syslog compatible, as the priority
mpm> level component of the syslog protocol is optional. I've made a point
mpm> of _defining_ the netconsole protocol as syslog (note the default
mpm> port) so that this could be done at a later date. Thus, I don't think
mpm> a new command line option is necessary.

Well, the way it is coded currently does not usually give a full line of
output on each line in my system log:

Jun 25 14:41:18 remote-host HELP : 
Jun 25 14:41:18 remote-host SysRq : 
Jun 25 14:41:18 remote-host loglevel0-8 
Jun 25 14:41:18 remote-host reBoot 
Jun 25 14:41:18 remote-host Crash 
Jun 25 14:41:18 remote-host tErm 
Jun 25 14:41:18 remote-host kIll 
Jun 25 14:41:18 remote-host saK 
Jun 25 14:41:18 remote-host showMem 
Jun 25 14:41:18 remote-host powerOff 
Jun 25 14:41:18 remote-host showPc 
Jun 25 14:41:18 remote-host unRaw 
Jun 25 14:41:18 remote-host Sync 
Jun 25 14:41:18 remote-host showTasks 
Jun 25 14:41:18 remote-host Unmount 
Jun 25 14:41:18 remote-host  

mpm> On the other hand, for this to have real value, we need to provide
mpm> real priority levels. Which means we need to plug it in higher in the
mpm> printk framework so that we a) get all messages by default and b) get
mpm> them before the levels are stripped off. I had this in an earlier
mpm> version but dropped it as being too intrusive for 2.6.0 merger.

And are you still in favor of this?  Want to post the code?

mpm> Also, if we're going to go to the trouble of being more completely
mpm> syslog-like, it's very useful (and trivial) to throw in the hostname
mpm> as well. Timestamp is slightly more difficult, but also worth
mpm> considering.

Hostname shows up by default with my syslogd.

-Jeff
