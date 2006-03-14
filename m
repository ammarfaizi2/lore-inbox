Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWCNP5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWCNP5w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWCNP5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:57:52 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:55455 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750751AbWCNP5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:57:51 -0500
Date: Tue, 14 Mar 2006 07:57:47 -0800
From: Paul Jackson <pj@sgi.com>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Cc: linux-kernel@vger.kernel.org, kernel@wildsau.enemy.org
Subject: Re: procfs uglyness caused by "cat"
Message-Id: <20060314075747.64928d00.pj@sgi.com>
In-Reply-To: <200603141043.k2EAhlTV016354@wildsau.enemy.org>
References: <200603141043.k2EAhlTV016354@wildsau.enemy.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock explained what's wrong with your proposal of:
+	if (off)
+		return 0;

For an alternative that seems to work better, see the processing
behind the /proc/<pid>/cpuset file, by grep'ing for seq_file in
kernel/cpuset.c.

Essentially, it composes the result string on the open, and then
lets user code read and seek over that string at will.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
