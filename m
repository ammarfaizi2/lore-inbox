Return-Path: <linux-kernel-owner+w=401wt.eu-S1030490AbXALFez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030490AbXALFez (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 00:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160998AbXALFez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 00:34:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44005 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030490AbXALFez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 00:34:55 -0500
Message-ID: <45A71DEA.9020307@redhat.com>
Date: Fri, 12 Jan 2007 00:34:34 -0500
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Avi Kivity <avi@qumranet.com>
CC: Ingo Molnar <mingo@elte.hu>, kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kvm & dyntick
References: <45A66106.5030608@qumranet.com>
In-Reply-To: <45A66106.5030608@qumranet.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:

> dyntick-enabled guest:
> - reduce the load on the host when the guest is idling
>   (currently an idle guest consumes a few percent cpu)

You do not need dynticks for this actually.  Simple no-tick-on-idle
like Xen has works well enough.

While you're modifying the timer code, you might also want to add
proper accounting for steal time.  Time during which your guest
had a runnable process, but was not actually running itself, should
not be accounted against the currently running process.

I wonder if it would be possible to simply copy some of the timer
code from Xen.  They have the timing quirks worked out very well
and their timer_interrupt() is pretty nice code.

(Now I need to buy myself another VT box so I can help out with KVM :))

http://virt.kernelnewbies.org/ParavirtBenefits has some other features
you may want to have :)))

-- 
Politics is the struggle between those who want to make their country
the best in the world, and those who believe it already is.  Each group
calls the other unpatriotic.
