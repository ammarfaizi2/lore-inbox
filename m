Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbVAPCjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbVAPCjP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 21:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVAPCjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 21:39:15 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:1992 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262393AbVAPCjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 21:39:00 -0500
Date: Sun, 16 Jan 2005 03:38:44 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Karim Yaghmour <karim@opersys.com>
cc: Andi Kleen <ak@muc.de>, Nikita Danilov <nikita@clusterfs.com>,
       linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <41E899AC.3070705@opersys.com>
Message-ID: <Pine.LNX.4.61.0501160245180.30794@scrub.home>
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>
 <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de>
 <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home>
 <41E8358A.4030908@opersys.com> <Pine.LNX.4.61.0501150101010.30794@scrub.home>
 <41E899AC.3070705@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 14 Jan 2005, Karim Yaghmour wrote:

> > Why should a subsystem care about the details of the buffer management?
> 
> Because it wants to enforce a data format on buffer boundaries.

It's interesting to read more about ltt's requirements, but I still think 
it's possible to leave this work to the relayfs layer.
Why not just move the ltt buffer management into relayfs and provide a 
small library, which extracts the event stream again? Otherwise you have 
to duplicate this work for every serious relayfs user anyway.
Completely abstracting the buffer management would the make whole 
interface simpler and it would be a lot easier to change without breaking 
everything. E.g. it would be possible to use per cpu buffers and remove 
the need for different locking mechanisms, for a good tracing mechanism 
it's not just important that it's lockless, but also that the cpus don't 
share cache lines in the fast path. In this regard relayfs/ltt has really 
still too much overhead and the complex relayfs API isn't really making it 
easy to fix this.

bye, Roman
