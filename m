Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267841AbUJONhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267841AbUJONhJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267776AbUJONfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:35:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43708 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267777AbUJONco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:32:44 -0400
Message-ID: <416FD177.1050404@redhat.com>
Date: Fri, 15 Oct 2004 09:32:39 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Tasklet usage?
References: <416FCD3E.8010605@drzeus.cx>
In-Reply-To: <416FCD3E.8010605@drzeus.cx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> My driver needs to spend a lot of time inside the interrupt handler 
> (draining a FIFO). I suspect this might cause problems blocking other 
> interrupt handlers so I was thinking about moving this into a tasklet.
> Not being to familiar with tasklets, a few questions pop up.
> 
> * Will a tasklet scheduled from the interrupt handler be executed as 
> soon as interrupt handling is done?
I don't _think_ they are guaranteed to be executed immediately after the 
  interrupt handler top half is complete, but they will execute before 
the next return to user space (read: they will complete before user 
processes run again).

> * Can tasklets be preempted?
A tasklet can get preempted by a hard interrupt, but tasklets run in 
interrupt context, so don't do anything in a tasklet that can call schedule.
> * If a tasklet gets scheduled while running, will it be executed once 
> more? (Needed if I get another FIFO interrupt while the tasklet is just 
> exiting).
> 
IIRC, a tasklet will execute once for every time tasklet_schedule is called.

HTH
Neil

-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
