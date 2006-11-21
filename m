Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031342AbWKUTlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031342AbWKUTlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 14:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031339AbWKUTlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 14:41:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:35860 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1031343AbWKUTlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 14:41:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:reply-to:x-priority:message-id:to:cc:subject:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=kahrFjtFdSOHWdMHJMwIS2AHw4rF3Ma5nPS/wqaZdKowAgRXUL0X47ITH3AdYR1OgqMAAWvjGQNOE3DXpatbvBsGyxRw1yG2xkU1GqFIyrqQKyOjuEQzg2Tosz7sNq4w/Bn1Ftf73UO4kEAopVdRHc6nTG+/WcLXpFU1hEm/amU=
Date: Tue, 21 Nov 2006 21:41:06 +0200
From: Paul Sokolovsky <pmiscml@gmail.com>
Reply-To: Paul Sokolovsky <pmiscml@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <1928395959.20061121214106@gmail.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Matthew Frost <artusemrys@sbcglobal.net>,
       Arjan van de Ven <arjan@infradead.org>, <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>, Greg KH <gregkh@suse.de>
Subject: Re[2]: Where did find_bus() go in 2.6.18?
In-Reply-To: <20061121190150.GA25754@2ka.mipt.ru>
References: <1154868495.20061120003437@gmail.com> <4560ECAF.1030901@gmail.com> <664994303.20061120021314@gmail.com> <1164011675.31358.566.camel@laptopd505.fenrus.org> <4563457B.2070806@sbcglobal.net> <20061121190150.GA25754@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Evgeniy,

Tuesday, November 21, 2006, 9:01:50 PM, you wrote:

> On Tue, Nov 21, 2006 at 12:29:15PM -0600, Matthew Frost (artusemrys@sbcglobal.net) wrote:
>> So you have nested drivers.

   Matthew, thanks for your help, but it wasn't really my intention to
waste other people's time with fixing our drivers. We are kernel
hackers themselves, and eat our dogfood - with each kernel
release, we have bunch of drivers breaking, and we patiently fix them
(and yes, with recent releases, number of such drivers reduces, and
that makes us really happy with recent 2.6 releases).

   But, this particular case made me wonder - was it some issue with
change made in mainline, or there's something wrong with our manner to
write drivers? And we'd like to be updated in the latter case.

[]

>>
>> (cc: E. Polyakov for the w1 expertise)

> Hello.

> If find_bus() will not be resurrected, I can export w1_bus_type or
> create special helpers to directly access w1 bus master devices.
> But in that case there is no need to have all driver model in w1
> subsystem at all...

  Thanks for your response, Evgeniy!


  Ok, so now it's not just me, it's the maintainer of a bus subsystem
in mainline. There's no wonders, and one uncareful change in core API
will cascade to many other places. Commented out find_bus()? Now need to
make sure all bus types structures are exported. At least. But maybe
maintainers will also wonder what happens here, and shouldn't they
provide adhoc API to query a specific bus? And then indeed, what is
the use of LDM? Where did go idea of having common, bus- and driver-
independent API to do consistently all the stuff one *may* need (not
all feature of which everyone necessarily uses all the time).


P.S.
find_bus()is hardly a threat for kernel binary size and for bringing
more 2.4 users to 2.6:
http://lxr.linux.no/source/drivers/base/bus.c?v=2.6.18#L602

Well, I'd actually hardly ventured into arguing that its removal may
be not exactly right, if it wasn't such an obvious case of crippling
API for no real benefit. But it's not long cry for 2 lines of code,
but for understanding of where kernel goes...
  

>> Matt




-- 
Best regards,
 Paul                            mailto:pmiscml@gmail.com

