Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWC1XtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWC1XtH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWC1XtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:49:07 -0500
Received: from mx0.towertech.it ([213.215.222.73]:5856 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S964845AbWC1XtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:49:05 -0500
Date: Wed, 29 Mar 2006 01:48:51 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][UPDATE] rtc: Added support for ds1672 control
Message-ID: <20060329014851.0f54da89@inspiron>
In-Reply-To: <Pine.LNX.4.44.0603281654370.22846-100000@gate.crashing.org>
References: <20060329004122.64e91176@inspiron>
	<Pine.LNX.4.44.0603281654370.22846-100000@gate.crashing.org>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006 16:55:01 -0600 (CST)
Kumar Gala <galak@kernel.crashing.org> wrote:

> +/* following are the sysfs callback functions */
> +static ssize_t show_control(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	char *state = "enabled";
> +	u8 control;
> +	int err;
> +
> +	err = ds1672_get_control(client, &control);
> +	if (err)
> +		return err;

 shouldn't this be
 if (err < 0)
	return err;

 ?

> +	/* read control register */
> +	err = ds1672_get_control(client, &control);
> +	if (err) {
> +		dev_err(&client->dev, "%s: read error\n", __FUNCTION__);
> +		goto exit_detach;
> +	}

 ditto.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

