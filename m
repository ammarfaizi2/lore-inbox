Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWKDBsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWKDBsi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 20:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753570AbWKDBsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 20:48:38 -0500
Received: from terminus.zytor.com ([192.83.249.54]:56973 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1753568AbWKDBsh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 20:48:37 -0500
Message-ID: <454BF0F1.5050700@zytor.com>
Date: Fri, 03 Nov 2006 17:46:25 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: John <me@privacy.net>
CC: linux-kernel@vger.kernel.org, linux.nics@intel.com
Subject: Re: Intel 82559 NIC corrupted EEPROM
References: <454B7C3A.3000308@privacy.net>
In-Reply-To: <454B7C3A.3000308@privacy.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John wrote:
> 
> Several people have reported the same error. Intel's Auke Kok has
> stated that ignoring the error is a BAD idea.
> 
> http://lkml.org/lkml/2006/7/10/215
> 
> What tool is used to reprogram the EEPROM? ethtool?
> I suppose I'll have to ask the manufacturer for an updated EEPROM?
> 
> # ethtool -e eth0
> Cannot get EEPROM data: Operation not supported
> 
> I'm not sure why I can't dump the contents of the EEPROM.
> Does the driver need to be loaded?
> 

Yes, the driver needs to be loaded.

Basically, Auke wants you to throw away your NIC and/or motherboard. 
Since you're effectively dead, the only damage you can do by disabling 
the check has already been done.  This unfortunately seems to be fairly 
common with e100, especially for the on-motherboard version, and you 
basically have two options: either disable the check or write an offline 
tool to reprogram the EEPROM.

The latest netdev tree (if it's not in Linus' tree already, which it 
might be) does add back the option to ignore the check so you can update 
the EEPROM, which will automatically fix the checksum.

	-hpa
