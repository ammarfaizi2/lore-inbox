Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbUDYA2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUDYA2d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 20:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUDYA2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 20:28:33 -0400
Received: from mailgate1b.savvis.net ([216.91.182.6]:42880 "EHLO
	mailgate1b.savvis.net") by vger.kernel.org with ESMTP
	id S262003AbUDYA23 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 20:28:29 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: 2 NFS problems
Date: Sat, 24 Apr 2004 19:28:12 -0500
Message-ID: <3B33FD3ADBD7054DB410CD9DA314133E775E21@sl6exch4>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2 NFS problems
Thread-Index: AcQqXLDwHsT6nADHSbG1UA3jdScHJQ==
From: "Stanley, Jon" <Jon.Stanley@savvis.net>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Apr 2004 00:27:40.0343 (UTC) FILETIME=[1E177C70:01C42A5C]
X-ECS-MailScanner: No virus is found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two distinct problems possibly related to NFS in the Linux
kernel.  Any assistance would be appreciated, any flames that say "you
should have looked such-and-such place" are welcome as well, so long as
they include pointers to said places :-)

1)  A system will become unusable, with the following in
/var/log/messages:

Apr 24 22:16:35 <hostname> kernel: __alloc_pages: 4-order allocation
failed.
Apr 24 22:16:35 <hostname> kernel: __alloc_pages: 4-order allocation
failed.

Before these messages are the messages that make me believe that NFS is
either the cause or a victim of this (I'm not sure which)

Apr 24 22:11:59 <hostname> kernel: nfs: task 7513 can't get a request
slot

Here's the full log from the beginning of this event (began at 13:00,
within several hours it had degraded the system to the point that it was
not usable any longer - i.e. no ssh, etc.)

Apr 24 13:00:45 <hostname> kernel: __alloc_pages: 4-order allocation
failed.
Apr 24 13:00:50 <hostname> last message repeated 7 times
Apr 24 13:00:56 <hostname> kernel: nfs: server <nfs server> not
responding, still trying
Apr 24 13:00:56 <hostname> kernel: nfs: server <nfs server> not
responding, still trying
Apr 24 13:00:56 <hostname> kernel: __alloc_pages: 4-order allocation
failed.
Apr 24 13:01:25 <hostname> last message repeated 13 times
<irrelevant line removed>
Apr 24 13:01:36 <hostname> kernel: __alloc_pages: 4-order allocation
failed.
Apr 24 13:01:36 <hostname> kernel: __alloc_pages: 4-order allocation
failed.
<irrelevant line removed>
Apr 24 13:01:59 <hostname> kernel: __alloc_pages: 4-order allocation
failed.
Apr 24 13:01:59 <hostname> kernel: __alloc_pages: 4-order allocation
failed.
<irrelevant line removed>
Apr 24 13:02:04 <hostname> kernel: __alloc_pages: 4-order allocation
failed.
Apr 24 13:02:04 <hostname> kernel: __alloc_pages: 4-order allocation
failed.
<irrelevant line removed>
Apr 24 13:02:15 <hostname> kernel: __alloc_pages: 4-order allocation
failed.
Apr 24 13:02:16 <hostname> kernel: __alloc_pages: 4-order allocation
failed.
<irrelevant line removed>
Apr 24 13:02:38 <hostname> kernel: __alloc_pages: 4-order allocation
failed.
Apr 24 13:02:38 <hostname> kernel: __alloc_pages: 4-order allocation
failed.
Apr 24 13:02:46 <hostname> kernel: nfs: task 7463 can't get a request
slot
Apr 24 13:02:46 <hostname> kernel: nfs: task 7464 can't get a request
slot

This is running RedHat 7.1, with kernel version 2.4.2-2smp (yes, I know
it's antique - I'm also looking for known bugs that fit this particular
presentation).  The NFS mount is coming from an EMC NS600G.  Let me know
if more information is required.

2)  The second problem, occuring on a separate system, is a little
harder to articulate, and there are no logs to go along with it, but
here goes:

This system, was has mounts from EMC Celerra storage, occasionally has a
problem whereby one filesystem will become inaccessible (it mounts about
65 different filesystem across 14 datamovers, IIRC).  The problem is
actually happening right now, and here's the best description:

When you try to run df, it will just hang forever, requiring you to kill
your terminal session in order to get out of it.  Same when you try to
do anything with this filesystem.  There are multiple machines mounting
these filesystems, and it does not happen on the same filesystem to all
of them.  Unfortunately, they are all running the same version of the
kernel (2.4.9-34smp) and distribution (RH 7.2).  It also does not happen
to every filesystem mounted off that datamover - just one of them.  The
combination of all of these factors leads to a very baffling problem.
Unfortuantely, the customer will not allow us to upgrade the kernel
without extensive testing on their side first.  A reboot of the server
always fixes the problem, for a time.

Any suggestions/comments/constructive flames welcome :-)

-Jon



