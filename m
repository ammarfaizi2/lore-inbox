Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269418AbUJFRDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269418AbUJFRDo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 13:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269390AbUJFRDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 13:03:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42630 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269421AbUJFQ7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 12:59:06 -0400
Message-ID: <4164240E.1070706@redhat.com>
Date: Wed, 06 Oct 2004 12:57:50 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: Chris Friesen <cfriesen@nortelnetworks.com>, root@chaos.analogic.com,
       joris@eljakim.nl, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>	<20041006080104.76f862e6.davem@davemloft.net>	<Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>	<20041006082145.7b765385.davem@davemloft.net>	<41640FE2.3080704@nortelnetworks.com> <20041006084128.38e9970d.davem@davemloft.net>
In-Reply-To: <20041006084128.38e9970d.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Wed, 06 Oct 2004 09:31:46 -0600
> Chris Friesen <cfriesen@nortelnetworks.com> wrote:
> 
> 
>>David S. Miller wrote:
>>
>>
>>>So if select returns true, and another one of your threads
>>>reads all the data from the file descriptor, what would you
>>>like the behavior to be for the current thread when it calls
>>>read?
>>
>>What about the single-threaded case?
> 
> 
> Incorrect UDP checksums could cause the read data to
> be discarded.  We do the copy into userspace and checksum
> computation in parallel.  This is totally legal and we've
> been doing it since 2.4.x first got released.
> 
> Use non-blocking sockets with select()/poll() and be happy.


I think you could also pass the MSG_ERRQUEUE flag to the recvfrom call 
and receive the errored frame, eliminating the case where errored frames 
might cause you to block on a read after a good return from a select call.
Neil
-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
