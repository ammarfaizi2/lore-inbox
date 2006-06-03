Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWFCXoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWFCXoY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 19:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWFCXoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 19:44:24 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:37276 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750714AbWFCXoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 19:44:24 -0400
Message-ID: <44821EAF.8010003@myri.com>
Date: Sat, 03 Jun 2006 19:43:43 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
CC: Brice Goglin <brice@myri.com>, Andrew Morton <akpm@osdl.org>,
       Shaohua Li <shaohua.li@intel.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, greg@kroah.com, tom.l.nguyen@intel.com,
       rajesh.shah@intel.com
Subject: Re: [RFC]disable msi mode in pci_disable_device
References: <1148612307.32046.132.camel@sli10-desk.sh.intel.com> <20060526125440.0897aef5.akpm@osdl.org> <44776491.1080506@myri.com> <20060531210053.GE6364@austin.ibm.com>
In-Reply-To: <20060531210053.GE6364@austin.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
>> The aim is to be able to recover from a memory parity error in the NIC.
>> Such errors happen sometimes, especially when a cosmic ray comes by. To
>> recover, we restore the state that we saved at the end of the
>> initialization. As saving currently disables MSI, we currently have to
>> restore the state right after saving it at the end of the initialization
>> (see the end of
>> myri10ge_probe in http://lkml.org/lkml/2006/5/23/24).
>>     
>
> My experience dealing with a similar thing suggests that its usually
> easier to restore the state to where it was after a cold boot, but
> before the device driver touched the h/w.  
>   

After a cold boot, some initialization is done by Linux before the
driver even touches the device (for instance the BARs). I am not sure
that restoring to the state before Linux initialized the device would be
easier than what we currently do.

Brice

