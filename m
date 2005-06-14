Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVFNKyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVFNKyV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 06:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVFNKyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 06:54:21 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:9738 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261178AbVFNKyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 06:54:17 -0400
Message-ID: <42AEB756.2030809@etpmod.phys.tue.nl>
Date: Tue, 14 Jun 2005 12:54:14 +0200
From: Bart Hartgers <bart@etpmod.phys.tue.nl>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gzip zombie / spawned from init
References: <20050614085436.GA1467@schottelius.org>
In-Reply-To: <20050614085436.GA1467@schottelius.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius wrote:
> Hello!
> 
> I wrote an init replacement (cinit), which is now in the beta-phase.
> The only problem I do have currently is that when calling
> 'loadkeys dvorak' directly from init (without a shell or anything)
> it will leave behind a gzip zombie (which was forked by loadkeys).
> 
> Now my question is: Is that a problem of loadkeys or from my init
> and what could be the reasons that it's still there?

Not really a kernel issue but:

Yes and no. If a parent exits before its child, the child is reparented 
to init. loadkeys probably doesn't wait properly for gzip to finish.

> 
> cinit forks() loadkeys and does waitpid() for it. There is no
 > loadkeys zombie, only gzip.

Use waitpid(-1,...) or wait(...) to wait on all childeren in your init. 
gzip will become a child of cinit.

Groeten,
Bart
-- 
Bart Hartgers - TUE Eindhoven - http://plasimo.phys.tue.nl/bart/contact/
