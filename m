Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWJ3NBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWJ3NBp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 08:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWJ3NBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 08:01:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:53160 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964797AbWJ3NBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 08:01:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=EjFMqJ2VQ56Bk7+hSx7B0kUBUZOm6xDv8rsfK69scvid9MFSyW0Adip1XPnA7XNb4e+skv1aLCIq4mIN0+auhQ3AfL2Zt8LSnYKnZ0NJ+RawWHxsXz27cGn7HaeDDqHbfld2Iis4Du0SAAhmplN8oI2fVQq3oTD9+tQGTqeF8m8=
Message-ID: <161717d50610300501w240a8ce1h4d58b1f3f2f759bf@mail.gmail.com>
Date: Mon, 30 Oct 2006 08:01:42 -0500
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: [RFT/PATCH] i8042: remove polling timer (v6)
Cc: "Dmitry Torokhov" <dtor@insightbb.com>,
       LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20061030090851.GA2687@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608232311.07599.dtor@insightbb.com>
	 <161717d50610291520i5076901blf8bf253eba6148cc@mail.gmail.com>
	 <200610292234.02487.dtor@insightbb.com>
	 <20061030090851.GA2687@suse.cz>
X-Google-Sender-Auth: 727b87ff33a2c688
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Sun, Oct 29, 2006 at 10:34:00PM -0500, Dmitry Torokhov wrote:
> > Hi Dave,
> >
> > i8042_interrupt() uses spinlock to serialize access to the KBC so if real
> > interrupt happens before we call i8042_interrupt() manually (and it should
> > normally happen) it will just process the response and second i8042_interrupt()
> > will be just a no-op.
>
> This would, however, create two reads of the i8042 controller
> back-to-back, which has been a problem on old i8042's: IIRC IBM
> documentation states that between the reads there should be a delay.
>

Maybe I'm missing something, (well actually I'm sure I'm missing
somethng). Looking at the code again, it's unclear to me why there is
even a call to the ISR in i8042_aux_write, since the latter function
already calls i8042_read_data.

Dave
