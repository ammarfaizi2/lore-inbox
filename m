Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267491AbUHVP74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267491AbUHVP74 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 11:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267529AbUHVP74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 11:59:56 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:64204 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267491AbUHVP7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 11:59:55 -0400
From: jmerkey@comcast.net
To: linux-kernel@vger.kernel.org
Cc: jmerkey@drdos.com
Subject: 2.6.8.1 sockets create-bind-unbind-bind 
Date: Sun, 22 Aug 2004 15:59:54 +0000
Message-Id: <082220041559.15319.4128C2FA000A76E900003BD72200734840970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jul 16 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.8.1 af_packet.c the logic in create and bind wastes cycles.  When you create a socket 
it calls 
create which sets the socket state on po-> to "running".  Then when bind is 
first called 
it checks this "running" flag, unbinds the previous state created with "create" 
frees the sk and 
prot hook structures sets the state to running=0 then resets the state again to 
running=1 and
reallocates these structures.  This seems to waste some cycles.   caught this 
since I hook create, bind, and unbind in af_packet for our software.  It looks 
like the logic in the sockets layer above causes this behavior.

Is there a reason it should act this way.  Seems wasteful of cycles since most 
peoples just 
call create, bind,   send send rcv rcv rcv send send, unbind 

Jeff


