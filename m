Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWEPLYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWEPLYZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 07:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWEPLYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 07:24:25 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:8170 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751781AbWEPLYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 07:24:24 -0400
Message-ID: <4469B63B.6000502@t-online.de>
Date: Tue, 16 May 2006 13:23:39 +0200
From: Bernd Schmidt <bernds_cb1@t-online.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       "Luke.Yang" <luke.yang@analog.com>, Greg Ungerer <gerg@snapgear.com>
Subject: Please revert git commit 1ad3dcc0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: rPbV0uZlre1lNCdHKEW6eY1ihTmM5wZNW+rShenEg1w+0ttjkEAls1
X-TOI-MSGID: e58cc0ef-b338-4fa0-b1bc-73019cb0a9d1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Andrew,

please revert 1ad3dcc0.  That was a patch to the binfmt_flat loader, 
which was motivated by an LTP testcase which checks that execve returns 
EMFILE when the file descriptor table is full.

The patch is buggy: the code now keeps file descriptors open for the 
executable and its libraries, which has confused at least one 
application.  It's also unnecessary, since there is no code that uses 
the file descriptor, so the new EMFILE error return is totally artificial.

The reversion is
Signed-off-by: Bernd Schmidt <bernd.schmidt@analog.com>
Signed-off-by: Greg Ungerer <gerg@uclinux.org>
and I think Luke had no objections either.


Bernd
