Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTDGJAT (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 05:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTDGJAS (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 05:00:18 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:27373 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S263354AbTDGJAQ (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 05:00:16 -0400
Date: Mon, 7 Apr 2003 10:09:15 +0100
From: Malcolm Beattie <mbeattie@clueful.co.uk>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new syscall: flink
Message-ID: <20030407100915.A2493@clueful.co.uk>
References: <3E907A94.9000305@kegel.com> <200304062156.37325.oliver@neukum.org> <1049663559.1602.46.camel@dhcp22.swansea.linux.org.uk> <b6qo2a$ecl$1@cesium.transmeta.com> <b6qnr6$s4h$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <b6qnr6$s4h$1@abraham.cs.berkeley.edu>; from daw@mozart.cs.berkeley.edu on Mon, Apr 07, 2003 at 02:29:58AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wagner writes:
> H. Peter Anvin wrote:
> >Alan Cox wrote:
> >> Suppose I give you an O_RDONLY handle to a file which you then
> >> flink and gain write access too ?
> >
> >This, I believe, is the real issue.  However, we already have that
> >problem:
> 
> No, I don't think we already have that problem.  I think flink()
> would introduce a new security hole not already present.

Here's another example along similar lines: you can open a file
O_APPEND and pass the descriptor along to another process (e.g. a
security mediator process that hands out a file descriptor to a
less-trusted recipient that it can use for appending entries only).
fcntl() explicity prevents the clearing of the O_APPEND flag on a
file which was opened with O_APPEND. With flink, one could flink()
and re-open without O_APPEND: security hole.

--Malcolm

-- 
Malcolm Beattie <mbeattie@clueful.co.uk>
