Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVCGCIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVCGCIs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 21:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVCGCHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 21:07:47 -0500
Received: from www.rapidforum.com ([80.237.244.2]:25580 "HELO rapidforum.com")
	by vger.kernel.org with SMTP id S261625AbVCGCHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 21:07:25 -0500
Message-ID: <422BB755.1020507@rapidforum.com>
Date: Mon, 07 Mar 2005 03:07:17 +0100
From: Christian Schmid <webmaster@rapidforum.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com> <422BAAC6.6040705@candelatech.com>
In-Reply-To: <422BAAC6.6040705@candelatech.com>
Content-Type: multipart/mixed;
 boundary="------------030705020307070000000509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030705020307070000000509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

> I have a tool that can also generate TCP traffic on a large number of
> sockets.  If I can understand what you are trying to do, I may be able
> to reproduce the problem.  My biggest machine at present has only
> 2GB of RAM, however...not sure if that matters or not.

But if the problem is what I think it is, you should get the problem by doing the following.

Best use 2.6.11 since the problem got even worse there compared to 2.6.10.

Create a server on one machine. This server should wait for incoming sockets and when they come, 
just send out bytes ("x" or whatever, it just doesn't matter) to that sockets. Please use a 
send-buffer of 64 kbytes.

On the other machine you just create clients, which connect to the server and read the data. They 
just need to read them, nothing more. Please limit the reading to once per 300 ms, so they only read 
around 200 kb/sec each. Then watch your traffic as you create more sockets. When you reach 2000 
sockets on 2.6.11, it should slow down more and more. You should see the same like me on the 
attached graph.

First one 2.6.11, second one 2.6.10

Chris

--------------030705020307070000000509
Content-Type: image/png;
 name="traffic3.png"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="traffic3.png"

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
--------------030705020307070000000509--
