Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751894AbWCNR7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbWCNR7p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 12:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752323AbWCNR7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 12:59:45 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:48576 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751845AbWCNR7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 12:59:45 -0500
Date: Tue, 14 Mar 2006 09:59:40 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Rolland" <rol@witbe.net>
Cc: hancockr@shaw.ca, kernel@wildsau.enemy.org, linux-kernel@vger.kernel.org
Subject: Re: procfs uglyness caused by "cat"
Message-Id: <20060314095940.7be639e7.pj@sgi.com>
In-Reply-To: <001901c6477c$a46b4c90$b600a8c0@cortex>
References: <4416D4A3.9070705@shaw.ca>
	<001901c6477c$a46b4c90$b600a8c0@cortex>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Rolland wrote:
> is funny enough...

You used the stdio routine fread - which buffers in user space.  It
does a single read, and then feeds you the characters as you ask for
them, out of its stdio buffer.

Try the following program, which doesn't buffer:

main()
{
    char c;
    int fd = open("/proc/uptime", 0);
    while (read(fd, &c, 1) == 1) {
        write(1, &c, 1);
        sleep(1);
    }
}

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
