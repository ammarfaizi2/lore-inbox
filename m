Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbTFJSNo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTFJSNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:13:44 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:27152 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S261561AbTFJSNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:13:38 -0400
Date: Tue, 10 Jun 2003 20:27:01 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "David S. Miller" <davem@redhat.com>
cc: wa@almesberger.net, <chas@cmf.nrl.navy.mil>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
In-Reply-To: <20030609.163915.74729355.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0306101725220.5042-100000@serv>
References: <Pine.LNX.4.44.0306100113420.12110-100000@serv>
 <20030609.161435.104053652.davem@redhat.com> <Pine.LNX.4.44.0306100129460.12110-100000@serv>
 <20030609.163915.74729355.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 9 Jun 2003, David S. Miller wrote:

>    You also have to wait for the already running 
>    operations to finish, before you can allow the module to unload.
> 
> These things run under dev_base_lock, so either they find the device
> or they don't, and since they hold a spinlock they can't preempt.

dev_base_lock mostly protects the device list, but it doesn't protect the 
call of get_stats.
Anyway, I'm really not against these changes. Actually it's quite close to 
what I already proposed months ago. The basic idea was always to replace 
the global module lock with a device specific lock (which is needed for 
dynamic device management anyway) and to let the driver provide a module 
use count. This is not that different and it was rejected from Rusty and 
"really unfairly drove Rusty up a wall".
I look forward to progress in this area and maybe then it's easier to 
discuss how this can be generalized and applied to other parts of the 
kernel and maybe we can also compare it to that "stuff" I proposed which 
"stunk like pure shit". ;-)

bye, Roman

