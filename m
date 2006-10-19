Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945919AbWJSAUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945919AbWJSAUw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 20:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945921AbWJSAUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 20:20:52 -0400
Received: from mail29.messagelabs.com ([216.82.249.147]:65253 "HELO
	mail29.messagelabs.com") by vger.kernel.org with SMTP
	id S1945919AbWJSAUv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 20:20:51 -0400
X-VirusChecked: Checked
X-Env-Sender: Scott_Kilau@digi.com
X-Msg-Ref: server-21.tower-29.messagelabs.com!1161217250!31352083!1
X-StarScan-Version: 5.5.10.7; banners=-,-,-
X-Originating-IP: [66.77.174.21]
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: kernel oops with extended serial stuff turned on...
Date: Wed, 18 Oct 2006 19:20:49 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9FA473E9@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel oops with extended serial stuff turned on...
Thread-Index: AcbzDFL8lqebBufGT3WMKIbGJkKp8QABv6tp
References: <335DD0B75189FB428E5C32680089FB9F803FE8@mtk-sms-mail01.digi.com> <20061018230939.GA7713@kroah.com>
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Greg KH" <greg@kroah.com>
Cc: <Greg.Chandler@wellsfargo.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Oct 2006 00:20:50.0232 (UTC) FILETIME=[6E50C380:01C6F314]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
 
> What other driver is using the ttyM0 name?
> Any pointer to your driver's code so I can see if you are doing
> something odd here?  Any reason it's just not in the main kernel tree so
> I would have fixed it up at the time I did the other fixes?

Sorry,
I probably shouldn't have brought my driver up,
its just confusing things. =)
 
Greg C is not running any of my out-of-tree drivers,
or even using one of our (Digi) boards.
 
I just saw his warning/error, and noticed it was the same as what I saw
back when 2.6.18 was released, so I figured I would hop in and
explain what I did to fix the problem in my driver...
 
(BTW, the error turns up a few times in a google of...
"don't try to register things with the same name in the same directory."
I wonder if all the "tty" ones are all related...)
 
In Greg C's case, he turned on *all* the serial options in "make config",
because he wasn't sure which serial card he had...
 
Turns out that the driver/char/isicom.c driver claimed his board, and then
tried to register the ttyM0 name, which apparently someone else
in the kernel did already...
 
You have a good point tho, we probably should actually look at /dev/ttyM0
on his system, and see who is actually claiming it already...
 
Scott
 
