Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWJJUMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWJJUMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 16:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbWJJUMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 16:12:09 -0400
Received: from user-0c93tin.cable.mindspring.com ([24.145.246.87]:47753 "EHLO
	hachi.dashjr.org") by vger.kernel.org with ESMTP id S1030259AbWJJUMI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 16:12:08 -0400
From: Luke -Jr <luke@dashjr.org>
Organization: -Jr Family
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: IP routing with fwmark
Date: Tue, 10 Oct 2006 15:12:01 -0500
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610101512.02207.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having trouble getting my routing rules to work. Basically, I just want to 
lock a connection to use a single network interface. The common and only 
method (compatible with IP forwarding) seems to be using CONNMARK to keep 
track of the interface each connection is assigned to.
However, for some reason, it appears the Linux IP routing table is not 
correctly processing the fwmark rules:
12:     from all fwmark 0xa lookup inet_sbc
Both inet_sbc and main tables have a default route set. If I prepend "prohibit 
default" into *either* of the tables (main or inet_sbc), the packet is 
dropped. Since a packet only has a single route, this suggests that Linux is 
doing two routing lookups, and only processing the fwmark rules in the first 
one (which, if not an error, is ignored and overridden by the later lookup).

Any other possibilities, suggestions, ideas, or fixes? Or should I post more 
details?

Thanks,

Luke-Jr (CC replies please)
