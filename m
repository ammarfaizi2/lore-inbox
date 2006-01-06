Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWAFN3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWAFN3h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 08:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWAFN3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 08:29:37 -0500
Received: from [81.2.110.250] ([81.2.110.250]:37253 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751343AbWAFN3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 08:29:37 -0500
Subject: Re: oops pauser.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060105205221.GN20809@redhat.com>
References: <20060105045212.GA15789@redhat.com>
	 <1136468254.16358.23.camel@localhost.localdomain>
	 <20060105205221.GN20809@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Jan 2006 13:31:10 +0000
Message-Id: <1136554270.30498.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-05 at 15:52 -0500, Dave Jones wrote:
> The huge number of oopses never hit the logs.
> They either hit early in boot before syslog is even running, or
> they kill the box.

So you don't need a two minute delay for those because as you said it
froze the box
>  
>  > and continuing generally will hang the box
>  > stopping the scroll keys being used or dmesg being used to get the data
>  > out. 
> 
> This is exactly the problem this patch addresses.
> The 'scroll keys' do not work in cases where we lock up after an oops.

And in those cases the 2 minute freeze is meaningless

> The real-world disagrees with you. In the few weeks it's been in Fedora,
> several previously undiagnosable oopses were caught, and even *users*
> agreed it was a useful addition.   If the two minutes is excessive, we can
> lower it, or even make it a boot-option.

Any change will capture different oopses. A boot option isnt a bad idea,
or for that matter also truncating the call trace to the *top* few (or
as Bryce suggested on irc reversing the printing order)

> Another possibility is instantly continuing after a keypress.

If the input layer is running that would be sensible.

>  > The console has awareness of graphic/text mode at all times and knows
>  > what is going on. Why not use that information if you must go this way ?
> 
> If we've just oopsed, the console may have no awareness of what day it is,
> yet alone anything about video modes. I'm not entirely sure what you're
> suggesting, but it gives me the creeps. Are you talking about switching
> away from X back to a tty when we oops?

Well you could try and do that but I was more thinking that if the
console has been told we are in graphics mode then the 2 minute delay
shouldn't occur.

Alan

