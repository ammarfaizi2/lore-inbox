Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270852AbTHFRZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 13:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270854AbTHFRZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 13:25:10 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:54257 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S270852AbTHFRXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 13:23:42 -0400
Subject: Re: [RFC][PATCH] linux-2.6.0-test2_mtrr-race-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: Mathias =?ISO-8859-1?Q?Fr=F6hlich?= <Mathias.Froehlich@web.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200308061052.18550.Mathias.Froehlich@web.de>
References: <200308061052.18550.Mathias.Froehlich@web.de>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1060190104.10732.52.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Aug 2003 10:15:05 -0700
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-06 at 01:52, Mathias Fröhlich wrote:
> Hi,
> 
> You should not remove the barrier past mtrr change. If you do that, it is 
> possible that cpu's run with inconsistent mtrrs. This can have bad 
> sideeffects since at least the cache snooping protocol used by intel uses 
> assumptions about the cachability of memory regions. Those information about 
> the cachability is also taken from the mtrrs as far as I remember.
> This intel cpu developer manual, which documented the early PII and PPro 
> chips, recommended this algorithm. Since actual intel cpus use the same old 
> cpu to chipset bus protocol, this old documentation most propably still 
> applies.

Hmm. I should dig up that doc. Its a little hazy in my mind, but I think
I understand your description. I'm glad you caught this, as I can't
imagine the subtle bugs that might have popped up. 

Well, let me look at it again and see if I can come up with a proper
fix. 

Thanks for the knowledgeable feedback and sanity checking!
-john

