Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264375AbUD0WQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbUD0WQd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 18:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbUD0WQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 18:16:33 -0400
Received: from main.gmane.org ([80.91.224.249]:59313 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264375AbUD0WQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 18:16:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Moritz Muehlenhoff <jmm@informatik.uni-bremen.de>
Subject: Re: [BUG] DVD writing in 2.6.6-rc2
Date: Wed, 28 Apr 2004 00:16:40 +0200
Organization: Cocytus
Message-ID: <8n23m1-g22.ln1@legolas.mmuehlenhoff.de>
References: <1083088772.2679.11.camel@tiger> <20040427183607.GA3011@suse.de>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p50869d16.dip.t-dialin.net
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>> I have a problem when using growisofs version 5.19.
>> 
>> The problem is that in the very end when gowisofs tries to flush the
>> cache. When stracing the process I can see it sits in a call to poll
>> that never returns. 
>
> I noted the same thing yesterday with cdrdao, so yours is not an
> isolated incident. I'll debug it tomorrow.

I can confirm this bug for kernel 2.6.3-rc4 as well, so it's not too recent.
I found the following on my console after quitting k3b ungracefully, maybe
it's useful for narrowing down the problem:

Message from syslogd@gandalf at Tue Apr 27 22:45:53 2004 ...
gandalf kernel: MCE: The hardware reports a non fatal, correctable incident occu
rred on CPU 0.

Message from syslogd@gandalf at Tue Apr 27 22:45:53 2004 ...
gandalf kernel: Bank 2: 940040000000017a

gandalf:/root# Mutex destroy failure: Device or resource busy
gandalf:/root# ICE default IO error handler doing an exit(), pid = 17846, errno = 0
ICE default IO error handler doing an exit(), pid = 17791, errno = 2

