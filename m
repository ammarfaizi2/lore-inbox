Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbVCPOxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbVCPOxg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 09:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVCPOxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 09:53:36 -0500
Received: from mailsc1.simcon-mt.com ([195.27.129.236]:4742 "EHLO
	mailsc1.simcon-mt.com") by vger.kernel.org with ESMTP
	id S262608AbVCPOxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 09:53:31 -0500
Date: Wed, 16 Mar 2005 15:50:34 +0100
From: "Andrei A. Voropaev" <av@simcon-mt.com>
To: linux-kernel@vger.kernel.org
Subject: listen and backlog parameter - is it supposed to work?
Message-ID: <20050316145034.GA7811@vandal.simcon-mt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Recently I stumbled across interesting "feature" of listen and backlog
parameter for it. Stevens book mentions that this parameter shall
specify maximum count of ESTABLISHED connections that will wait in the
queue for accept to be picked up. It also says that for linux backlog =
0 in reality means that there'll be 3 ready connection waiting. The rest
of SYNs shall be dropped silently untill accept harvests the established
connection(s).

I've tried it with linux and sure enough it didn't work as described. In
fact, it works very strangely. In my test program I do listen(sock, 0)
and then go to sleep for long time. Then I try to connect to the port.
First 3 connections succeed as expected. The fourth one times-out (I
used time out 4 seconds), also as expected. But the fifth one again
succeeds. And all subsequent ones seemingly random succeed and time-out.
So in my test out of 30 connections I got between 10 and 20 connections
established.

It does not look like a proper behaviour, but maybe I'm missing
something? I'm using vanila kernel and I tried it both with 2.6 and 2.4.

Not that it's very important, but I'm really curious why is it so.

Thank you

Andrei Voropaev

PS. I'm not on the list
