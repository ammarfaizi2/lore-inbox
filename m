Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267028AbSKLXUf>; Tue, 12 Nov 2002 18:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267029AbSKLXUe>; Tue, 12 Nov 2002 18:20:34 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:13039 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S267028AbSKLXUd>; Tue, 12 Nov 2002 18:20:33 -0500
Message-ID: <3DD19332.1050703@kegel.com>
Date: Tue, 12 Nov 2002 15:48:02 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: re: [PATCH] new timeout behavior for RPC requests on TCP sockets
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck wrote:
> make RPC timeout behavior over TCP sockets behave more like reference
> client implementations.  reference behavior is to transmit the same
> request three times at 60 second intervals; if there is no response, close
> and reestablish the socket connection.  we modify the Linux RPC client as
> follows:
> 
> +  after a minor retransmit timeout, use the same timeout value when
>    retrying on a TCP socket rather than doubling the value
> +  after a major retransmit timeout, close the socket and attempt
>    to reestablish a fresh TCP connection
> 
> note that today mount uses a 6 second timeout with 5 retries for NFS over
> TCP by default; proper default behavior is 2 retries each with 60 second
> timeouts.  a separate patch for mount is pending.

Chuck, can you briefly explain why RPC does any minor
retransmits at all over TCP?
Shouldn't TCP's natural retransmit take care of that?
- Dan

