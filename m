Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263843AbTICWNt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 18:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbTICWNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 18:13:49 -0400
Received: from mail2-216.ewetel.de ([212.6.122.116]:43469 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S263843AbTICWNr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 18:13:47 -0400
Date: Thu, 4 Sep 2003 00:13:44 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: [NFS] attempt to use V1 mount protocol on V3 server
Message-ID: <Pine.LNX.4.44.0309040004230.4629-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I don't know whether this is really a problem with the kernel
NFS client - I tried looking at the code but I cannot make too
much sense out of it. ;)

The problem is the following. I have written a user-space NFSv3
server and wanted to register the mount program for version 3 only.
But, this leads to a two problems:

a) when unmounting an NFS volume, the server gets sent an umount
   request indicating version 1 of the protocol, sending a version 3
   umount is not even attempted

b) when something goes wrong during the NFSv3 mount, the kernel
   seems to fall back to NFSv2, re-attempting the mount with mount
   protocol version 1

I think both of this should not be done when the remote side does not
advertise mount protocol version 1 support.

Question: is this a problem of the user-space mount utility or is
it an in-kernel problem?

I've worked around it for the moment by registering for the mount v1
protocol too, handling umount and returning an error if a mount is
attempted. I would it like much more to register for v3 only, though...

-- 
Ciao,
Pascal

