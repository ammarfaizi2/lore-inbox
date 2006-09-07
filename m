Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWIGMyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWIGMyM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 08:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbWIGMyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 08:54:11 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:24800 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751492AbWIGMyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 08:54:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=m11pDeWgMc+URyqrr62L5EvbCyLiyicigz0JpLlKb9CYLlXgjAlg7QNSz9jfWk74jqu55G4lmo9rvsaxkINAJJCdqtUQqkfSaGFcy6cj+FB/nSnMaNZVPVo3YSEFhpAJY8fnTYBk0tvv4HV1JeFgo5KbiFibYNK5qM0CBBzI3tw=
Message-ID: <45001665.9050509@gmail.com>
Date: Thu, 07 Sep 2006 14:53:57 +0200
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Arjan van de Ven <arjan@infradead.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: question regarding cacheline size
References: <44FFD8C6.8080802@gmail.com> <20060907111120.GL2558@parisc-linux.org> <45000076.4070005@gmail.com> <20060907120756.GA29532@flint.arm.linux.org.uk> <20060907122311.GM2558@parisc-linux.org> <1157632405.14882.27.camel@laptopd505.fenrus.org> <20060907124026.GN2558@parisc-linux.org>
In-Reply-To: <20060907124026.GN2558@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Thu, Sep 07, 2006 at 02:33:25PM +0200, Arjan van de Ven wrote:
>>> So I think we should redo the PCI subsystem to set cacheline size during
>>> the buswalk rather than waiting for drivers to ask for it to be set.
>> ... while allowing for quirks for devices that go puke when this
>> register gets written ;)
>>
>> (afaik there are a few)
> 
> So you want:
> 
> 	unsigned int no_cls:1;	/* Device pukes on write to Cacheline Size */
> 
> in struct pci_dev?

The spec says that devices can put additional restriction on supported 
cacheline size (IIRC, the example was something like power of two >= or 
<= certain size) and should ignore (treat as zero) if unsupported value 
is written.  So, there might be need for more low level driver 
involvement which knows device restrictions, but I don't know whether 
such devices exist.

-- 
tejun
