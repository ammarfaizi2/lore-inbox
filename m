Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWATQiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWATQiv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWATQiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:38:51 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:55667 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751069AbWATQiu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:38:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SdmhGwFvu26sHhHMUDrF4N9lCLTls/XLWEKgom7MPeZAFvu9qV6ELdyyp6HLeZLYEgiGmf0W60AF4CXiHY/+QwxfHxlN6DtCacoDxaQMMLJAeWhXpqresa2T7Bk5r5kp6lw+914GtPgZ/Xt0apawXNCXCuT1g5EBiSFJPk3g/L0=
Message-ID: <d120d5000601200838s702db8c6p4bbc6924dcebe6c1@mail.gmail.com>
Date: Fri, 20 Jan 2006 11:38:49 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Ernst Rohlicek jun." <ernst.rohlicek@inode.at>
Subject: Re: 2.6.16_rc1 psmouse hangs without KVM
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43D10CA9.4030307@inode.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43D10CA9.4030307@inode.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/06, Ernst Rohlicek jun. <ernst.rohlicek@inode.at> wrote:
>
> Hello list,
>
>
> My first post to the linux-kernel mailing list - a little report on
> mouse hang experiences on a PS/2 mouse :-)
>
>
> Since the change from 2.6.14 to 2.6.16_rc1, I got mouse hangs using a
> first-generation MS IntelliEye Explorer with USB->PS2 converter, no KVM,
> which ran smoothly on the official 2.6.14.
>
>
> The syslog message is ...
>
>   psmouse.c: resync failed, issuing reconnect request
>
> and I have the exact symptoms - hang after about 10 sec mouse
> inactivity, then after 2 secs it's back to normal - as described in the
> thread ...
>

Ok, we need to fix that... Please to the following:

echo -n 5 > /sys/bus/serio/devices/serioX/resync_time
echo 1 > /sys/modules/i8042/parameters/debug
... wait 10 seconds ...
move the mouse slightly
... wait another 10 seconds ...
move the mouse slighty again
echo 0 > /sys/modules/i8042/parameters/debug

and send me your dmesg (or better /var/log/messages or whatever file
you use for kernel messages).

Thanks!

--
Dmitry
