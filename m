Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUBWHb1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 02:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbUBWHb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 02:31:27 -0500
Received: from moutvdom.kundenserver.de ([212.227.126.249]:251 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261188AbUBWHbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 02:31:25 -0500
From: Martin <marogge@onlinehome.de>
Reply-To: marogge@onlinehome.de
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Badness in pci_find_subsys
Date: Mon, 23 Feb 2004 08:30:44 +0100
User-Agent: KMail/1.6
Cc: vishwas.manral@lycos.com, "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
References: <DMOCIEPNKDKOLIAA@mailcity.com> <200402230639.00737.robin.rosenberg.lists@dewire.com>
In-Reply-To: <200402230639.00737.robin.rosenberg.lists@dewire.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402230830.45003.marogge@onlinehome.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 February 2004 06:39, Robin Rosenberg wrote:

> > I was checking the pci documentation and it said under the heading
> > Obsolete function pci_find_subsys() - Superseded by pci_get_subsys() as
> > the former is not Hot plug safe. Could this be related to the problem
>
> You WHAT? Read the documentation! :-) I thought the ones calling the
> function should do that.

Reading the documentation (ie. source code) it appears the problem is 
triggered by the line

WARN_ON(in_interrupt());

Looks like the driver calls pci_find_subsys() from inside an interrupt on 
occasions which apparently it shouldn't. The problem seems to be on 
nvidia's side, not kernel development. I have emailed nvidia about it some 
time ago, so far no reaction... 

I got the problem with nvidia modules 4496, 5328, 5336 and with kernels 
2.6.0, 2.6.1, 2.6.2, never with 2.4.X. I have stopped using the nvidia 
kernel module for now.

> I found some options to try out, but no conclusive info, at the nvidia
> linux discussion forum.

Is this www.nvnews.net you are talking about? I can't find any proper 
contacts on the nvidia web site. I'll go over and add a comment right 
now. ;-)

cu Martin
