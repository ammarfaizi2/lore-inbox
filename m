Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269396AbUJFQqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269396AbUJFQqX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 12:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269386AbUJFQm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 12:42:57 -0400
Received: from relay.pair.com ([209.68.1.20]:38149 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S269417AbUJFQZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 12:25:54 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <41640F8B.8060009@kegel.com>
Date: Wed, 06 Oct 2004 08:30:19 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davem@davemloft.net
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Incorrect UDP checksums could cause the read data to
> be discarded.  We do the copy into userspace and checksum
> computation in parallel.  This is totally legal and we've
> been doing it since 2.4.x first got released.

Might there be a similar effect for packets with bad IP or TCP checksums?
(http://citeseer.ist.psu.edu/stone00when.html)

And as Bert says, Stevens mentions that with TCP accepts,
the other side might close before you call accept.

BTW this is why I insisted in JSR-51 that Java's NIO not allow
the use of Selector with blocking sockets:

http://java.sun.com/j2se/1.4.2/docs/api/java/nio/channels/SelectableChannel.html
"A channel must be placed into non-blocking mode before being
registered with a selector, and may not be returned to blocking mode until it has been deregistered."

So at least Java programs that use NIO are immune to this
particular user error (unless your implementation of NIO
relaxes this sanity check, tsk).

- Dan

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
