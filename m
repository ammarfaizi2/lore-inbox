Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318719AbSIFP0k>; Fri, 6 Sep 2002 11:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318735AbSIFP0k>; Fri, 6 Sep 2002 11:26:40 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:59061 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318719AbSIFP0i>;
	Fri, 6 Sep 2002 11:26:38 -0400
Message-ID: <3D78C9BD.5080905@us.ibm.com>
Date: Fri, 06 Sep 2002 08:29:01 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020822
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: "David S. Miller" <davem@redhat.com>, hadi@cyberus.ca,
       tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <20020905.204721.49430679.davem@redhat.com> <18563262.1031269721@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> Just to throw another firework into the fire whilst people are 
> awake, NAPI does not seem to scale to this sort of load, which
> was disappointing, as we were hoping it would solve some of 
> our interrupt load problems ... seems that half the machine goes
> idle, the number of simultaneous connections drop way down, and
> everything's blocked on ... something ... not sure what ;-)
> Any guesses at why, or ways to debug this?

I thought that I already tried to explain this to you.  (although it could 
have been on one of those too-much-coffee-days :)

Something strange happens to the clients when NAPI is enabled on the 
Specweb clients.  Somehow the start using a lot more CPU.  The increased 
idle time on the server is because the _clients_ are CPU maxed.  I have 
some preliminary oprofile data for the clients, but it appears that this is 
another case of Specweb code just really sucking.

The real question is why NAPI causes so much more work for the client.  I'm 
not convinced that it is much, much greater, because I believe that I was 
already at the edge of the cliff with my clients and NAPI just gave them a 
little shove :).  Specweb also takes a while to ramp up (even during the 
real run), so sometimes it takes a few minutes to see the clients get 
saturated.
-- 
Dave Hansen
haveblue@us.ibm.com

