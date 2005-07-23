Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVGWLKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVGWLKr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 07:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVGWLKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 07:10:46 -0400
Received: from [216.208.38.107] ([216.208.38.107]:49280 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S261587AbVGWLKo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 07:10:44 -0400
Subject: Re: [PATCH] Add
	schedule_timeout_{interruptible,uninterruptible}{,_msecs}() interfaces
From: Arjan van de Ven <arjan@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
In-Reply-To: <Pine.LNX.4.61.0507231247460.3743@scrub.home>
References: <20050707213138.184888000@homer>
	 <20050708160824.10d4b606.akpm@osdl.org> <20050723002658.GA4183@us.ibm.com>
	 <1122078715.5734.15.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0507231247460.3743@scrub.home>
Content-Type: text/plain
Date: Sat, 23 Jul 2005 07:09:46 -0400
Message-Id: <1122116986.3582.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-23 at 12:50 +0200, Roman Zippel wrote:
> Hi,
> 
> On Fri, 22 Jul 2005, Arjan van de Ven wrote:
> 
> > Also I'd rather not add the non-msec ones... either you're raw and use
> > HZ, or you are "cooked" and use the msec variant.. I dont' see the point
> > of adding an "in the middle" one. (Yes this means that several users
> > need to be transformed to msecs but... I consider that progress ;)
> 
> What's wrong with using jiffies? 

A lot of the (driver) users want a wallclock based timeout. For that,
miliseconds is a more obvious API with less chance to get the jiffies/HZ
conversion wrong by the driver writer.

> It's simple and the current timeout 
> system is based on it. Calling it something else doesn't suddenly give you 
> more precision.

It's not about precision, it's about making the new API (which is
intended to be a simplification already due to sucking in the state
setting) match the intent closer.


