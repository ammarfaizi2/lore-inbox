Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbVAZQin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbVAZQin (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVAZQim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:38:42 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:11057 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262351AbVAZQgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:36:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=BIkwtiLa7nWCZvViMsNP3ePOpOEMgYa6nVE3wtyK9z/qX6savfsT8j0/EhnNti5AryO8LD53KQK1omXoa0xRuj0R4sVKFPa+3z9ny7RlYpFU0eSxTyxAZpjVEuQsX2CY6lSAUEFLxoJo1dpz29ZkaPqSRL3hIu/jKbc2/MMVQEo=
Message-ID: <d120d5000501260836686003d7@mail.gmail.com>
Date: Wed, 26 Jan 2005 11:36:41 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: i8042 access timings
Cc: linux-input@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050126154307.GB4422@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200501250241.14695.dtor_core@ameritech.net>
	 <20050126154307.GB4422@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005 16:43:07 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Tue, Jan 25, 2005 at 02:41:14AM -0500, Dmitry Torokhov wrote:
> > @@ -213,7 +217,10 @@
> >       if (!retval)
> >               for (i = 0; i < ((command >> 8) & 0xf); i++) {
> >                       if ((retval = i8042_wait_read())) break;
> > -                     if (i8042_read_status() & I8042_STR_AUXDATA)
> > +                     udelay(I8042_STR_DELAY);
> > +                     str = i8042_read_status();
> []
> > +                     udelay(I8042_DATA_DELAY);
> > +                     if (str & I8042_STR_AUXDATA)
> >                               param[i] = ~i8042_read_data();
> >                       else
> >                               param[i] = i8042_read_data();
> 
> We may as well drop the negation. It's a bad way to signal the data came
> from the AUX port. Then we don't need the extra status read and can just
> proceed to read the data, since IMO we don't need to wait inbetween,
> even according to the IBM spec.

Do you remember why it has been done to begin with?

-- 
Dmitry
