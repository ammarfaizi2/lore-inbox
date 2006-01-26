Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWAZOvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWAZOvN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWAZOvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:51:13 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:37588 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932351AbWAZOvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:51:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=AeWltI1ZdfXSD5RmAkXW8wNkRl2ZaWkomgffL+qPMew/605j1Xp+tYehhS+/bO9YAQj9+qgvlrTj9axHh4wxNBlCijg1HfOurPrtL6o8AF2mpcAr7HUP7RCz0ThWgALR02GHbATR+kct+/oLXnAphMDDrXErBfS7ixyWARSyfF0=
Message-ID: <43D8E1EE.3040302@gmail.com>
Date: Thu, 26 Jan 2006 22:51:26 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Hai Zaar <haizaar@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: vesa fb is slow on 2.6.15.1
References: <cfb54190601260620l5848ba3ai9d7e06c41d98c362@mail.gmail.com>
In-Reply-To: <cfb54190601260620l5848ba3ai9d7e06c41d98c362@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hai Zaar wrote:
> 
> # cat /proc/mtrr
> reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
> reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1
> reg02: base=0xc0000000 (3072MB), size= 512MB: write-back, count=1
> reg03: base=0x100000000 (4096MB), size= 512MB: write-back, count=1
> reg04: base=0xfeda0000 (4077MB), size= 128KB: uncachable, count=1
> 
> No 'write-combining' entry! But with 2.6.11.12 I do have one:
> <2.6.11.12 system> cat /proc/mtrr
> reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
> reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1
> reg02: base=0xc0000000 (3072MB), size= 512MB: write-back, count=1
> reg03: base=0x100000000 (4096MB), size= 512MB: write-back, count=1
> reg04: base=0xfeda0000 (4077MB), size= 128KB: uncachable, count=1
> reg05: base=0xf0000000 (3840MB), size= 128MB: write-combining, count=1

mtrr now defaults to off in vesafb because of conflicts with xorg/
xfree86.  You have to explicitly enable it with a boot option.  Try
this:

video=vesafb:mtrr:3,ypan

Tony
