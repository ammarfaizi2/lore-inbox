Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWC1WER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWC1WER (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWC1WER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:04:17 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:61494 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932430AbWC1WEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:04:16 -0500
In-Reply-To: <20060328234027.26b5602b@inspiron>
References: <Pine.LNX.4.44.0603281507050.20373-100000@gate.crashing.org> <20060328234027.26b5602b@inspiron>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <08A09790-5D74-4089-AA7B-6AB5628A19DD@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] rtc: Added support for ds1672 control
Date: Tue, 28 Mar 2006 16:04:20 -0600
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


On Mar 28, 2006, at 3:40 PM, Alessandro Zummo wrote:

> On Tue, 28 Mar 2006 15:07:33 -0600 (CST)
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>  is almost ok, please check my comments below:
>
>>
>>  	buf[0] = DS1672_REG_CNT_BASE;
>>  	buf[1] = secs & 0x000000FF;
>>  	buf[2] = (secs & 0x0000FF00) >> 8;
>>  	buf[3] = (secs & 0x00FF0000) >> 16;
>>  	buf[4] = (secs & 0xFF000000) >> 24;
>> +	buf[5] = 0;
>
>  I'd add a comment to say that 0 enables the osc.

ack.

>> +static int ds1672_get_control(struct i2c_client *client)
>> +{
>
> [..]
>
>> +	} else
>> +		return val;
>> +}
>
>  I think it would be cleaner to define the routine as follow:
> .. ds1672_get_control(...., unsigned char *status)
>
>  and to usa the space provided by the caller to store the result.
>
>> +	if (ds1672_get_control(client))
>> +		state = "disabled";
>> +	return sprintf(buf, "%s\n", state);
>> +}

Not sure if I follow you here.  I think you are suggesting for  
ds1672_get_control to look like:

static int ds1672_get_control(struct i2c_client *client, u8 *status)
{
         unsigned char addr = DS1672_REG_CONTROL;

         struct i2c_msg msgs[] = {
                 { client->addr, 0, 1, &addr },          /* setup  
read ptr */
                 { client->addr, I2C_M_RD, 1, status },  /* read  
control */
         };
...
}

which is fine.  Any suggestions on what to do on an error in the  
sysfs attrib function?

> please #define DS1672_REG_CONTROL_EOSC 0x80
> and check the single bit.

ack

>> +	err = ds1672_get_control(client);
>
>  ditto.
>
>
>  thanks for your work!

no problem.

- k
