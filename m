Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbULBQfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbULBQfy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 11:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbULBQfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 11:35:53 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:22405 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261666AbULBQft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 11:35:49 -0500
Message-ID: <41AF4460.2000404@nortelnetworks.com>
Date: Thu, 02 Dec 2004 10:35:44 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Vrabel <dvrabel@arcom.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Jiffy based timers/timeouts can expire too soon.
References: <41AF3D50.4090707@arcom.com>
In-Reply-To: <41AF3D50.4090707@arcom.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Vrabel wrote:
> Hi,
> 
> Jiffy based timers and timeouts can expire too soon because the timer 
> interrupt accounts for lost ticks and can increment jiffies by more than 1.

On the other hand, you also need to account for lost ticks for timers that 
started before interrupts were turned off, otherwise they could run for extra time.

It would be nice to have some kind of constant frequency timestamp that 
increments regardless of sleep state or interrupt status, so that sleep periods 
and such are based on timestamps rather than ticks (the period of which can vary).

Chris

