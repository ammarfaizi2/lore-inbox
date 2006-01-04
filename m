Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751513AbWADAsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWADAsD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 19:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWADAsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 19:48:02 -0500
Received: from cantor2.suse.de ([195.135.220.15]:21422 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751513AbWADAsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 19:48:00 -0500
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] [RFC] Optimize select/poll by putting small data sets on the stack
Date: Wed, 4 Jan 2006 01:48:42 +0100
User-Agent: KMail/1.8
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200601032158.14057.ak@suse.de> <200601040028.40633.arnd@arndb.de> <43BB1A29.7090102@cosmosbay.com>
In-Reply-To: <43BB1A29.7090102@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601040148.42765.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 01:43, Eric Dumazet wrote:

> And I would like to pinpoint that set_fd_set() implementation seems *buggy*
> :
>
> It should not use __copy_to_user() but the real one (copy_to_user())
> because the calling thread could have slept in do_select() and another
> thread played mm games during this sleep.

__ only skips the access_ok which checks the kernel/user boundary, and the 
kernel/user boundary doesn't change even while sleeping.

On very early 386s it did something more to work around a CPU bug, but that is 
racy on multithreaded processes in any case. Not really worth caring about.

Also I doubt any such machines are left in working condition. That old 
workaround code could be probably safely removed by now.

-Andi
