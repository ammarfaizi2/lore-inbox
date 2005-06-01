Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVFAPHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVFAPHV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVFAPHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:07:21 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24313 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261416AbVFAPFv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:05:51 -0400
Date: Wed, 1 Jun 2005 08:05:46 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
In-Reply-To: <429DCE15.76545CBD@tv-sign.ru>
Message-ID: <Pine.LNX.4.44.0506010756490.23057-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Oleg Nesterov wrote:

> Daniel Walker wrote:
> > 
> > On Wed, 1 Jun 2005, Oleg Nesterov wrote:
> > 
> > > fifo? 2
> > > fifo? 1
> > > fifo? 0
> > 
> > plist_for_each() wasn't designed to be FIFO , as you've discovered. That's
> > the slow method , you should test the fast method via pulling the nodes
> > off the front of the list.
> 
> Sorry, I don't understand you. Could you please explain this to me?

plist_for_each() was just created to walk through all the nodes in the 
list, There is no guaranteed ordering via that method. From your test it 
appeared to be working since you printed all the nodes you inserted.

There are other methods like plist_first() which will give you FIFO 
ordered nodes (or should) . The reason is that plist_first() pulls off the 
dp_node , which is the first node inserted at that priority. All the other 
nodes are inserted behind the dp_node. That's why I used list_add() and 
not list_add_tail()

In your case node "2" should have been the dp_node .


Daniel




