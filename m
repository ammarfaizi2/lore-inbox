Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAOSe1>; Mon, 15 Jan 2001 13:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbRAOSeS>; Mon, 15 Jan 2001 13:34:18 -0500
Received: from [62.254.209.2] ([62.254.209.2]:62455 "EHLO cam-gw.zeus.co.uk")
	by vger.kernel.org with ESMTP id <S129431AbRAOSeL>;
	Mon, 15 Jan 2001 13:34:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14947.17050.127502.936533@leda.cam.zeus.com>
Date: Mon, 15 Jan 2001 18:34:02 +0000
From: Jonathan Thackray <jthackray@zeus.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.30.0101150753010.30402-100000@twinlark.arctic.org>
In-Reply-To: <14947.5703.60574.309140@leda.cam.zeus.com>
	<Pine.LNX.4.30.0101150753010.30402-100000@twinlark.arctic.org>
X-Mailer: VM 6.89 under 21.1 (patch 3) "Acadia" XEmacs Lucid
Organization: Zeus Technology Ltd
X-Tel: +44 1223 525000
X-Fax: +44 1223 525100
X-Url: http://www.zeus.com/
X-Scanner: exiscan *14IESA-0004Ud-00*NeOFWPCmGQQ* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> how would sendpath() construct the Content-Length in the HTTP header?

You'd still stat() the file to decide whether to use sendpath() to
send it or not, if it was Last-Modified: etc. Of course, you'd cache
stat() calls too for a few seconds. The main thing is that you save
a valuable fd and open() is expensive, even more so than stat().

> TCP_CORK is useful for FAR more than just sendfile() headers and
> footers.  it's arguably the most correct way to write server code.

Agreed -- the hard-coded Nagle algorithm makes no sense these days.

> imnsho if you want to optimise static file serving then it's pretty
> pointless to continue working in userland.  nobody is going to catch up
> with all the kernel-side implementations in linux, NT, and solaris.

Hmmm, there's a place for userland httpds that are within a few
percent of kernel ones (like Zeus is, when I last looked). But I
agree, hybrid approaches will become more common, although the trend
towards server-side dynamic pages negate this. A kernel approach is a
definite win if you're used to using a limited-scalability userland
httpd like Apache.

Jon.

-- 
Jonathan Thackray         Zeus House, Cowley Road, Cambridge CB4 OZT, UK
Software Engineer                   +44 1223 525000, fax +44 1223 525100
Zeus Technology                                     http://www.zeus.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
