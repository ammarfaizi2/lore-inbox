Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpCCiGxYJErKhRnKpaK0+16pL2g==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sat, 03 Jan 2004 16:53:16 +0000
Message-ID: <010001c415a4$20a21710$d100000a@sbs2003.local>
X-Mailer: Microsoft CDO for Exchange 2000
From: "Dmitry Torokhov" <dtor_core@ameritech.net>
To: <Administrator@osdl.org>
Subject: Re: [PATCH 1/7] i8042 suspend
Date: Mon, 29 Mar 2004 16:40:13 +0100
User-Agent: KMail/1.5.4
Content-Class: urn:content-classes:message
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
References: <200401030350.43437.dtor_core@ameritech.net> <200401030356.48071.dtor_core@ameritech.net> <20040103100347.GA499@ucw.cz>
In-Reply-To: <20040103100347.GA499@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:40:14.0671 (UTC) FILETIME=[210FA5F0:01C415A4]

On Saturday 03 January 2004 05:03 am, Vojtech Pavlik wrote:
> On Sat, Jan 03, 2004 at 03:56:45AM -0500, Dmitry Torokhov wrote:
> > diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> > --- a/drivers/input/serio/i8042.c	Sat Jan  3 03:07:29 2004
> > +++ b/drivers/input/serio/i8042.c	Sat Jan  3 03:07:29 2004
> > @@ -746,6 +746,29 @@
> >
> >
> >  /*
> > + * Reset the controller.
> > + */
> > +void i8042_controller_reset(void)
> > +{
> > +	if (i8042_reset) {
> > +		unsigned char param;
> > +
> > +		if (i8042_command(&param, I8042_CMD_CTL_TEST))
> > +			printk(KERN_ERR "i8042.c: i8042 controller reset timeout.\n");
> > +	}
>
> We should be checking the return value from the TEST command as well,
> if we want to use this to initialize the controller on non-x86
> platforms (where i8042.reset is 0).
>
> > -/*
> > - * Reset the controller.
> > - */
> > -
> > -	if (i8042_reset) {
> > -		unsigned char param;
> > +	i8042_controller_reset();
> > +}
> >
> > -		if (i8042_command(&param, I8042_CMD_CTL_TEST))
> > -			printk(KERN_ERR "i8042.c: i8042 controller reset timeout.\n");
> > -	}
>
> This actually introduces a bug, because we don't want to restore the
> CTR setting before we save it, which the new code does.
>

Hmm, I do not see it. i8042_controller_reset() is only called on suspend/
shutdown. The init path where we vigorously testing the hardware and saving
initial CTR value was left intact.

As far as checking the return value we usualy give some leniency on suspend/
shutdown and don't fail the entire process when there are non-clitical errors.

Or am I missing something?

Dmitry
