Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132359AbREBIax>; Wed, 2 May 2001 04:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132372AbREBIap>; Wed, 2 May 2001 04:30:45 -0400
Received: from intellitel.com ([195.197.177.165]:43780 "EHLO intellitel.com")
	by vger.kernel.org with ESMTP id <S132359AbREBIac>;
	Wed, 2 May 2001 04:30:32 -0400
Posted-Date: Wed, 2 May 2001 11:30:30 +0300
Date: Wed, 2 May 2001 11:30:30 +0300
From: Tomi Lapinlampi <lapinlam@intellitel.com>
To: linux-kernel@vger.kernel.org
Subject: [PROBLEM] socket buffering problem in 2.2.19
Message-ID: <20010502113027.T29301@intellitel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

There seems to be some kind of a buffering problem in the 2.2.19
kernel. The following sequence of system calls on a nonblocking TCP 
socket (on the client side) generates a broken pipe:

    write(2) 	    HTTP REQUEST	read(2)
2. HTTP client  --------------------> HTTP Server

                    HTTP RESPONSE       write(2)
3. HTTP client <--------------------- HTTP Server

                                        shutdown(2), close(2)
4. HTTP client <--------------------- HTTP Server

    select(2) returns,
    read(2) => broken pipe, HTTP response is lost
5. HTTP client <----X

The client in this situation is a bit sluggish and sometimes does not have
time to read the data before the server has called shutdown and close
(and the client receives a TCP FIN).

The Linux 2.4.3 kernel and Solaris 7 & 8 seem to perform the buffering of
data ok on the client side.

Any ideas or suggestions ( other than upgrade to 2.4 :-) ) ?

Regards, Tomi

