Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030418AbVLNCOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbVLNCOB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 21:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030420AbVLNCOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 21:14:01 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:62757 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030418AbVLNCOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 21:14:00 -0500
Date: Tue, 13 Dec 2005 20:13:17 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Strange delay on PCI-DMA-transfer completion by
 wait_event_interruptible()
In-reply-to: <5jnfV-2xy-577@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <439F7FBD.60300@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5jeNG-740-1@gated-at.bofh.it> <5jnfV-2xy-577@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> Every time somebody wants to rewrite a macro, they declare that the
> previous one had some race condition. If, in fact, you have only
> one DMA occurring from your device then no race is possible with
> interruptible_sleep_on(). wait_event_interruptible() is the same thing
> but with an additional access to some memory variable, possibly
> causing a cache refill which means it might take more time.

This is not correct. Using interruptible_sleep_on, there is no way to 
prevent the race where the condition being waited on happens between the 
test to see if it has become true and calling interruptible_sleep_on. 
wait_event_interruptible puts the caller into the wait queue before 
testing the condition, which prevents the race.

interruptible_sleep_on is, with good reason, no longer recommended for use.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

