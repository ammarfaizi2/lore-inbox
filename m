Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932694AbWHNURE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbWHNURE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 16:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbWHNURE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 16:17:04 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:5128 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932694AbWHNURD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 16:17:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jarf4Z53I4KlN9K1O+5qY/GF+ufhc1L+C+IrWSObGSXCCHp2aJ3mfNIpN/4qFmEJQqGq3xMjiDpn8duI2mQL3ABvZu9vUc7fUXI6VpE3uIQCL6Edwp107yK6hiGuqHwncRZvolwXZzNHfA1cL85M0DG/I8QGaPOEgL/UPFZ4Rn0=
Message-ID: <d120d5000608141317p50540cd5x5e8ec409dc9343ef@mail.gmail.com>
Date: Mon, 14 Aug 2006 16:17:01 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Giuseppe Bilotta" <bilotta78@hotpop.com>
Subject: Re: Polling for battery stauts and lost keypresses (was: Touchpad problems with latest kernels)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1q38ghnxvrliv$.zzgutgu0exkm$.dlg@40tude.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <BAY114-F2C4913B499BE3113C8E9BFA4E0@phx.gbl>
	 <200608141038.04746.gene.heskett@verizon.net>
	 <20060814152000.GA19065@rhlx01.fht-esslingen.de>
	 <d120d5000608140841q657c6c2euae986b37f6aff605@mail.gmail.com>
	 <20060814155437.GA801@rhlx01.fht-esslingen.de>
	 <d120d5000608140906x47bc572blb1b9821ead987d7e@mail.gmail.com>
	 <1q38ghnxvrliv$.zzgutgu0exkm$.dlg@40tude.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/06, Giuseppe Bilotta <bilotta78@hotpop.com> wrote:
> On Mon, 14 Aug 2006 12:06:06 -0400, Dmitry Torokhov wrote:
>
> > On many laptops (including mine) polling battery takes a loooong time
> > and is done in SMI mode in BIOS causing lost keypresses, jerky mouse
> > etc. It is pretty common problem. I think I have my ACPI client
> > refreshing every 3 minutes.
>
> BTW, polling battery status takes a lot on a Dell Inspiron 8200 too,
> and all keypresses and mouse movements (and I think even network
> IRQs?) are totally *dead* while polling.
>
> However, The Other OS(tm) *seems* to do it right enough to have no
> noticeable keypress losses, even when updating the battery status. Is
> it using different system calls, or what?
>

I am not sure, but there are many things that may affect it:

1. Battry attributes are divided into 2 groups - static (i think they
go into /proc/acpi/battery/<name>/info and dynamic
(/proc/acpi/batetry/state). Static attributes take really long time to
pull and they do not change so it may wery well be they are polled one
at startup. Dynamic attributes are cheaper to poll and even then OS
may cache access or limit rate.

2. Quite often there are OEM drivers that are tweaked to a specific
hardware and involve hardware-specific hacks.

-- 
Dmitry
