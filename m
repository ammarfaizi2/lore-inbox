Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVFNLeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVFNLeF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 07:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVFNLeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 07:34:05 -0400
Received: from main.gmane.org ([80.91.229.2]:62942 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261187AbVFNLeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 07:34:01 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: gzip zombie / spawned from init
Date: Tue, 14 Jun 2005 13:32:33 +0200
Message-ID: <yw1xvf4h6uni.fsf@ford.inprovide.com>
References: <20050614085436.GA1467@schottelius.org> <42AEB756.2030809@etpmod.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:cwmVGPmCDQONsp1Nobd0n0JmPLM=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Hartgers <bart@etpmod.phys.tue.nl> writes:

> Nico Schottelius wrote:
>> Hello!
>> I wrote an init replacement (cinit), which is now in the beta-phase.
>> The only problem I do have currently is that when calling
>> 'loadkeys dvorak' directly from init (without a shell or anything)
>> it will leave behind a gzip zombie (which was forked by loadkeys).
>> Now my question is: Is that a problem of loadkeys or from my init
>> and what could be the reasons that it's still there?
>
> Not really a kernel issue but:
>
> Yes and no. If a parent exits before its child, the child is
> reparented to init. loadkeys probably doesn't wait properly for gzip
> to finish.
>
>> cinit forks() loadkeys and does waitpid() for it. There is no
>  > loadkeys zombie, only gzip.
>
> Use waitpid(-1,...) or wait(...) to wait on all childeren in your
> init. gzip will become a child of cinit.

In fact, init must reap any zombies that are reparented to it.
Otherwise, the system will sooner or later run out of PIDs.  There are
a lot of misbehaving programs out there, and even if they were all
well-behaved, they could be killed before having waited for their
children, leaving zombies behind.

-- 
Måns Rullgård
mru@inprovide.com

