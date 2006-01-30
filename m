Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWA3N2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWA3N2r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 08:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWA3N2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 08:28:47 -0500
Received: from spirit.analogic.com ([204.178.40.4]:3850 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932254AbWA3N2q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 08:28:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <43DDD1DA.6060507@aitel.hist.no>
X-OriginalArrivalTime: 30 Jan 2006 13:28:16.0957 (UTC) FILETIME=[07545ED0:01C625A1]
Content-class: urn:content-classes:message
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Date: Mon, 30 Jan 2006 08:28:09 -0500
Message-ID: <Pine.LNX.4.61.0601300818290.28552@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Thread-Index: AcYloQdd5APOpcFdT1qGZF9kBHAAiQ==
References: <20060124225919.GC12566@suse.de>  <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>  <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>  <43D7BA0F.5010907@nortel.com>  <43D7C2F0.5020108@symas.com> <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com> <43D88E55.7010506@yahoo.com.au> <43D8DB90.7070601@symas.com> <43D8E298.3020402@yahoo.com.au> <43D8E96B.3070606@symas.com> <43D8EFF7.3070203@yahoo.com.au> <43D8FC76.2050906@symas.com> <Pine.LNX.4.61.0601261231460.9298@chaos.analogic.com> <43DDD1DA.6060507@aitel.hist.no>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Helge Hafting" <helge.hafting@aitel.hist.no>
Cc: "Howard Chu" <hyc@symas.com>, "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Christopher Friesen" <cfriesen@nortel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <hancockr@shaw.ca>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Jan 2006, Helge Hafting wrote:

> linux-os (Dick Johnson) wrote:
>
>> To fix the current problem, you can substitute usleep(0); It will
>> give the CPU to somebody if it's computable, then give it back to
>> you. It seems to work in every case that sched_yield() has
>> mucked up (perhaps 20 to 30 here).
>>
>>
> Isn't that dangerous?  Someday, someone working on linux (or some
> other unixish os) might come up with an usleep implementation where
> usleep(0) just returns and becomes a no-op.  Which probably is ok
> with the usleep spec - it did sleep for zero time . . .
>
> Helge Hafting

Dangerous?? You have a product that needs to ship. You can make
it work by adding a hack. You add a hack. I don't see danger at
all. I see getting the management off the back of the software
engineers so that they can fix the code. Further, you __test__ the
stuff before you ship. If usleep(0) just spins, then you use
usleep(1).

Also, I don't think any Engineer would use threads for anything
that could be potentially dangerous anyway. You create step-by-step
ordered procedures with explicit state-machines for things that
really need to happen as written. You use threads for things that
must occur, but you don't give a damn when they occur (like updating
a window on the screen or sorting keys in a database).


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
