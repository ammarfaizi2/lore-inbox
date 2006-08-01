Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751763AbWHASVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbWHASVm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWHASVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:21:41 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:2603 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751763AbWHASVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:21:41 -0400
Message-ID: <44CF9BAD.5020003@emc.com>
Date: Tue, 01 Aug 2006 14:21:33 -0400
From: Ric Wheeler <ric@emc.com>
Reply-To: ric@emc.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <200607312314.37863.bernd-schubert@gmx.de>	 <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>	 <20060801165234.9448cb6f.reiser4@blinkenlights.ch> <1154446189.15540.43.camel@localhost.localdomain>
In-Reply-To: <1154446189.15540.43.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.4.0.264935, Antispam-Data: 2006.8.1.105433
X-PerlMx-Spam: Gauge=, SPAM=2%, Reasons='EMC_FROM_0+ -2, __CP_MEDIA_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Maw, 2006-08-01 am 16:52 +0200, ysgrifennodd Adrian Ulrich:
> 
>>WriteCache, Mirroring between 2 Datacenters, snapshotting.. etc..
>>you don't need your filesystem beeing super-robust against bad sectors
>>and such stuff because:
> 
> 
> You do it turns out. Its becoming an issue more and more that the sheer
> amount of storage means that the undetected error rate from disks,
> hosts, memory, cables and everything else is rising.


I agree with Alan despite being an enthusiastic supporter of neat array 
based technologies.

Most people use absolutely giant disks in laptops and desktop systems 
(300GB & 500GB are common, 750GB on the way). File systems need to be as 
robust as possible for users of these systems as people are commonly 
storing personal "critical" data like photos mostly on these unprotected 
drives.

Even for the high end users, array based mirroring and so on can only do 
so much to protect you.

Mirroring a corrupt file system to a remote data center will mirror your 
corruption.

Rolling back to a snapshot typically only happens when you notice a 
corruption which can go undetected for quite a while, so even that will 
benefit from having "reliability" baked into the file system (i.e., it 
should grumble about corruption to let you know that you need to roll 
back or fsck or whatever).

An even larger issue is that our tools, like fsck, which are used to 
uncover these silent corruptions need to scale up to the point that they 
can uncover issues in minutes instead of days.  A lot of the focus at 
the file system workshop was around how to dramatically reduce the 
repair time of file systems.

In a way, having super reliable storage hardware is only as good as the 
file system layer on top of it - reliability needs to be baked into the 
entire IO system stack...

ric


