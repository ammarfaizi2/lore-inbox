Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263007AbTC1Ovo>; Fri, 28 Mar 2003 09:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263008AbTC1Ovo>; Fri, 28 Mar 2003 09:51:44 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:4320 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S263007AbTC1Ovn>; Fri, 28 Mar 2003 09:51:43 -0500
Message-ID: <3E846410.90804@nortelnetworks.com>
Date: Fri, 28 Mar 2003 10:02:40 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: jlnance@unity.ncsu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: sendfile or r+w for sending file to multiple machines
References: <20030328142328.GA5242@ncsu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlnance@unity.ncsu.edu wrote:
> Hello All,
>     I have an application that needs to be able to send large files to
> multiple machines (less than 10).  The files get sent to the machines at
> the same time so we are thinking about writing the code so that it does
> 1 read (or perhaps a mmap) on the file, and then does multiple writes,
> onece to each machines socket.
>     We are also considering using multicast but this seems unnecessarily
> complex.  I dont want to reimplement TCP.

Given that your stated goal is to minimize disk reads, to me at least reading 
once and sending via TCP on multiple sockets seems to make sense, and is the 
only option that actually gives you direct control over the reads.

If it was an advantage for the receivers to have the file as soon as possible, 
you might be able to do slightly better by sending the whole file once as UDP to 
all listeners and then filling in the blanks later.  This way, some of the 
listeners would get the file on the first pass and not have to wait for the 
lowest common denominator.  You probably wouldn't gain much though.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

