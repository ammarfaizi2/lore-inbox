Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWGENn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWGENn3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 09:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWGENn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 09:43:29 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:45745
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S964865AbWGENn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 09:43:28 -0400
Message-ID: <44ABC14F.70004@microgate.com>
Date: Wed, 05 Jul 2006 08:40:31 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
CC: Pete@sc8-sf-spam2-b.sourceforge.net,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, Zaitcev <zaitcev@redhat.com>,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [linux-usb-devel] Serial-Core: USB-Serial port current issues.
References: <20060613192829.3f4b7c34@home.brethil>	<20060614152809.GA17432@flint.arm.linux.org.uk>	<20060620161134.20c1316e@doriath.conectiva>	<20060620193233.15224308.zaitcev@redhat.com>	<20060621133500.18e82511@doriath.conectiva>	<20060621164336.GD24265@flint.arm.linux.org.uk>	<20060621181513.235fc23c@doriath.conectiva>	<20060622082939.GA25212@flint.arm.linux.org.uk>	<20060623142842.2b35103b@home.brethil>	<20060626222628.GC29325@suse.de>	<1151369349.2600.19.camel@localhost.localdomain> <20060704164257.03e70301@doriath.conectiva>
In-Reply-To: <20060704164257.03e70301@doriath.conectiva>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luiz Fernando N. Capitulino wrote:
> |   take mutex
> |   take port lock
> | again:
> |   save local copy of icount
> |   release port lock
> |   get_mctrl
> |   take port lock
> |   if (icount changed)
> |     goto again
> |   update tty->hw_stopped
> |   release port lock
> |   release mutex
> 
>  Well, I think it'd work. But how can we keep track of 'icount'?
> Should the driver add 1 if it updates 'tty->hw_stopped'?

The only thing about icount that needs to be
tracked is that it changes, which indicates
an interrupt might have changed hw_stopped.
If icount changes at all, invalidate the last
reading of the state and do it again. The way
icount is incremented is not changed.

Like I said, it is really ugly. I was just looking
for a way of allowing get_mctrl to sleep if necessary.

-- 
Paul Fulghum
Microgate Systems, Ltd.
