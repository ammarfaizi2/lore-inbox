Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWCOOXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWCOOXt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 09:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWCOOXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 09:23:49 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:47886 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932140AbWCOOXs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 09:23:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <200603151534.41899.vda@ilport.com.ua>
x-originalarrivaltime: 15 Mar 2006 14:23:37.0403 (UTC) FILETIME=[0CA538B0:01C6483C]
Content-class: urn:content-classes:message
Subject: Re: /dev/stderr gets unlinked 8]
Date: Wed, 15 Mar 2006 09:23:37 -0500
Message-ID: <Pine.LNX.4.61.0603150913540.12854@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: /dev/stderr gets unlinked 8]
Thread-Index: AcZIPAzLv3C6+WPtS12D4nCj5ZDaVw==
References: <200603141213.00077.vda@ilport.com.ua> <20060315110252.GB31317@suse.de> <jehd5zq28o.fsf@sykes.suse.de> <200603151534.41899.vda@ilport.com.ua>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Denis Vlasenko" <vda@ilport.com.ua>
Cc: "Andreas Schwab" <schwab@suse.de>, "Stefan Seyfried" <seife@suse.de>,
       <linux-kernel@vger.kernel.org>, <christiand59@web.de>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Mar 2006, Denis Vlasenko wrote:

> On Wednesday 15 March 2006 15:14, Andreas Schwab wrote:
>> Stefan Seyfried <seife@suse.de> writes:
>>
>>> any good daemon closes stdout, stderr, stdin
>>
>> A real good daemon would redirect them to /dev/null.
>
> Yeah, yeah, let's first close stderr, and then proceed and
> add some code to handle command line --log=file, and to do
> logging to that file.
>
> Why good ol' fprintf(stderr,...) isn't enough? Why do you
> want to complicate things?
>
> What's so hard in doing "daemon 2>/dev/null &" if you don't
> want to save log?
> --
> vda

The daemon needs to have the standard input closed as well as
any I/O connection to a possible terminal. Just closing
standard input, allows a dup() in rogue code to recreate it.
Basically, file-descriptors 0, 1, and 2, need to be USED and
used for something else (like open /dev/null or open "/").
That's how you prevent rogue code, inserted via overflow or
other means, from obtaining control of your system.
Good daemons also use system services to write messages to
log files. They don't make their own, which is one of the
reasons why early versions of `sendmail` were not considered
"good" daemons.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
