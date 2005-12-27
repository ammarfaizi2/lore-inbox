Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbVL0VzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVL0VzU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 16:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbVL0VzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 16:55:20 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:47239 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932357AbVL0VzT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 16:55:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t8HF3us2MH9zLaJ6qMTVZtpM7g9E3VJTvBozg9zGsDcZXfQBrji9tlg9zYv8yeoCQENvz7zEfwV9bxCXQ4m9JrRHxNv4AybXaYryfRtTN5oJqNGfqk/VojC50piu9FeTTvNKNNF+FajX5f/WVBQ4Hx2p2NPZKmRJyptv6YyEMAU=
Message-ID: <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com>
Date: Tue, 27 Dec 2005 16:55:18 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <20051227213439.GA1884@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051227213439.GA1884@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/05, Pavel Machek <pavel@ucw.cz> wrote:
>
>  static ssize_t state_show(struct device * dev, struct device_attribute *attr, char * buf)
>  {
> -       return sprintf(buf, "%u\n", dev->power.power_state.event);
> +       if (dev->power.power_state.event)
> +               return sprintf(buf, "suspend\n");
> +       else
> +               return sprintf(buf, "on\n");
>  }

Are you sure that having only 2 options (suspend/on) is enough at the
core level? I could envision having more levels, like "poweroff", etc?

--
Dmitry
