Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbUBUBUi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 20:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUBUBUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 20:20:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:37046 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261466AbUBUBUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 20:20:37 -0500
Date: Fri, 20 Feb 2004 17:22:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: "John Chatelle" <johnch@medent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High read Latency test (Anticipatory I/O scheduler)
Message-Id: <20040220172229.736cb249.akpm@osdl.org>
In-Reply-To: <20040220202023.M9162@medent.com>
References: <20040220202023.M9162@medent.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John Chatelle" <johnch@medent.com> wrote:
>
> #StreamingRead.sh       --simple 4 line shell script:
>    while true
>    do
>      cat ../data/oneGBfile >/dev/null
>    done
> 
> #WHR.sh                -- simple 2 (or 3) line shell script.
>    StreamingRead.sh &
>    time find /usr/src/linux-2.4.20-18.7  -type f -exec cat \
>      '{}' ';' > /dev/null

Note that the latter test runs `cat' once per file: over ten thousand
times.  You should also test:

	time  (find /usr/src/linux-2.4.20-18.7 -type f | xargs cat > /dev/null )

which will run `cat' only some tens of times.

For the anticipatory scheduler, this makes a significant difference - the
run-cat-once-per-file problem has specific fixes and perhaps they're not
working right at present.

And yes, please describe your disk system, tell us the tag depth (if it is
scsi) and try Nick's patch, thanks.

