Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVCWXQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVCWXQg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVCWXQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:16:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58009 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261479AbVCWXQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:16:29 -0500
Message-ID: <4241F8BA.6070108@pobox.com>
Date: Wed, 23 Mar 2005 18:16:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernard Blackham <bernard@blackham.com.au>
CC: Matt <matt@signalz.com>, linux-kernel@vger.kernel.org
Subject: Re: Promise SX8 performance issues and CARM_MAX_Q
References: <20050323175707.GA10481@blackham.com.au>
In-Reply-To: <20050323175707.GA10481@blackham.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernard Blackham wrote:
> Hi,
> 
> Playing with a recently acquired Promise SX8 card, we've found
> similar performance results to Matt's post to lkml a few months back
> at http://marc.theaimsgroup.com/?l=linux-kernel&m=110175890323356&w=2
> 
> It appears that the driver is only submitting one command at a time
> per port, which is at least one cause of the slowdowns. By raising
> CARM_MAX_Q from 1 to 3 in drivers/block/sx8.c (it was 3 in an
> earlier pre-merge incarnation of carmel.c), we're getting very
> notable speed improvements, with no side effects just yet.
> 
> Knowing very little about what this change has actually done, I've a
> few questions: 
> 
>  - Should this be considered dangerous?
>  - Why was it taken from 3 to 1?
>  - Is CARM_MAX_Q a number defined (or limited) by the hardware?

In multi-port stress tests, we couldn't get SX8 to function reliably 
without locking up or corrupting data, with more than one outstanding 
command.

Maybe a new firmware has solved this by now.

	Jeff



