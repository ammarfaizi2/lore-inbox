Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWBURCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWBURCg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWBURCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:02:36 -0500
Received: from posthamster.phnxsoft.com ([195.227.45.4]:51723 "EHLO
	posthamster.phnxsoft.com") by vger.kernel.org with ESMTP
	id S932316AbWBURCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:02:35 -0500
Message-ID: <43FB475A.5050108@phoenixsoftware.de>
Date: Tue, 21 Feb 2006 18:01:14 +0100
From: Tilman Schmidt <t.schmidt@phoenixsoftware.de>
Organization: Phoenix Software GmbH
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Hansjoerg Lipp <hjlipp@web.de>, Karsten Keil <kkeil@suse.de>,
       i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Tilman Schmidt <tilman@imap.cc>
Subject: advice on using dev_info(), dev_err() and friends (was: [PATCH 2/9]
 isdn4linux: Siemens Gigaset drivers - common module)
References: <gigaset307x.2006.02.11.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.1@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.2@hjlipp.my-fqdn.de> <20060215032659.GB5099@suse.de>
In-Reply-To: <20060215032659.GB5099@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.409 () AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

thank you for your comments. Just a few follow-up questions.

On 15.02.2006 04:27, Greg KH wrote:
> On Sat, Feb 11, 2006 at 03:52:27PM +0100, Hansjoerg Lipp wrote:
> 
>>--- linux-2.6.16-rc2/drivers/isdn/gigaset/gigaset.h	1970-01-01 01:00:00.000000000 +0100
>>+++ linux-2.6.16-rc2-gig/drivers/isdn/gigaset/gigaset.h	2006-02-11 15:20:26.000000000 +0100
[...]
>>+#undef info
>>+#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", THIS_MODULE ? THIS_MODULE->name : "gigaset_hw" , ## arg)
> 
> Care to use the dev_info(), dev_err() and other dev_* friends instead of
> rolling your own?  It gives you a much easier and standardised way of
> identifying the driver and individual device that the message is
> happening for.

This turns out to be surprisingly tricky, as these macros take a device
pointer argument which mustn't be NULL either.

Could you please advise how to use these when I do not have a device
pointer available (ie. before the probe method has been called) or when
there is a risk of it being no longer valid (ie. the USB device has been
unplugged)? I can detect both cases by checking for dev==NULL, but then
what do I do if it is? Is there a dummy device structure somewhere which
I could then use instead? Somehow, replacing all our occurrences of
	info("m%sg", args);
with
	if (cs->dev)
		dev_info(cs->dev, "m%sg\n", args);
	else
		printk(KERN_INFO "gigaset: m%sg\n", args);
doesn't really appeal to me. :-)

Thanks
Tilman
