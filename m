Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270931AbTHGV2E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 17:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271026AbTHGV2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 17:28:04 -0400
Received: from quechua.inka.de ([193.197.184.2]:42904 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S270931AbTHGV0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 17:26:39 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Interactivity improvements
In-Reply-To: <20030807204817.GZ32488@holomorphy.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19ksHM-0003Xl-00@calista.inka.de>
Date: Thu, 07 Aug 2003 23:26:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030807204817.GZ32488@holomorphy.com> you wrote:
> On Thu, Aug 07, 2003 at 04:24:18PM +0100, Richard Curnow wrote:
>> What about compilers chewing on source files coming in over NFS rather
>> than resident on local block devices?  The network waits need to be
>> broken out into NFS versus other, or UDP versus TCP or something.  e.g.
>> waits due to the user not having typed anything yet, or moved the mouse,
>> are going to be on TCP connections.
> 
> I'd be interested in whatever you come up with for this, as I use NFSS
> a lot.

Well, it might be easy to separate user mode blocking in filesystem
operations as opposed to usermode sleeping on file descriptors on a file
system type base. 

But maybe we do not need to differentiate anyway, perhaps we can somehow
detect blocking reads which stress the hardware, vs. blocking reads which
actually lowers the load. Perhaps we need a fd flag for that, where FDs
pointing to fifo, socket and pipes will be free, and FDs pointing to some
devices (e.g. not tty) and files will be tainted and get penalty on
blocking.

Another optimisation would be to only penalt a blocking process if there is
more than one, to avoid renicing processes on otherwise unloaded but slow
systems.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
