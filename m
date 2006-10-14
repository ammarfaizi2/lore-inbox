Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422744AbWJNSM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422744AbWJNSM3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 14:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422743AbWJNSM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 14:12:29 -0400
Received: from thing.hostingexpert.com ([67.15.235.34]:62368 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1422744AbWJNSM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 14:12:28 -0400
Message-ID: <4531287B.5030507@linuxtv.org>
Date: Sat, 14 Oct 2006 14:12:11 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: mchehab@infradead.org, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [PATCH 07/18] V4L/DVB (4733): Tda10086: fix frontend selection
 for dvb_attach
References: <20061014115356.PS36551000000@infradead.org> <20061014120050.PS67662400007@infradead.org> <20061014121448.GM30596@stusta.de>
In-Reply-To: <20061014121448.GM30596@stusta.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sat, Oct 14, 2006 at 09:00:50AM -0300, mchehab@infradead.org wrote:
>> From: Michael Krufky <mkrufky@linuxtv.org>
>>
>> Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
>> ---
>>
>>  drivers/media/dvb/frontends/tda10086.h |    9 +++++++++
>>  1 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/media/dvb/frontends/tda10086.h b/drivers/media/dvb/frontends/tda10086.h
>> index e8061db..18457ad 100644
>> --- a/drivers/media/dvb/frontends/tda10086.h
>> +++ b/drivers/media/dvb/frontends/tda10086.h
>> @@ -35,7 +35,16 @@ struct tda10086_config
>>  	u8 invert;
>>  };
>>  
>> +#if defined(CONFIG_DVB_TDA10086) || defined(CONFIG_DVB_TDA10086_MODULE)
>>  extern struct dvb_frontend* tda10086_attach(const struct tda10086_config* config,
>>  					    struct i2c_adapter* i2c);
>> +#else
>> +static inline struct dvb_frontend* tda10086_attach(const struct tda10086_config* config,
>> +						   struct i2c_adapter* i2c)
>> +{
>> +	printk(KERN_WARNING "%s: driver disabled by Kconfig\n", __FUNCTION__);
>> +	return NULL;
>> +}
>> +#endif // CONFIG_DVB_TDA10086
> 
> As already said:
> This breaks with CONFIG_VIDEO_SAA7134_DVB=y, CONFIG_DVB_TDA10086=m.

Again, the breakage is from DVB_FE_CUSTOMIZE=Y, not the above ^^.

This patch must be applied.

-Mike Krufky
