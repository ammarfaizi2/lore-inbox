Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbULaF1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbULaF1H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 00:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbULaF1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 00:27:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:13030 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261839AbULaF1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 00:27:02 -0500
Message-ID: <41D4E1C5.3040804@osdl.org>
Date: Thu, 30 Dec 2004 21:21:09 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Karel Kulhavy <clock@twibright.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: pcf8591 boot time parameters
References: <20041227140309.GA3361@beton.cybernet.src>
In-Reply-To: <20041227140309.GA3361@beton.cybernet.src>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Kulhavy wrote:
> Is it possible to configure pcf8591 driver using boot time commandline
> parameters? 
> 
> If yes, where are they described? I didn't find it. (<Help> doesn't say
> anything).  also /linux-2.6.10/Documentation/i2c$ fgrep PCF * didn't reveal
> anything related.
> 
> I only found documentation for module parameters by means of modinfo pcf8591

and what did it tell you?  I see (when built as a loadable module,\
but they are still valid when built in-kernel):

parm:           force:List of adapter,address pairs to boldly assume 
to be present
parm:           force_pcf8591:List of adapter,address pairs which are 
unquestionably assumed to contain a `pcf8591' chip
parm:           probe:List of adapter,address pairs to scan additionally
parm:           ignore:List of adapter,address pairs not to scan
parm:           input_mode:Analog input mode:
  0 = four single ended inputs
  1 = three differential inputs
  2 = single ended and differential mixed
  3 = two differential inputs


It seems that there is a list of i2c client parameters in
Documentation/i2c/writing-clients .

I don't know i2c, but any driver that #includes
linux/i2c.h has defined for it these parameters:
   probe, probe_range
   ignore, ignore_range
   force

and any driver that #includes linux/i2c-sensor.h
has defined for it these parameters:
   force_<driver_basename>
   probe
   ignore
   force

but it would be better for someone who is familiar with those
twisted macros to document all of this.

-- 
~Randy
