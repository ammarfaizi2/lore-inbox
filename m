Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266762AbTGFXsd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 19:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266769AbTGFXsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 19:48:30 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:15845 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266762AbTGFXs3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 19:48:29 -0400
Message-ID: <3F08B7E2.7040208@us.ibm.com>
Date: Sun, 06 Jul 2003 16:59:30 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Albrecht <palbrecht@qwest.net>
CC: linux-kernel@vger.kernel.org, netdev <netdev@oss.sgi.com>
Subject: Re: question about linux tcp request queue handling
References: <3F08858E.8000907@us.ibm.com> <001a01c3441c$6fe111a0$6801a8c0@oemcomputer>
In-Reply-To: <001a01c3441c$6fe111a0$6801a8c0@oemcomputer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Albrecht wrote:

> My server program sets its backlog to one and pauses ninety seconds before
> accepting connections.  Within that ninety second interval, I start three
> client programs that do an active open to my server.  I expect one of
> connections to get discarded when the server's connection backlog limit is
> exceeded.

We actually have two queues - the syn queue and the socket
acccept queue. We move the connection request from the syn
queue to the accept queue of the socket once the 3 way
handshake is complete - i.e. once the state is ESTABLISHED.

If the syn queue is full, requests will get dropped and
the socket will not change state.

When you set a the backlog to 1 in the listen call, what is
being capped is the accept queue. So I would expect your
server to allow only one of those requests in the accept
queue, and the kernel will drop the other two requests.

Actually, details, but we also apply some other conditions
before we actually drop the connection request - we try not to be
so harsh if the syn queue is still fairly empty..

Think thats so, at any rate :).

Nivedita




