Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317426AbSGDPF3>; Thu, 4 Jul 2002 11:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317427AbSGDPF2>; Thu, 4 Jul 2002 11:05:28 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:40599 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S317426AbSGDPF1>; Thu, 4 Jul 2002 11:05:27 -0400
Message-ID: <3D246392.7030807@quark.didntduck.org>
Date: Thu, 04 Jul 2002 11:02:42 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal
References: <12364.1025755693@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On Wed, 03 Jul 2002 22:25:34 -0400, 
> Brian Gerst <bgerst@didntduck.org> wrote:
> 
>>Why not treat a module just like any other structure?  Obtain a 
>>reference to it _before_ using it.
> 
> 
> That is what try_inc_use_count() does.  But the interface is messy and
> difficult to audit.  It relies on the caller taking some other lock
> first to ensure that the module address will not change while you are
> trying to call try_inc_use_count.

And that is almost always the case anyways, since most cases traverse a 
linked list that must already be protected.  You are trying to 
overengineer a solution to a simple, but subtle, problem.

PS.  If you really want to make the broken cases show themselves, poison 
the module memory when it is unloaded.  The same can be done for dumping 
init data and text.

--
				Brian Gerst

