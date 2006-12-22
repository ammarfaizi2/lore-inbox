Return-Path: <linux-kernel-owner+w=401wt.eu-S1752638AbWLVUkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbWLVUkY (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 15:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbWLVUkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 15:40:24 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:29137 "HELO
	smtp110.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752638AbWLVUkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 15:40:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=JBtvyy1ED0+39FfrrYaeTWkiOvvLtKWcZX3aq9D+zCuRuUa9PME4tZa5EV5/AFcWiJO9gjZxoQ4PQvVTYbUr9JcugPkt11af5A26y3oEhfpx49UVtddhAK4j0D0QYevF4w9zfdSr+Oc4YQodTXrr5203apz6/SMIeqBnYya15TY=  ;
X-YMail-OSG: Q9bDJisVM1mxG1uIBTEHvFsHtKcbxK8RTMnx7ZVf9CvKBhhOvgX3F2GXRMGVp29eizhiFQE7ntPSMrEBYEktHJMcjzXOJqNAq2Z9W9OOnQBpVf1FdLULTO0Hr1Vet2YHca3tWmNCZVNqWGw-
From: David Brownell <david-b@pacbell.net>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [patch 2.6.20-rc1 6/6] input: ads7846 directly senses PENUP state
Date: Fri, 22 Dec 2006 12:40:20 -0800
User-Agent: KMail/1.7.1
Cc: nicolas.ferre@rfo.atmel.com, linux-kernel@vger.kernel.org,
       imre.deak@solidboot.com
References: <20061222192536.A206A1F0CDB@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <d120d5000612221235g3df0167bx9b1e6664dadf138d@mail.gmail.com>
In-Reply-To: <d120d5000612221235g3df0167bx9b1e6664dadf138d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612221240.20768.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 December 2006 12:35 pm, Dmitry Torokhov wrote:
> On 12/22/06, David Brownell <david-b@pacbell.net> wrote:
> >
> > +static void ads7846_report_pen_state(struct ads7846 *ts, int down)
> > +{
> > +       struct input_dev        *input_dev = ts->input;
> > +
> > +       input_report_key(input_dev, BTN_TOUCH, down);
> > +       if (!down)
> > +               input_report_abs(input_dev, ABS_PRESSURE, 0);
> > +#ifdef VERBOSE
> > +       pr_debug("%s: %s\n", ts->spi->dev.bus_id, down ? "DOWN" : "UP");
> > +#endif
> > +}
> > +
> > +static void ads7846_report_pen_position(struct ads7846 *ts, int x, int y,
> > +                                       int pressure)
> > +{
> > +       struct input_dev        *input_dev = ts->input;
> > +
> > +       input_report_abs(input_dev, ABS_X, x);
> > +       input_report_abs(input_dev, ABS_Y, y);
> > +       input_report_abs(input_dev, ABS_PRESSURE, pressure);
> > +
> > +#ifdef VERBOSE
> > +       pr_debug("%s: %d/%d/%d\n", ts->spi->dev.bus_id, x, y, pressure);
> > +#endif
> > +}
> > +
> > +static void ads7846_sync_events(struct ads7846 *ts)
> > +{
> > +       struct input_dev        *input_dev = ts->input;
> > +
> > +       input_sync(input_dev);
> > +}
> 
> I think these helpers just obfuscate the code, just call
> input_report_*() and input_sync() drectly like you used to do.

Fair enough, I had a similar thought.  Imre, could you do that update?


> 
> -- 
> Dmitry
> 
