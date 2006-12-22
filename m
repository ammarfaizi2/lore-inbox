Return-Path: <linux-kernel-owner+w=401wt.eu-S1751583AbWLVUf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWLVUf0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 15:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWLVUfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 15:35:25 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:51110 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbWLVUfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 15:35:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qPLIYnDRM1PV9GB7j3blBJlomfLnY/TXjjUgUw6JhIPcY/QyWYEEQj/E7zAR8zykEGIh5WwlYXLl8fUeaYXrzeEu8HXnpJxWmRURmariCBOjNQKjQ5m+Bc6eT0AFkaaY7sDxQy3h8CfZwwUaDMEz+nbGFQCotKI5u7JtjSQ8GGk=
Message-ID: <d120d5000612221235g3df0167bx9b1e6664dadf138d@mail.gmail.com>
Date: Fri, 22 Dec 2006 15:35:23 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [patch 2.6.20-rc1 6/6] input: ads7846 directly senses PENUP state
Cc: nicolas.ferre@rfo.atmel.com, linux-kernel@vger.kernel.org
In-Reply-To: <20061222192536.A206A1F0CDB@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061222192536.A206A1F0CDB@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/06, David Brownell <david-b@pacbell.net> wrote:
>
> +static void ads7846_report_pen_state(struct ads7846 *ts, int down)
> +{
> +       struct input_dev        *input_dev = ts->input;
> +
> +       input_report_key(input_dev, BTN_TOUCH, down);
> +       if (!down)
> +               input_report_abs(input_dev, ABS_PRESSURE, 0);
> +#ifdef VERBOSE
> +       pr_debug("%s: %s\n", ts->spi->dev.bus_id, down ? "DOWN" : "UP");
> +#endif
> +}
> +
> +static void ads7846_report_pen_position(struct ads7846 *ts, int x, int y,
> +                                       int pressure)
> +{
> +       struct input_dev        *input_dev = ts->input;
> +
> +       input_report_abs(input_dev, ABS_X, x);
> +       input_report_abs(input_dev, ABS_Y, y);
> +       input_report_abs(input_dev, ABS_PRESSURE, pressure);
> +
> +#ifdef VERBOSE
> +       pr_debug("%s: %d/%d/%d\n", ts->spi->dev.bus_id, x, y, pressure);
> +#endif
> +}
> +
> +static void ads7846_sync_events(struct ads7846 *ts)
> +{
> +       struct input_dev        *input_dev = ts->input;
> +
> +       input_sync(input_dev);
> +}

I think these helpers just obfuscate the code, just call
input_report_*() and input_sync() drectly like you used to do.

-- 
Dmitry
