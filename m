Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268347AbUIBPGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268347AbUIBPGo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 11:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUIBPGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 11:06:44 -0400
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:59281 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268347AbUIBPGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 11:06:13 -0400
From: Stuart Young <cef-lkml@optusnet.com.au>
To: linux-kernel@vger.kernel.org, Rohit Neupane <rohitneupane@gmail.com>
Subject: Re: Weird Problem with TCP
Date: Fri, 3 Sep 2004 01:06:23 +1000
User-Agent: KMail/1.7
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <93e09f0104090202216403c08d@mail.gmail.com> <1094122617.4966.0.camel@localhost.localdomain> <93e09f0104090206334a708289@mail.gmail.com>
In-Reply-To: <93e09f0104090206334a708289@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409030106.24476.cef-lkml@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004 23:33, Rohit Neupane wrote:
> On Thu, 02 Sep 2004 11:56:59 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> 
wrote:
> > > * Everything works fine for about 5-10 mins then all of a sudden TCP
> > > services are not accessable.
> > > * For some reason TCP times out. However at the same time
> > > ping,traceroute and dns trace works without any problem.
> > > * The connected TCP sokets keeps working without any problem. I
> > > verified this by using Msn chat. I observerd that I chat session (
> > > which I had started when everything was normal) continued without any
> > > problem however I was not able to initiate a new chat session.
> >
> > Are you using session tracking. The symptoms you describe are
> > classically those of session tracking nat/firewalling/whatever running
> > out of table entries and being unable to allow new connections.
>
> No, it is not running any session tracking (ip_conntrack) neither it
> does nat. It is just a firewall with around 1600 rules in FORWARD
> mangle table and around 1500 rules in FORWARD filter table. Out of
> 1500 rules , 1377 rules are MAC filter rules.
> And it had 3 alias address for the interface conneted to the wirelss.

EEEEK! 1600? That is insane!

Consider cutting your rules into sections, and jumping to other tables to do 
sections of the work. Perhaps you can filter on the start of the MAC address 
and break this into smaller sections?

Also of note: MAC addresses are easily spoofed, so if you're using this to 
lock out people on wireless, forget it, it doesn't work. Get them to use 
tunnels (eg: ipsec) instead. The only real way MAC addresses even sort of 
work is when you're providing a hotspot, ie: where you can't guarantee the 
client to have anything apart from base wireless, and you should therefore 
keep a tight leash on users connections by either timing them out regularly, 
or making them keep open a https:// page to a login/AAA server (ie: a page 
that auto-refreshes - when they stop refreshing the page, consider their 
connection stale).

-- 
 Stuart Young (aka Cef)
 cef-lkml@optusnet.com.au is for LKML and related email only
