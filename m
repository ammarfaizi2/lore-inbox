Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751844AbWIGNTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbWIGNTU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 09:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbWIGNTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 09:19:19 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:46480 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751844AbWIGNTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 09:19:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=A2d6IUMGaqwAGVY4gc8Ws71xTk//y3tU8v2e5BODIMJGVPHwzAZtYHmhqKUL+08EPOEzGjCqHPhsZYG9JLR57o7CAUAOM1+3XpvpkdvD9dLKquCK5h25JNYIrBqi/z/wMC6OI8h2uWAS26qG9/7PyP4xYLv6yzgeDdUhP+rgs3Y=
Message-ID: <45001C48.6050803@gmail.com>
Date: Thu, 07 Sep 2006 15:19:04 +0200
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Arjan van de Ven <arjan@infradead.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: question regarding cacheline size
References: <44FFD8C6.8080802@gmail.com> <20060907111120.GL2558@parisc-linux.org> <45000076.4070005@gmail.com> <20060907120756.GA29532@flint.arm.linux.org.uk> <20060907122311.GM2558@parisc-linux.org> <1157632405.14882.27.camel@laptopd505.fenrus.org> <20060907124026.GN2558@parisc-linux.org> <45001665.9050509@gmail.com> <20060907130401.GO2558@parisc-linux.org>
In-Reply-To: <20060907130401.GO2558@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Thu, Sep 07, 2006 at 02:53:57PM +0200, Tejun Heo wrote:
>> The spec says that devices can put additional restriction on supported 
>> cacheline size (IIRC, the example was something like power of two >= or 
>> <= certain size) and should ignore (treat as zero) if unsupported value 
>> is written.  So, there might be need for more low level driver 
>> involvement which knows device restrictions, but I don't know whether 
>> such devices exist.
> 
> That's nothing we can do anything about.  The system cacheline size is
> what it is.  If the device doesn't support it, we can't fall back to a
> different size, it'll cause data corruption.  So we'll just continue on,
> and devices which live up to the spec will act as if we hadn't
> programmed a cache size.  For devices that don't, we'll have the quirk.

For MWI, it will cause data corruption.  For READ LINE and MULTIPLE, I 
think it would be okay.  The memory is prefetchable after all.  Anyways, 
this shouldn't be of too much problem and probably can be handled by 
quirks if ever needed.

> Arguably devices which don't support the real system cacheline size
> would only get data corruption if they used MWI, so we only have to
> prevent them from using MWI; they could use a different cacheline size
> for MRM and MRL without causing data corruption.  But I don't think we
> want to go down that route; do you?

Oh yeah, that's what I was trying to say, and I don't want to go down 
that route.  So, I guess this one is settled.

Thanks.

-- 
tejun
