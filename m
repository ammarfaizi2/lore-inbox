Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262684AbTCYPei>; Tue, 25 Mar 2003 10:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262687AbTCYPei>; Tue, 25 Mar 2003 10:34:38 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:37768 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id <S262684AbTCYPeg>;
	Tue, 25 Mar 2003 10:34:36 -0500
Date: Tue, 25 Mar 2003 15:45:39 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Poor performance with pcnet32 on SMP
In-Reply-To: <3E7B5B41.2070308@us.ibm.com>
Message-ID: <Pine.LNX.4.53.0303251538230.22295@skynet>
References: <Pine.LNX.4.53.0303202346220.3340@skynet> <3E7B5B41.2070308@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Mar 2003, Dave Hansen wrote:

> I have no problems copying between two 2.5.65 machines.  In fact, my
> speeds are ~10 MBytes/sec.  (yes, megabytes)
>

I lied, I didn't give up. This struck a chord with me for some reason. I
have the following

A - 2.5 SMP machine
B - 2.4 UP machine on *same* subnet as A
C - Web server on different subnet, behind firewall but same LAN

I have a 10MB file that I dd'd from /dev/zero on the webserver

wget http://C/~mel/10mb_file

Speed starts at 7kB/s and drops slowly to a crawl. Down with that sort of
thing. I set up a port forwarder (called aproxy) on machine B that
forwards port 80 on B to port 80 on C and try the wget again.

wget http://B/~mel/10mb_file (obviously this forwarding to machine C)

Download starts at 30kB/s and maintains it. A wget from B to C can
download at about 50kB/s but I am assuming that it is related to port
forwarding overhead as much as anything else. I am not sure what this
result means but I thought it was significant. It would seem that as well
as being SMP related, connecting to a different subnet or connecting
through a firewall is also significant.

-- 
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel
