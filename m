Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751655AbWKGTTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbWKGTTv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 14:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbWKGTTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 14:19:51 -0500
Received: from bay0-omc2-s4.bay0.hotmail.com ([65.54.246.140]:63792 "EHLO
	bay0-omc2-s4.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1751655AbWKGTTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 14:19:49 -0500
Message-ID: <BAY20-F50109D67E42239D2B911AD8F20@phx.gbl>
X-Originating-IP: [80.178.105.247]
X-Originating-Email: [yan_952@hotmail.com]
In-Reply-To: <d120d5000611061418i65f27cd6w1c60692aff8bd1b1@mail.gmail.com>
From: "Burman Yan" <yan_952@hotmail.com>
To: dmitry.torokhov@gmail.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, khali@linux-fr.org
Subject: Re: [PATCH] HP Mobile data protection system driver with interrupt handling
Date: Tue, 07 Nov 2006 21:19:44 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 07 Nov 2006 19:19:48.0895 (UTC) FILETIME=[B12E72F0:01C702A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
>To: "Andrew Morton" <akpm@osdl.org>
>CC: "Burman Yan" <yan_952@hotmail.com>, linux-kernel@vger.kernel.org, "Jean 
>Delvare" <khali@linux-fr.org>
>Subject: Re: [PATCH] HP Mobile data protection system driver with interrupt 
>handling
>Date: Mon, 6 Nov 2006 17:18:53 -0500
>
>On 11/6/06, Andrew Morton <akpm@osdl.org> wrote:
>>On Fri, 03 Nov 2006 18:33:31 +0200
>>"Burman Yan" <yan_952@hotmail.com> wrote:
>> > +
>> > +static unsigned int mouse = 0;
>>
>>The `= 0' is unneeded.
>>
>> > +module_param(mouse, bool, S_IRUGO);
>> > +MODULE_PARM_DESC(mouse, "Enable the input class device on module 
>>load");
>
>Does the parameter have to be called "mouse"? I'd rename it to "input"
>and drop the work "class" from parameter description.

Dropping the "class" seems logical, but calling the parameter input
seems confusing to me - to a user that doesn't want to read too much
manual/code and just wants to play around with the device (I do that 
sometimes)
mouse sounds more reasonable to me.

>
>> > +
>> > +     if (input_register_device(mdps.idev)) {
>> > +             input_free_device(mdps.idev);
>> > +             mdps.idev = NULL;
>> > +             return;
>> > +     }
>> > +
>> > +     mdps.kthread = kthread_run(mdps_mouse_kthread, NULL, "kmdps");
>> > +     if (IS_ERR(mdps.kthread)) {
>> > +             input_unregister_device(mdps.idev);
>> > +             mdps.idev = NULL;
>> > +             return;
>> > +     }
>> > +
>
>Please consider implementing mdps_input_open() and mdps_input_close()
>and create and run the polling thread from there - there is no point
>in polling the device if noone listens to its events.

You have a point - I'll see into that.

>
>--
>Dmitry

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

