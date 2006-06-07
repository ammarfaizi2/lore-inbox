Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWFGN7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWFGN7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 09:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWFGN7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 09:59:30 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:46045 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932076AbWFGN73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 09:59:29 -0400
Message-ID: <4486DAF7.4040101@jp.fujitsu.com>
Date: Wed, 07 Jun 2006 22:56:07 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org,
       Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 4/4] Make Emulex lpfc driver legacy I/O port free
References: <20060601113625.A4043@unix-os.sc.intel.com> <447FA920.9060509@jp.fujitsu.com> <4484263C.1030508@jp.fujitsu.com> <20060606075812.GB19619@kroah.com> <448643B9.2080805@jp.fujitsu.com> <448644D6.9030907@jp.fujitsu.com> <20060607082448.GA31004@infradead.org> <4486C537.9040105@jp.fujitsu.com> <20060607124353.GA31777@infradead.org> <4486D070.2020806@jp.fujitsu.com> <20060607134034.GA4744@infradead.org>
In-Reply-To: <20060607134034.GA4744@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Wed, Jun 07, 2006 at 10:11:12PM +0900, Kenji Kaneshige wrote:
> 
>>I mean the right order is
>>
>>   (1) pci_request_regions()
>>   (2) pci_enable_device*()
> 
> 
> no, pci_enable_device should be first.
> 
> 

I had the same wrong assumption before. But to prevent two
devices colliding on the same address range, pci_request_regions()
should be called first. Please see the following discussions:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0606.0/0076.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0606.0/0187.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0606.0/0212.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0606.0/0369.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0606.0/0401.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0606.0/0431.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0606.0/0839.html

Thanks,
Kenji Kaneshige
