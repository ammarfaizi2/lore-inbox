Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWFHCfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWFHCfS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 22:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWFHCfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 22:35:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:58204 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932486AbWFHCfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 22:35:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U7lrD2GIQqo6j6fP1ITh7MrSAmBoR5Bq/InM0LST+JKuMhf2qod4nF9X/51Aot2XCH8gY9I//HskTW8clfPfNLj9bLN+P8cfttzgk5rDco2ubOr7p0wUGwLVPgOcjPUvqBMsZXN8A0cpsKbSodvST80s+jofCqRfviCJx0UQ3/A=
Message-ID: <9e4733910606071935o5f42f581g6392d5a23897fb09@mail.gmail.com>
Date: Wed, 7 Jun 2006 22:35:15 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Mathieu Desnoyers" <compudj@krystal.dyndns.org>
Subject: Re: Interrupts disabled for too long in printk
Cc: linux-kernel@vger.kernel.org, ltt-dev@shafik.org
In-Reply-To: <20060608023102.GA22022@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060603111934.GA14581@Krystal>
	 <9e4733910606071837l4e81c975t8d531ed9810af60f@mail.gmail.com>
	 <20060608023102.GA22022@Krystal>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/06, Mathieu Desnoyers <compudj@krystal.dyndns.org> wrote:
> * Jon Smirl (jonsmirl@gmail.com) wrote:
> > You can look at this problem from the other direction too. Why is it
> > taking 15ms to get between the two points? If IRQs are off how is the
> > serial driver getting interrupts to be able to display the message? It
> > is probably worthwhile to take a look and see what the serial console
> > driver is doing.
>
> Hi John,
>
> The serial port is configured at 38000 bauds. It can therefore transmit 4800
> bytes per seconds, for 72 characters in 15 ms. So the console driver would be
> simply busy sending characters to the serial port during that interrupt
> disabling period.

Why can't the serial console driver record the message in a buffer at
the point where it is being called with interrupts off, and then let
the serial port slowly print it via interupts? It sounds to me like
the serial port is being driven in polling mode.

>
> Mathieu
>
> OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
> Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
>


-- 
Jon Smirl
jonsmirl@gmail.com
