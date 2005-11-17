Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbVKQV52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVKQV52 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVKQV52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:57:28 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:41536 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932256AbVKQV52 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:57:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l2LUQqQMzVWE+vB06tFMObURyK/abj1z5NYGb8HyqcRTvlT6B+s+7QLaenrl80ujQDwwokeDXqXr1H1aZjDmdvfjf+FPUfXGYxZE9KFJi3e0dxLzz7h1e9njUHtT7m9oBWt9fOhUWC9EceLccCDW8yAxUxowpQUz2ZZecbfSpaU=
Message-ID: <d120d5000511171357g4d7a8d54hcc1c1d1cffa8856e@mail.gmail.com>
Date: Thu, 17 Nov 2005 16:57:27 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bmork@dod.no>
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>
In-Reply-To: <87zmoa0yv5.fsf@obelix.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <87zmoa0yv5.fsf@obelix.mork.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/05, Bjørn Mork <bmork@dod.no> wrote:
> IPv6 over IPv4 tunneling driver
> NET: Registered protocol family 17
> Using IPI Shortcut mode
> Stopping tasks: ===<6>Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2c6ab1, caps: 0x884793/0x0
> serio: Synaptics pass-through port at isa0060/serio1/input0
> input: SynPS/2 Synaptics TouchPad as /class/input/input1
>
>  stopping tasks failed (1 tasks remaining)
> Restarting tasks...<6> Strange, kseriod not stopped
>  done

Crazy idea - did you let it finish booting or you hit suspend as soon
as you could? It looks like kseriod was busy discovering your
touchpad/trackpoint for the first time...

Anyway, Pavel, I think 6 seconds it too short of a timeout for
stopping all tasks. PS/2 is pretty slow, trackpad reset can take up to
2 seconds alone...

Bjorn, does it help if you change TIMEOUT in kernel/power/process.c to 30 * HZ?

--
Dmitry
