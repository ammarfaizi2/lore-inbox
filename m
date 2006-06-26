Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWFZDXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWFZDXE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 23:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWFZDXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 23:23:03 -0400
Received: from terminus.zytor.com ([192.83.249.54]:41628 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751425AbWFZDXD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 23:23:03 -0400
Message-ID: <449F52FF.7000300@zytor.com>
Date: Sun, 25 Jun 2006 20:22:39 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: Re: [klibc 12/43] Enable CONFIG_KLIBC_ZLIB (now required to build
 kinit)
References: <klibc.200606251757.12@tazenda.hos.anvin.org> <449F511C.6020303@garzik.org>
In-Reply-To: <449F511C.6020303@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> H. Peter Anvin wrote:
>> After removing the private copy of zlib in kinit, we need
>> CONFIG_KLIBC_ZLIB in order to build klibc.  zlib is required in order
>> to decompress classical ramdisks.
>>
>> In the future this should maybe be made conditional on 
>> CONFIG_BLK_DEV_RAM.
> 
>> +config KLIBC_ZLIB
>> +    bool
>> +    default y
> 
> 
> Dumb question, then:  why not make it conditional on rd now?
> 

Mostly because I haven't yet broken down kinit in configurable chunks; 
it's somewhat messy to do as long as I'm maintaining a standalone 
distribution as well as the out-of-mainline kernel tree.  Not difficult 
by any means, but I've wanted to avoid combinatorics and code churn as 
long as I have a limited testing base (although -mm has vastly increased 
it.)

It's also unclear to me if it's the right thing to omit it from the 
library, ever; the only users that are affected are the ones that are 
using the shared klibc and don't have any use of zlib.

	-hpa


