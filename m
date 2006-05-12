Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWELOdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWELOdf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 10:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWELOdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 10:33:35 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:2370 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932096AbWELOde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 10:33:34 -0400
Date: Fri, 12 May 2006 08:32:37 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Linux poll() <sigh> again
In-reply-to: <Pine.LNX.4.61.0605120745050.8670@chaos.analogic.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <44649C85.5000704@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6bkl7-56Y-11@gated-at.bofh.it> <4463D1E4.5070605@shaw.ca>
 <Pine.LNX.4.61.0605120745050.8670@chaos.analogic.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
>> POLLHUP means "The device has been disconnected." This would obviously
>> be appropriate for a device such as a serial line or TTY, etc. but for a
>> socket it is less obvious that this return value is appropriate.
>>
> 
> Hardly "less obvious". SunOs has returned POLLHUP as has other
> Unixes like Interactive, from which the software was ported. It
> went from Interactive, to SunOs, to Linux. Linux was the first
> OS that required the hack. This was reported several years ago
> and I was simply excoriated for having the audacity to report
> such a thing. So, I just implemented a hack. Now the hack is
> biting me. It's about time for poll() to return the correct
> stuff.

The standard doesn't require that a close on a socket should report 
POLLHUP. Thus this behavior may differ between UNIX implementations. If 
your software is requiring a POLLHUP to indicate the socket is closed I 
think it is being unnecessarily picky since read returning 0 universally 
indicates that the connection has been closed. Such are the compromises 
that are sometimes required to write portable software.

> 
>>> I have used the subsequent read() with a returned
>>> value of zero, to indicate that the client disconnected
>>> (as a work around). However, on recent versions of
>>> Linux, this is not reliable and the read() may
>>> wait forever instead of immediately returning.
>> If you want nonblocking behavior, you should set the socket to
>> nonblocking. This is a bit strange though, unless the data was stolen by
>> another thread or something. Are you sure you've seen this?
> 
> I don't use threads. The hang under the specified conditions was first
> observed on 2.6.16.4 (that I'm running on this system). The hack, previously
> used, i.e., the read of zero was used since 2.4.x with success except it's
> a hack and shouldn't be required. It was not ever required on SunOs from
> which the software was ported.

This may be a bug somewhere.. however, once again if you don't want read 
to block under any circumstances, set your sockets to non-blocking!

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

