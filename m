Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVCNSUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVCNSUa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVCNSU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 13:20:29 -0500
Received: from fmr19.intel.com ([134.134.136.18]:62429 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261661AbVCNSSa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 13:18:30 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2/6] PCI Express Advanced Error Reporting Driver
Date: Mon, 14 Mar 2005 10:18:22 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502408070B47@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/6] PCI Express Advanced Error Reporting Driver
Thread-Index: AcUm2jQo26N+bjpLQ1myqV7ue6gnwQB5q3yg
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Greg KH" <greg@kroah.com>, "long" <tlnguyen@snoqualmie.dp.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 14 Mar 2005 18:18:24.0691 (UTC) FILETIME=[36224830:01C528C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 11, 2005 11:25 PM Greg KH wrote:
>> +static ssize_t aer_sysfs_consume_show(struct device_driver *dev,
char >>*buf)
>> +{
>> +	return aer_fsprint_record(buf);
>> +}
>> +                  	
>> +static ssize_t aer_sysfs_status_show(struct device_driver *dev, char
>>*buf)
>> +{
>> +	return aer_fsprint_devices(buf);
>> +}
>> +                  	
>
>Why call wrapper functions that only do one thing?  Why have this extra
>layer of indirection that is not needed from what I can tell?

Agree, will make changes appropriately. Thanks for your comment.

>> +static ssize_t aer_sysfs_verbose_show(struct device_driver *dev,
char >>*buf)
>> +{
>> +	return sprintf(buf, "Verbose display set to %d\n", 
>> +		aer_get_verbose());				
>> +}
>>
>Just echo the value, don't print out pretty strings :)

Agree, will make changes appropriately.

>> +static ssize_t aer_sysfs_verbose_store(struct device_driver *drv, 	
>> +					const char *buf, size_t count)  
>> +{                            
>> +	aer_set_verbose(buf[0] - 0x30);			
>> +	return count;							
>> +}
>>
>Oh, that's a problem waiting to happen... Please validate the user
>provided value before acting on it.

Agree, will make changes appropriately.

>> +static ssize_t aer_sysfs_auto_show(struct device_driver *dev, char
*buf)
>> +{
>> +	return sprintf(buf, "Automatic reporting is %s\n", 		
>> +		(aer_get_auto_mode()) ? "on" : "off");

>> +}
>>
>Again, just print on/off.

Agree, will make changes appropriately.

>> +static ssize_t aer_sysfs_auto_store(struct device_driver *drv, 	
>> +					const char *buf, size_t count)

>> +{                            
>> +	aer_set_auto_mode(buf[0] - 0x30);			
>> +	return count;							
>> +}
>>
>Also validate this.

Agree, will make changes appropriately.

Thanks for all comments,
Long
