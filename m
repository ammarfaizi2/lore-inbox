Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbUAJAAT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 19:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbUAJAAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 19:00:19 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:60168 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S264245AbUAJAAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 19:00:17 -0500
Date: Sat, 10 Jan 2004 01:01:28 +0100
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.1 sendfile regression
Message-ID: <20040110000128.GA301@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting a huge sendfile regression in 2.6.1; when serving a large
file on an IPv4 TCP socket via sendfile64, the transfer starts at about
4 MB (2.6.0: >7 MB) and the hard disk like stays on 100% (which normally
only happens if the file is badly fragmented, fragmentation of this file
is 0%).  Then, suddenly, the network performance drops dramatically,
getting worse and worse.  strace shows that the process is hanging
inside sendfile64 (which should not happen since the socket is
non-blocking).  The process then stays inside sendfile for up to a
minute or so and can't be interrupted or killed in that time.

Please fix!

Felix
