Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263519AbTDNQNR (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 12:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263524AbTDNQNR (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 12:13:17 -0400
Received: from franka.aracnet.com ([216.99.193.44]:57988 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263519AbTDNQNR (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 12:13:17 -0400
Date: Mon, 14 Apr 2003 09:24:45 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Antonio Vargas <wind@cocodriloo.com>
cc: Timothy Miller <tmiller10@cfl.rr.com>, linux-kernel@vger.kernel.org,
       nicoya@apia.dhs.org
Subject: Re: Quick question about hyper-threading (also some NUMA stuff)
Message-ID: <14860000.1050337484@[10.10.2.4]>
In-Reply-To: <20030414155748.GD14552@wind.cocodriloo.com>
References: <001301c3028a$25374f30$6801a8c0@epimetheus> <10760000.1050332136@[10.10.2.4]> <20030414152947.GB14552@wind.cocodriloo.com> <12790000.1050334744@[10.10.2.4]> <20030414155748.GD14552@wind.cocodriloo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Perhaps it would be good to un-COW pages:
>> > 
>> > 1. fork process
>> > 2. if current node is not loaded, continue as usual
>> > 3. if current node is loaded:
>> > 3a. pick unloaded node
>> > 4b. don't do COW for data pages, but simply copy them to node-local memory
>> > 
>> > This way, read-write sharings would be replicated for each node.
>> 
>> Sharing read-write stuff is a total nightmare - you have to deal with
>> all the sync stuff, and invalidation. In real-life scenarios, I really
>> doubt the complexity is worth it - read-only is quite complex enough,
>> thanks ;-) 
> 
> I mean MAP_PRIVATE stuff, not MAP_SHARED.

OK, unless I misunderstand you, I think that happens naturally for that
kind of thing - when we do the COW split, we'll get a node-local page
by default (unless the local node is out of memory).

M.

