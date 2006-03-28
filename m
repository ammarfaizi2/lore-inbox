Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWC1Vko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWC1Vko (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 16:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWC1Vko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 16:40:44 -0500
Received: from mx0.towertech.it ([213.215.222.73]:47321 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S932235AbWC1Vko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 16:40:44 -0500
Date: Tue, 28 Mar 2006 23:40:27 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: Added support for ds1672 control
Message-ID: <20060328234027.26b5602b@inspiron>
In-Reply-To: <Pine.LNX.4.44.0603281507050.20373-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0603281507050.20373-100000@gate.crashing.org>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006 15:07:33 -0600 (CST)
Kumar Gala <galak@kernel.crashing.org> wrote:

 is almost ok, please check my comments below:

>  
>  	buf[0] = DS1672_REG_CNT_BASE;
>  	buf[1] = secs & 0x000000FF;
>  	buf[2] = (secs & 0x0000FF00) >> 8;
>  	buf[3] = (secs & 0x00FF0000) >> 16;
>  	buf[4] = (secs & 0xFF000000) >> 24;
> +	buf[5] = 0;

 I'd add a comment to say that 0 enables the osc.

> +static int ds1672_get_control(struct i2c_client *client)
> +{

[..]

> +	} else
> +		return val;
> +}

 I think it would be cleaner to define the routine as follow:
.. ds1672_get_control(...., unsigned char *status)

 and to usa the space provided by the caller to store the result.

> +	if (ds1672_get_control(client))
> +		state = "disabled";
> +	return sprintf(buf, "%s\n", state);
> +}

please #define DS1672_REG_CONTROL_EOSC 0x80
and check the single bit.


> +	err = ds1672_get_control(client);

 ditto.


 thanks for your work!

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

