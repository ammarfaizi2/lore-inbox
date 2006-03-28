Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWC1Xvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWC1Xvz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWC1Xvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:51:54 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:57405 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S964842AbWC1Xvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:51:54 -0500
In-Reply-To: <20060329014851.0f54da89@inspiron>
References: <20060329004122.64e91176@inspiron> <Pine.LNX.4.44.0603281654370.22846-100000@gate.crashing.org> <20060329014851.0f54da89@inspiron>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E135E70C-2F39-4007-B4CC-4D1AEBE2EE74@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][UPDATE] rtc: Added support for ds1672 control
Date: Tue, 28 Mar 2006 17:52:00 -0600
To: Alessandro Zummo <alessandro.zummo@towertech.it>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 28, 2006, at 5:48 PM, Alessandro Zummo wrote:

> On Tue, 28 Mar 2006 16:55:01 -0600 (CST)
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>> +/* following are the sysfs callback functions */
>> +static ssize_t show_control(struct device *dev, struct  
>> device_attribute *attr, char *buf)
>> +{
>> +	struct i2c_client *client = to_i2c_client(dev);
>> +	char *state = "enabled";
>> +	u8 control;
>> +	int err;
>> +
>> +	err = ds1672_get_control(client, &control);
>> +	if (err)
>> +		return err;
>
>  shouldn't this be
>  if (err < 0)
> 	return err;

It could be, but doesn't need to.  ds1672_get_control either returns  
0 (success) or non-zero (-EIO) for failure.

>> +	/* read control register */
>> +	err = ds1672_get_control(client, &control);
>> +	if (err) {
>> +		dev_err(&client->dev, "%s: read error\n", __FUNCTION__);
>> +		goto exit_detach;
>> +	}
>
>  ditto.

ditto.

- kumar

