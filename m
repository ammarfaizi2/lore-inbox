Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267201AbTGOLZq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 07:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267205AbTGOLZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 07:25:46 -0400
Received: from nmail1.systems.pipex.net ([62.241.160.130]:47758 "EHLO
	nmail1.systems.pipex.net") by vger.kernel.org with ESMTP
	id S267201AbTGOLZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 07:25:45 -0400
Message-ID: <1058269196.3f13e80ce57c4@netmail.pipex.net>
Date: Tue, 15 Jul 2003 12:39:56 +0100
From: "\\\"shaheed r. haque\\\"" <srhaque@iee.org>
To: linux-kernel@vger.kernel.org
Cc: Robert Love <rml@tech9.net>, Miquel van Smoorenburg <miquels@cistron.nl>
Subject: [HOWTO] Emulate processor sets (pset) for linux kernel 2.5/2.6
References: <1050146434.3e97f68300fff@netmail.pipex.net> <1050177383.3e986f67b7f68@netmail.pipex.net>
In-Reply-To: <1050177383.3e986f67b7f68@netmail.pipex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: PIPEX NetMail (IMP3.1)
X-Originating-IP: 195.166.116.245
X-PIPEX-Username: aozw65%dsl.pipex.com
X-Usage: PIPEX NetMail is subject to the standard PIPEX terms and conditions of use
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A while ago, I was banging on about kernel patches and whatnot to implement the 
equivalent of "pset" functionality. After some shoves/pointers from Robert and 
Miquel, I found that init(8) has the concept of an initscript(5), so that the 
trivial solution to my problem is to say:

#
# initscript   Executed by init(8) for every program it
#              wants to spawn like this:
#
#              /bin/sh /etc/initscript <id> <level> <action> <process>
#
taskset -p 1 $$
eval exec "$4"

and then modify the relevant programs to set their affinity to the other 
processors as required. Bingo!

Hope this helps, Shaheed

