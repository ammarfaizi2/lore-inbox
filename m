Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270861AbTGVRca (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 13:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270883AbTGVRca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 13:32:30 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:51964 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270861AbTGVRca
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 13:32:30 -0400
Subject: Re: pivot_root seems to be broken in 2.4.21-ac4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jason Baron <jbaron@redhat.com>
Cc: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>,
       vda@port.imtp.ilyichevsk.odessa.ua,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0307221331090.2754-100000@dhcp64-178.boston.redhat.com>
References: <Pine.LNX.4.44.0307221331090.2754-100000@dhcp64-178.boston.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058895650.4161.23.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Jul 2003 18:40:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-22 at 18:37, Jason Baron wrote:
> > I tell init to re-execute itself (after pivot_root and thus from the new 
> > root fs), which causes init to close its old fds and open new ones from 
> > the new root fs with. This is necessary because init already runs as pid 
> > 1 when I start the root fs switching. Maybe something changed with the 
> > kernel process fds from 2.4.21-rc2 to 2.4.21-ac4 ?
> > 
> 
> yes, see the addition of the unshare_files function in kernel/fork.c

Shouldnt really have changed anything except for security exploits and
threaded apps doing weird stuff. In normal situations the files count is
one so we should actually be executing nothing more exciting that an
atomic_inc/atomic_dec.

I wonder what is going on here.

