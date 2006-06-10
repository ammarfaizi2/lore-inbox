Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751670AbWFJSJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbWFJSJW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 14:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbWFJSJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 14:09:21 -0400
Received: from a34-mta02.direcpc.com ([66.82.4.91]:4814 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1751667AbWFJSJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 14:09:21 -0400
Date: Sat, 10 Jun 2006 14:08:50 -0400
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [PATCH] kthread conversion: convert ieee1394 from kernel_thread
In-reply-to: <20060610163859.GA24081@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       "Serge E. Hallyn" <serue@us.ibm.com>, weihs@ict.tuwien.ac.at,
       linux1394-devel@lists.sourceforge.net, bcollins@debian.org,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>
Message-id: <1149962931.4448.557.camel@grayson>
Organization: Ubuntu
MIME-version: 1.0
X-Mailer: Evolution 2.6.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20060610143100.GA15536@sergelap.austin.ibm.com>
 <20060610144205.GA13850@infradead.org> <448AE12E.5060002@s5r6.in-berlin.de>
 <20060610154213.GA19077@infradead.org> <1149957286.4448.542.camel@grayson>
 <20060610163859.GA24081@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-10 at 17:38 +0100, Christoph Hellwig wrote:
> On Sat, Jun 10, 2006 at 12:34:46PM -0400, Ben Collins wrote:
> > 1394 bus rescanning takes a _lot_ longer than a PCI rescan. If we don't
> > do this in a kthread, then we have to do it as a tasklet, and take a
> > chance of stalling for a few seconds (not ms), preventing other
> > tasklet's from running. Suboptimal, IMO.
> 
> This is just user-initiated FC rescans.  And I doubt they take as long
> as parallel scsi rescans which can go into the minutes range easily.
> Nothing will be stalled by calling this except the caller, which would
> usually be echo called from some shell, something the user can put in
> the background using job control.

Most rescans are initiated by a bus reset (usually caused by a
connect/disconnect of a device) that is detected in interrupt.
Obviously, we cannot initiate these rescans in interrupt, so a tasklet
or kthread is the only option.

The reason for handling user-initiated rescans (through some sysfs
interface?) and hardware-initiated rescans in the same place is code
simplicity, and synchronization.

I'm not sure what your implying about user-initiated rescans. The only
thing I can think of is device/driver binding, which isn't handled in
our kernel thread anyway (except where it's a new device being detected,
as opposed to a new driver being loaded).

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/

