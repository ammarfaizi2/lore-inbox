Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269174AbRHBWMw>; Thu, 2 Aug 2001 18:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269177AbRHBWMm>; Thu, 2 Aug 2001 18:12:42 -0400
Received: from teranet244-12-200.monarch.net ([24.244.12.200]:55282 "HELO
	lustre.clusterfilesystem.com") by vger.kernel.org with SMTP
	id <S269174AbRHBWMd>; Thu, 2 Aug 2001 18:12:33 -0400
Date: Thu, 2 Aug 2001 16:12:14 -0600
From: "Peter J. Braam" <braam@clusterfilesystem.com>
To: tux-list@redhat.com, intermezzo-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: large & fragmented TUX requests
Message-ID: <20010802161214.E1498@lustre.clusterfilesystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I am working on a protocol handler for InterMezzo.  This is a kernel
level protocol handler than can unpack DAFS style packets and service
the requests.

I have two basic questions about the code (looking at 2.4.6-3.1)

1) input.c

If a request arrives in multiple pieces, req->proto->parse_message
returns 0 and read_request is called multiple times.  Why is read
request not overwriting data that was already received?

2) large requests

Some of the RPC's I want to handle are for receiving file data. Would
it make sense when it is known that a large page aligned buffer with
file data is coming, to simply allocate buffers of the right size (say
up to 64K max) and point req->req_headers at it?

In that way I can read the chunk in and later map the pages into a
file to get it to disk.  

There is no standard "recv_file" (ala sendfile) api, right? 

Thanks for pointers and thoughts.

- Peter -
