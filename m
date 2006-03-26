Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWCZKwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWCZKwp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 05:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWCZKwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 05:52:45 -0500
Received: from mail.aknet.ru ([82.179.72.26]:39182 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751260AbWCZKwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 05:52:44 -0500
Message-ID: <44266472.5080309@aknet.ru>
Date: Sun, 26 Mar 2006 13:52:50 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de
Cc: dtor_core@ameritech.net, Linux kernel <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
References: <5TCqf-E6-49@gated-at.bofh.it> <5TCqf-E6-51@gated-at.bofh.it> <5TCqf-E6-53@gated-at.bofh.it> <5TCqg-E6-55@gated-at.bofh.it> <5TCqf-E6-47@gated-at.bofh.it> <E1FMv1A-0000fN-Lp@be1.lrz>
In-Reply-To: <E1FMv1A-0000fN-Lp@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Bodo Eggert wrote:
>> The problem is that the snd-pcsp doesn't replace pcspkr.
> If that's the problem, create a minimal input driver that will signal the
> snd-pcsp to beep, and change the original pcspkr to include "(Non-ALSA)".
Yes, making snd-pcsp to produce the console beeps and
making it mutually exclusive with pcspkr is possible.
But I think it is undesireable. People that don't like
the console beeps (myself included) simply do not load
the pcspkr module right now. If snd-pcsp is to produce
the beeps, then not loading pcspkr will not get the desired
effect any more, and the only possibility would be to,
probably, add the separate mixer control for the beeps.
I find this counter-intuitive: some people will be able to
disable the beeps by simply not loading pcspkr, while for
others this will suddenly magically stop working. This may
lead to a few unnecessary bug reports and confusions.

I think I'd better try to code up the grabbing capability in
the input layer, since Dmitry didn't seem to object to that.

