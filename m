Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbUCIIfr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 03:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUCIIfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 03:35:47 -0500
Received: from c10053.upc-c.chello.nl ([212.187.10.53]:15757 "EHLO
	smurver.fakenet") by vger.kernel.org with ESMTP id S261783AbUCIIfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 03:35:42 -0500
Message-ID: <404D81D2.9010005@vanE.nl>
Date: Tue, 09 Mar 2004 09:35:30 +0100
From: Erik van Engelen <Info@vanE.nl>
User-Agent: Mozilla Thunderbird 0.5b (Windows/20040301)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: NACMSupport@hp.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: EISA support in cpqarray broken in 2.6.x kernel
References: <1021534.1078754544264.JavaMail.wfm@i3107ac8.atl.hp.com>
In-Reply-To: <1021534.1078754544264.JavaMail.wfm@i3107ac8.atl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The cpqarray driver lost support for the EISA bus from kernel 2.4 to 
2.6. This causes a kernel panic during boot.

It is very clear there is a problem with this driver. As i already 
described:
In the initializing of the driver (cpqarray_init) the PCI and EISA bus 
are initialized (cpqarray_pci_detect, cpqarray_eisa_detect). In 
cpqarray_eisa_detect the pci_dev is set to NULL. A few lines later (line 
397) a call to hba[i]->pci_dev->dma_mask is made. This is clearly 
impossible.

I already did all the tests discribed by the support team at HP and came 
to the conclusion it is the EISA bus that is the problem. That's why I 
asked if the support is coming back in the driver?

I send this message to the mailinglist because i think the maintainers 
don't have the answers for the problem.

Greetings.
Erik

NACMSupport@hp.com wrote:


> Dear HP Customer,
> 
> Yes, we maintain the driver.  I cannot think of a kernel option (other than EISA support) that would cause these issues.
> The most beneficial thing to do at this point is troubleshooting.  I recommend minimizing the system.  Please try this installation with no PCI cards, using only the embeded SCSI (terminate the unused channel).  Also, please minimize the amount of memory and try to revert to a single processor.  If the installation fails, it is possible configuration, firmware or main system component issues.  If the installation works, then the problem is with one of the components removed (yes maybe the Smart Array).  At that point, I would first try adding only the Smart Array and then other components one at a time until the failure can be reproduced.  This is a long process, but afterwards it will allow greater focus on the one problem area.
> 
> Thank You
> HP Services
> 
> 
> ==== Created - Info@vanE.nl - 3/5/04 2:18:54 AM ====
> Hello,
> 
> This is not an adjustments within the OS. This is a driver you wrote. 
> According to the MAINTAINERS file in de kernel source you(compaq) are 
> the maintainers of the driver: Francis Wiran <support@compaq.com>
> 
> According to sourceforge.net/projects/cpqarray/ you also are the 
> maintainers: compaqadm,cwhite3,fred_harris,jcagle,smcameron.
> 
> I looked at the driver(2.4.5) in the 2.6 kernel source and found out it 
> was a call to the pci_dev->dma_mask that caused the problem. (line 397)
> 
> Is this driver supporting EISA bus? If not is this support comming back? 
> This would be very sad for me. This makes my compaq server useless.
> 
> Greetings.
> Erik van Engelen.
> 
> NACMSupport@hp.com wrote:
> 
>>
>>Erik van Engelen, , 
>>
>>For adjustments within the OS, see Redhat.com
>>
>>HP eSupport
>>==== Created - Info@vanE.nl - 3/3/04 2:48:56 PM ====
>>Hello,
>>
>>All the memory is seen in the system configuration. With a 2.4.18 kernel 
>>  *free* shows all the memory. On a 2.4.25 only 16MB is shown by *free*.
>>
>>Can you sent me the .config file for the kernel so i can build a new 
>>kernel from the standard source from www.kernel.org. Maybe I'm missing 
>>an essential option.
>>
>>Do you use a special kernel source or patches for the cpqarray? Who is 
>>the kernel maintainer for the cpqarray? Your email addres is in the 
>>cpqarray.c
>>
>>Thanks for the help.
>>Erik van Engelen
>>
>>NACMSupport@hp.com wrote:
>>
>>
>>
>>>
>>>Erik van Engelen, 
>>>
>>>The 2500 was seeing all of the memory in the 2.4.25 kernel and was not producing a kernel panic. 
>>>
>>>1. Down the server. 
>>>2. Verify all of the memory in still being seen in the system configuration. If need be run diags on the memory. 
>>>3. I will need to direct you to redhat to verify the kernel 2.6.3 will see all of the memory. Some of the kernel have memory limitations. See linux website for information on how to see all of your memory in the OS. RH will have that information for the config file adjustment. 
>>>
>>>HP eSupport
>>>==== Created - Info@vanE.nl - 3/2/04 4:21:39 AM ====
>>>
>>>Hello,
>>>
>>>I'm running Debian stable. I wanted to test the 2.6.3 kernel.
>>>
>>>All(2) the memory modules are from compaq. I think the partnr=228469-001.
>>>
>>>During system start it shows 131072kb and it initializes 131072kb (this 
>>>is displayed for a very short time). The system diagnostic tools on the 
>>>smartstart cd shows the same.
>>>
>>>I know that you only support compaq hardware but even without the 
>>>promise controller the problem appears.
>>>
>>>Greetings.
>>>
>>>NACMSupport@hp.com wrote:
>>>
>>>
>>>
>>>
>>>>
>>>>
>>>>
>>>>Dear HP Customer,
>>>>
>>>>Thank you for contacting HP eServices.
>>>>
>>>>This is with reference to your e-mail regarding the Kernel panic. 
>>>>
>>>>We would appreciate it if you could send us the following additional information at your earliest convenience, for further help on this issue: 
>>>>
>>>>1. What flavor of Linux is installed?
>>>>2. Is there any third party memory modules installed in the server?
>>>>3. What is the memory capacity displayed during the POST?
>>>>
>>>>Note: Please note that promise ultra100 tx2 controller is not tested on ProLiant server.
>>>>
>>>>We appreciate your patience and apologize for the inconvenience caused.
>>>>
>>>>Please e-mail if you need further assistance and we will be glad to help. 
>>>>
>>>>Thank you,
>>>>
>>>>HP eServices
>>>>
>>>>
>>>>
>>>>==== Created - security-alert@hp.com - 3/1/04 2:27:25 PM ====
>>>>This message has been rerouted to you by the HP.COM email router.  If this message has been sent to you in error, please forward back to the email router mailbox at REROUTER,HPCOM per HP email directory or HPCOM REROUTER per CPQ email directory.
>>>
>>>
