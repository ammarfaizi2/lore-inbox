Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWADAnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWADAnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 19:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWADAnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 19:43:24 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:55756 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751173AbWADAnW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 19:43:22 -0500
Message-ID: <43BB1A29.7090102@cosmosbay.com>
Date: Wed, 04 Jan 2006 01:43:21 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] Optimize select/poll by putting small data sets
 on the stack
References: <200601032158.14057.ak@suse.de> <200601040028.40633.arnd@arndb.de>
In-Reply-To: <200601040028.40633.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann a écrit :
> Interestingly, doing a diff between sys_select and compat_sys_select
> in the current kernel seems to suggest that they are both buggy
> in that they miss checks for failing __put_user, but in /different/
> places.

And I would like to pinpoint that set_fd_set() implementation seems *buggy* :

It should not use __copy_to_user() but the real one (copy_to_user()) because 
the calling thread could have slept in do_select() and another thread played 
mm games during this sleep.

Eric
