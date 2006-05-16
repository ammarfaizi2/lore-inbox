Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWEPXDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWEPXDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 19:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWEPXDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 19:03:05 -0400
Received: from mx0.towertech.it ([213.215.222.73]:18365 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S932269AbWEPXDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 19:03:03 -0400
Date: Wed, 17 May 2006 01:02:59 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: dsaxena@plexity.net
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Subject: Re: [PATCH] Add driver for ARM AMBA PL031 RTC
Message-ID: <20060517010259.5a035b20@inspiron>
In-Reply-To: <20060516214813.GA28414@plexity.net>
References: <20060516214813.GA28414@plexity.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006 14:48:13 -0700
Deepak Saxena <dsaxena@plexity.net> wrote:

> 
> This patch adds a driver for the ARM PL031 RTC found on some ARM SOCs.
> The driver is fairly trivial as the RTC only provides a read/write and
> alarm capability.
> 
> Signed-off-by: Deepak <dsaxena@plexity.net>

> Alessandro: What userland tool do I use to test alarm capability?

 There's the source code of a test program in Documentation/rtc.txt .
 I'm not so sure the alarm capability is used nowadays.


you can avoid including this one if it is a no-op:

> +static int pl031_read_callback(struct device *dev, int data)
> +{
> +	return data;
> +}

 

> +static int pl031_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
> +{
> +	struct pl031_local *ldata = dev_get_drvdata(dev);
> +
> +	switch (cmd) {
> +	case RTC_AIE_OFF:
> +		__raw_writel(1, ldata->base + RTC_MIS);
> +		return 0;
> +	case RTC_AIE_ON:
> +		__raw_writel(0, ldata->base + RTC_MIS);
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}

 pleasew return -ENOIOCTLCMD instead of -EINVAL . I know, I will have
to fix the other drivers to do the same.


 no op:

> +static int pl031_proc(struct device *dev, struct seq_file *seq)
> +{
> +	return 0;
> +}
> +



-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

