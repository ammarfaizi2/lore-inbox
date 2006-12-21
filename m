Return-Path: <linux-kernel-owner+w=401wt.eu-S1422835AbWLUIEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422835AbWLUIEL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422836AbWLUIEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:04:11 -0500
Received: from mga03.intel.com ([143.182.124.21]:11790 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422835AbWLUIEK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:04:10 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,197,1165219200"; 
   d="scan'208"; a="160948189:sNHT26174624"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Date: Thu, 21 Dec 2006 16:04:04 +0800
Message-ID: <117E3EB5059E4E48ADFF2822933287A401F2E7C5@pdsmsx404.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Thread-Index: AcckIyCbFDqXIEFpQKqyA+QcRJRZSwApI7oQ
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Andrew Morton" <akpm@osdl.org>,
       "Chuck Ebbert" <76306.1226@compuserve.com>
Cc: "Yinghai Lu" <yinghai.lu@amd.com>, <ard@telegraafnet.nl>, <take@libero.it>,
       <agalanin@mera.ru>, <linux-kernel@vger.kernel.org>,
       <bugme-daemon@bugzilla.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
X-OriginalArrivalTime: 21 Dec 2006 08:04:07.0792 (UTC) FILETIME=[96FA0F00:01C724D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: Andrew Morton [mailto:akpm@osdl.org]
>>Sent: 2006Äê12ÔÂ20ÈÕ 18:38
>>To: Chuck Ebbert
>>Cc: Yinghai Lu; ard@telegraafnet.nl; take@libero.it; agalanin@mera.ru; linux-kernel@vger.kernel.org; bugme-daemon@bugzilla.kernel.org;
>>Eric W. Biederman; Zhang, Yanmin
>>Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
>>
>>On Wed, 20 Dec 2006 04:59:19 -0500
>>Chuck Ebbert <76306.1226@compuserve.com> wrote:
>>
>>> > On 12/19/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
>>> > > So an external interrupt occurred, the system tried to use interrupt
>>> > > descriptor #39 decimal (irq 7), but the descriptor was invalid.
>>> >
>>> > but the irq is disabled at that time.
>>> >
>>> > can you use attached diff to verify if the irq is enable somehow?
>>>
>>> But it seems interrupts are on--look at the flags:
>>>
>>>         RSP: 0018:ffffffff803cdf68  EFLAGS: 00010246
>>>
>>
>>down_write()->__down_write()->__down_write_nested()->spin_unlock_irq()->dead
>>
>>Could someone please test this?
I couldn't reproduce it on my EM64T machine. I instrumented function start_kernel and
didn't find irq was enabled before calling init_IRQ. It'll be better if the reporter could
instrument function start_kernel to capture which function enables irq.
