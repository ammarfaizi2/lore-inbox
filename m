Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317985AbSGWHyQ>; Tue, 23 Jul 2002 03:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317986AbSGWHyQ>; Tue, 23 Jul 2002 03:54:16 -0400
Received: from pat.uio.no ([129.240.130.16]:16091 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317985AbSGWHyP>;
	Tue, 23 Jul 2002 03:54:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: odd memory corruption in 2.5.27?
Date: Tue, 23 Jul 2002 09:57:19 +0200
User-Agent: KMail/1.4.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alexander Viro <viro@math.psu.edu>
References: <Pine.LNX.4.44.0207230824590.32636-100000@linux-box.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.44.0207230824590.32636-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207230957.19812.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 July 2002 08:26, Zwane Mwaikambo wrote:
> Hi Trond, Arnaldo, Al
> 	I tried reproducing using a local filesystem and couldn't
> (machine survived 3 make -j10 kernel compiles). Here is another oops for
> the collection. Al i'll remove you from further CCs now.
>
> client: 2.5.27-serial, 3c905B
> server: 2.4.19-pre5-ac3, 3c905B
> connection: 100Mb/FD
>
> I got this message before it oopsed;
> RPC: garbage, exit EIO

Just means that some RPC message reply from the server was crap. We should 
deal fine with that sort of thing...

AFAICS The Oops itself happened deep down in the socket layer in the part 
which has to do with reassembling fragments into packets. The garbage 
collector tried to release a fragment that had timed out and Oopsed.

Suggests either memory corruption or else that the networking driver is doing 
something odd ('cos at that point in the socket layer *only* the driver + the 
fragment handler should have touched the skb).

Cheers,
  Trond
