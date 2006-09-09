Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWIIFsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWIIFsY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 01:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWIIFsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 01:48:23 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:18089 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932163AbWIIFsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 01:48:23 -0400
Message-ID: <4502558B.1010103@myri.com>
Date: Sat, 09 Sep 2006 01:47:55 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Brandon Philips <brandon@ifup.org>, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Robert Love <rml@novell.com>
Subject: Re: 2.6.18-rc6-mm1 2.6.18-rc5-mm1 Kernel Panic on X60s
References: <20060908174437.GA5926@plankton.ifup.org>	<20060908121319.11a5dbb0.akpm@osdl.org>	<20060908194300.GA5901@plankton.ifup.org>	<20060908125053.c31b76e9.akpm@osdl.org>	<m1slj1iurx.fsf@ebiederm.dsl.xmission.com> <20060908222141.564e3b2a.akpm@osdl.org>
In-Reply-To: <20060908222141.564e3b2a.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 08 Sep 2006 21:27:46 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>   
>> Andrew Morton <akpm@osdl.org> writes:
>>     
>>> On Fri, 8 Sep 2006 14:43:00 -0500
>>> Brandon Philips <brandon@ifup.org> wrote:
>>>       
>>>> With CONFIG_PCI_MSI disabled the system boots.  
>>>>         
>>> OK, thanks.
>>>
>>> So likely candidates are:
>>>
>>> - Brice's MSI changes
>>>
>>> - The conversion of i386 to use the genirq code
>>>
>>> - Eric's MSI/genirq changes
>>>
>>> or a combination of the above.  Or something else.
>>>
>>> <adds ccs, steps back expectantly>
>>>       
>> Thanks for the heads up.
>>
>> There was another panic reported last -mm tree I believe as well.
>>     
>
> Yes, there were a couple such reports.  The MSI patches in Greg's tree were
> blamed and rc6-mm1 has a revamped version.  Whether they were sufficiently
> revamped we do not know.
>   


The revamped version is much simpler than the previous ones. We are
basically back to the early ones we had in 2.6.17-mm5, with a tiny
modification to fix the oops that was reported there.

AFAIK, the possible problems that my patches might generate should only be:
* an obvious bug in the code leading to an oops during pci_enable_msi()
or pci_enable_msix() ;
* a wrong detection of whether MSI are supported or not, leading to MSI
being disabled while supported (should not be bad for most drivers), or
enabled while unsupported by the root chipset (would be bad).

Do we have Brandon lspci so that I can see if any of the MSI quirks is
involved?

Brice

