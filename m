Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262697AbUKXPqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbUKXPqn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 10:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbUKXPpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 10:45:42 -0500
Received: from zeus.kernel.org ([204.152.189.113]:42400 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262736AbUKXPnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 10:43:21 -0500
To: linux-kernel@vger.kernel.org
Cc: d507a@cs.aau.dk
Subject: Isolating two network processes on same machine
From: Ole Laursen <olau@cs.aau.dk>
Date: 24 Nov 2004 16:10:12 +0100
Message-ID: <tv8r7mj1dwr.fsf@homer.cs.aau.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We need to test a peer-to-peer network application that is supposed to
be scalable. To that end, we have a FreeBSD box with dummynet and a
small cluster of Linux test machines. The box act as the gateway for
the test machines and delay incoming packets for a while before
throwing them back to the cluster to simulate latency on the Internet.

By letting the test machines think they run on separate subnets, we
have been able to fool them into forwarding their packets to the
FreeBSD gateway even though everyone is connected to the same switch.
This is working fine.

The problem is that we need to run several instances of our network
application on the same test machine since we have too few machines.
But when we create two IP addresses on the same machine with

  ifconfig eth0:0 10.0.0.2 netmask 255.255.255.0 broadcast 10.0.0.255
  ifconfig eth0:1 10.0.1.2 netmask 255.255.255.0 broadcast 10.0.1.255

and start two instances on the same machine with the two IP addresses,
then they communicate directly with each other instead of going
through the FreeBSD gateway. Can anyone see a way to solve this
problem?


(I've CC'ed the other guys in my group.)

-- 
Ole Laursen
http://www.cs.aau.dk/~olau/
