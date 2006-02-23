Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWBWM21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWBWM21 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 07:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWBWM21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 07:28:27 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:57942 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751081AbWBWM21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 07:28:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=LTXS31KXUViXSDKolO2YMjFnpig1Sc3/N/CPdSpKKq6O5bXAeq+3aQ5LpZEDHQHYFxnkWSaB34O+jdb7VbNF37Bt5oiiMz8qDwIUUs1jX0+WZzHYkT3AVUoYT0J4ajnqPr9DyzDma/lt4YR0HMpg+2eP5vC491+GP5bZp802amI=  ;
Message-ID: <43FDA8DD.2000500@yahoo.com.au>
Date: Thu, 23 Feb 2006 23:21:49 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Emmanuel Pacaud <emmanuel.pacaud@univ-poitiers.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: isolcpus weirdness
References: <1140614487.13155.20.camel@localhost.localdomain>
In-Reply-To: <1140614487.13155.20.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Pacaud wrote:
> Hi,
> 
> When specifying isolcpus kernel parameters, isolated cpu is always the
> same, not the one I asked for.
> 
> I'm working with a dual xeon machine, with linux kernel 2.6.15
> (unpatched, from kernel.org), hyperthreading desactivated (number of cpu
> = 2). I've tried to isolate cpu1, using isolcpus, but I always end with
> cpu0 isolated, even with isolcpus=1. With invalid isolcpus argument
> (cpuid > 1), no cpu is isolated, which is ok.
> 
> You'll find below content of /proc/version, /proc/cpuinfo, the output of
> dmesg, and a snapshot of top when running 3 cpuburn processes.
> 
> What's wrong ?
> 

If you have 2 CPUs, and "isolate" one of them, the other is isolated
from it. Ie. there is no difference between isolating one or the other,
the net result is that they are isolated from each other.

This means that the scheduler will never automatically move a task
running on an isolated CPU to another CPU. You have to move all the
tasks manually, for example by using cpu affinity.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
