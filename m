Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWHGRfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWHGRfx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 13:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWHGRfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 13:35:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:3538 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932248AbWHGRfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 13:35:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C2v10HAbKqWlTLFIjrKOnqh1n5r8McowCE32rlweLZnpaymCB+iZG39RYmcHQ8Qigj+ioH72wExeHPNGUlVsLrulsu8pXwTZzwy0jnyaBF0CvtpvA265sa+qHyuAUWhDTkbZWQKxOsc5OQKGQtSsLZ678ZMQaDRlT0UrjPJuvgw=
Message-ID: <d120d5000608071035k2ec5b4ffu949a99ad4a8c3d66@mail.gmail.com>
Date: Mon, 7 Aug 2006 13:35:50 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] Crash on evdev disconnect.
In-Reply-To: <20060807155916.GE5472@aehallh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060807155916.GE5472@aehallh.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/7/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
>        if (evdev->open) {
>                input_close_device(handle);
>                wake_up_interruptible(&evdev->wait);
> -               list_for_each_entry(list, &evdev->list, node)
> +               list_for_each_entry_safe(list, next, &evdev->list, node)
>                        kill_fasync(&list->fasync, SIGIO, POLL_HUP);

NAK. kill_fasync does not affect the list state so using _safe does
not buy us anything.

BTW, dtor_core@ameritech.net address is dead, please use
dmitry.torokhov@gmail.com or dtor@mail.ru or dtor@isightbb.com.

-- 
Dmitry
