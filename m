Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265966AbUGIUEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbUGIUEf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 16:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265959AbUGIUDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 16:03:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:12710 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265955AbUGIUB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 16:01:57 -0400
Date: Fri, 9 Jul 2004 13:00:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesse Stockall <stockall@magma.ca>
Cc: s.rivoir@gts.it, linux-kernel@vger.kernel.org, stern@rowland.harvard.edu
Subject: Re: 2.6.7-mm7
Message-Id: <20040709130045.211b6d50.akpm@osdl.org>
In-Reply-To: <1089402736.8067.12.camel@homer.blizzard.org>
References: <20040708235025.5f8436b7.akpm@osdl.org>
	<40EE5418.2040000@gts.it>
	<20040709024112.7ef44d1d.akpm@osdl.org>
	<40EE732C.5020404@gts.it>
	<1089373506.8067.7.camel@homer.blizzard.org>
	<20040709115411.23d96699.akpm@osdl.org>
	<1089402736.8067.12.camel@homer.blizzard.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Stockall <stockall@magma.ca> wrote:
>
> On Fri, 2004-07-09 at 14:54, Andrew Morton wrote:
>                        down_write_trylock(&usb_all_devices_rwsem));
>  > 
>  > That's a bit unusual.  Could you (or Alan) please explain the reason for
>  > this a little more?
> 
>  I believe you want this thread
> 
>  http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108923404032264&w=2

Oh, OK.  Recursively taking an rwsem for reading is certainly deadlocky. 
The main reason for not supporting this is that heavy down_read() traffic
can trivially livelock down_write() waiters.  Alan's patch will introduce
that shortcoming.

Really, it would be better to get the locking sorted out.
