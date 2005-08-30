Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVH3WjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVH3WjS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVH3WjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:39:18 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:59452 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S932240AbVH3WjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:39:17 -0400
Message-ID: <4314DFED.8030608@novell.com>
Date: Tue, 30 Aug 2005 15:38:37 -0700
From: Crispin Cowan <crispin@novell.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: LSM root_plug module questions
References: <20050830213112.GA28997@hardeman.nu> <20050830215518.GX7991@shell0.pdx.osdl.net>
In-Reply-To: <20050830215518.GX7991@shell0.pdx.osdl.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * David Härdeman (david@2gen.com) wrote:
>   
>> 2) root_plug currently scans the usb device tree looking for the 
>> appropriate device each time it's needed. In the interest of making the 
>> result of the lookup cached, it is possible for a module to register so 
>> that it is notified when a usb device is added/removed?
>>     
> I don't think that can be done in a race free manner.  Perhaps get the
> device and check its state, but you'd have to ask usb folks.  ATM, it's
> only checked during exec of root process.
>   
Why do you want to optimize root_plug's scan for the device? Are you
planning on logging in thousands of times per second? If it was a big
RADIUS or SSO server, that would make sense, but this is the "are you
physically present at the console?" login security, so I submit that it
happens at most a couple of times per minute, and from there it does not
matter if it takes a second or two to scan the USB devices.

OTOH, it looks from the above comments that the root_plug may be checked
on *all* exec's of root processes. If that is the case, then you do have
more of an optimization issue. However, I then submit that the correct
optimization is to choke down the check so that it is only performed on
root exec's that represent logins rather than all execs, instead of
trying to make the check go faster.

Crispin
-- 
Crispin Cowan, Ph.D.                      http://crispincowan.com/~crispin/
Director of Software Engineering, Novell  http://novell.com

