Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317517AbSIENc2>; Thu, 5 Sep 2002 09:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317508AbSIENc1>; Thu, 5 Sep 2002 09:32:27 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:50956 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S317473AbSIENc0>; Thu, 5 Sep 2002 09:32:26 -0400
Date: Thu, 05 Sep 2002 07:35:23 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Jeremy Higdon <jeremy@classic.engr.sgi.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset?
Message-ID: <122900000.1031232923@aslan.scsiguy.com>
In-Reply-To: <10209050239.ZM52086@classic.engr.sgi.com>
References: <200209041613.g84GDtv02639@localhost.localdomain>
 <12750000.1031158209@aslan.btc.adaptec.com>
 <10209050239.ZM52086@classic.engr.sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sep 4, 10:50am, Justin T. Gibbs wrote:
>> 
>>    This of course assumes that all transactions have a serial number and
>>    that requeuing transactions orders them by serial number.  With QErr
>>    set, the device closes the rest if the barrier race for you, but even
>>    without barriers, full transaction ordering is required if you don't
>>    want a read to inadvertantly pass a write to the same location during
>>    recovery.
> 
> 
> The original FCP (SCSI commands over Fibre) profile specified that QERR=1
> was not available.  Unless that is changed, it would appear that you
> cannot count on being able to set Qerr.
> 
> Qerr was one of those annoying little things in SCSI that forces host
> adapter drivers to know a mode page setting.

It is not the controllers that know, but the type drivers.  The controller
drivers should be conduits for commands, nothing more.  With the proper
events and error codes, the type drivers can maintain mode parameters
and only the type drivers know what parameters are appropriate for their
type of service.

For FC, you need to use ECA/ACA anyway as that is the only way to deal with
inflight commands at the time of an error.

--
Justin
