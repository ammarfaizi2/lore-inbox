Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWC1ScJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWC1ScJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 13:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWC1ScJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 13:32:09 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:61598 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751248AbWC1ScF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 13:32:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=oGSbES/tVo8BZjNMyl43+WfRUQtSfnmBu7vLa/N9Tel9atlLjMcLaLYUxZrHEA0BBnuQ3J0OoEgfPRMfRURvVeIfAtWpnt7Z5s+f5ZPgkGxc9tclclowuJTwsfjPR2kfwvnKHABQNCqjbLPDKkjI3Bk9bsMvDX5N/Y6KvTOeO9k=
Date: Tue, 28 Mar 2006 13:31:40 -0500
To: Stas Sergeev <stsp@aknet.ru>
Cc: 7eggert@gmx.de, dtor_core@ameritech.net,
       Linux kernel <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
Message-ID: <20060328183140.GA21446@nineveh.rivenstone.net>
Mail-Followup-To: Stas Sergeev <stsp@aknet.ru>, 7eggert@gmx.de,
	dtor_core@ameritech.net,
	Linux kernel <linux-kernel@vger.kernel.org>, vojtech@suse.cz
References: <5TCqf-E6-49@gated-at.bofh.it> <5TCqf-E6-51@gated-at.bofh.it> <5TCqf-E6-53@gated-at.bofh.it> <5TCqg-E6-55@gated-at.bofh.it> <5TCqf-E6-47@gated-at.bofh.it> <E1FMv1A-0000fN-Lp@be1.lrz> <44266472.5080309@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44266472.5080309@aknet.ru>
User-Agent: Mutt/1.5.9i
From: jfannin@gmail.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 01:52:50PM +0400, Stas Sergeev wrote:
> Bodo Eggert wrote:
>>>The problem is that the snd-pcsp doesn't replace pcspkr.

>>If that's the problem, create a minimal input driver that will signal the
>>snd-pcsp to beep, and change the original pcspkr to include
>>"(Non-ALSA)".

> Yes, making snd-pcsp to produce the console beeps and
> making it mutually exclusive with pcspkr is possible.
> But I think it is undesireable. People that don't like
> the console beeps (myself included) simply do not load
> the pcspkr module right now. If snd-pcsp is to produce
> the beeps, then not loading pcspkr will not get the desired
> effect any more, and the only possibility would be to,
> probably, add the separate mixer control for the beeps.
> I find this counter-intuitive: some people will be able to
> disable the beeps by simply not loading pcspkr, while for
> others this will suddenly magically stop working. This may
> lead to a few unnecessary bug reports and confusions.

    My laptop already has such a mixer control (and it works too,
though it does depend on pcspkr being loaded).  Have there been bug
reports about PC speakers that don't work because the PC speaker mixer
control was not unmuted?  Well, probably, but it's not a new
situation.

    It doesn't seem unreasonable to me to expect users to configure
their PC speaker beep preference through the ALSA mixer when
configuring the PC speaker to be an audio device.

    I would think the ideal situation would be to make every ALSA
device capable of acting as the console bell (defaulting to muted,
like every other ALSA mixer control).  Then only pcspkr would be the
odd case (though maybe a common one).

    I dunno if there's a reasonably easy way to do that (without
changing every ALSA driver) though.
--
Joseph Fannin
jfannin@gmail.com

"That's all I have to say about that." -- Forrest Gump.
