Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVA1N6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVA1N6Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 08:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVA1N6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 08:58:16 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:10203 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261362AbVA1N6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 08:58:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=SQssfOkMqCXCq0nRL9f43lgwHzVzrRXLDPTRsveIVN2xMp0UAo3fh6yXquKl1WWQ/yEtxXZiadw75Va+ylDt28a25V4YEmew8q5IuqHD9+1Nrx2UOhs2bqqVuoU5AEmlJ0Oprr2B8TChscNn4ABkK9fkZ59hD5CD7yfh0loo0Og=
Message-ID: <d120d500050128055837df3a93@mail.gmail.com>
Date: Fri, 28 Jan 2005 08:58:10 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Olaf Hering <olh@suse.de>
Subject: Re: atkbd_init lockup with 2.6.11-rc1
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
In-Reply-To: <20050128132202.GA27323@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050128132202.GA27323@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 14:22:02 +0100, Olaf Hering <olh@suse.de> wrote:
> 
> My IBM RS/6000 B50 locks up with 2.6.11rc1, it dies in atkbd_init():
> 
> Calling initcall 0xc03c272c: atkbd_init+0x0/0x38()
> ps2_init(224) swapper(1):c0,j4294680939 enter
> atkbd_connect(793) swapper(1):c0,j4294680993 type 1000000
> serio_open(606) swapper(1):c0,j4294681061 enter
> serio_set_drv(594) swapper(1):c0,j4294681117 enter
> serio_set_drv(600) swapper(1):c0,j4294681176 leave
> i8042_write_command(69) swapper(1):c0,j4294681236 enter
> i8042_write_data(62) swapper(1):c0,j4294681236 enter
> serio_open(614) swapper(1):c0,j4294681363 leave0
> atkbd_probe(497) swapper(1):c0,j4294681421 enter
> ps2_command(91) swapper(1):c0,j4294681478 enter
> ps2_sendbyte(57) swapper(1):c0,j4294681534 enter
> serio_write(95) swapper(1):c0,j4294681591 write c01b65ac
> i8042_aux_write(253) swapper(1):c0,j4294681658 enter
> i8042_write_command(69) swapper(1):c0,j4294681720 enter
> i8042_write_data(62) swapper(1):c0,j4294681720 enter
> 
> Any idea how to fix it? There is no keyboard or mouse detected. I think
> it works ok on ppc64, Anton did not complain yet.
> 

Hi,

It looks like it is hanging in checking AUX, while writing data into
controller. It is simple outb but it is stuck... Could you please
reboot with i8042.debug boot option and resend the log. Also, you may
try booting with i8042.noaux to check if keyboard alone works.

-- 
Dmitry
