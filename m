Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbWFJAi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbWFJAi2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 20:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbWFJAi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 20:38:28 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:51735 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030395AbWFJAi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 20:38:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=KBdtL17Adsf28zCOS7NhXEkDd3bbLj+QSrKBDSdtNG3xrFg7ELiwotPHZvAArsz1+MIaON5+3muqcGVTd+9cEnA4Inn5Ux5xvFIN+NOQZS+w7/sWrxy29uUXMqJsS0EIxrGKiCf7v/W4HK9bdzpFMvchLPwKM2FQxHf51+NMBSs=
Message-ID: <448A147A.3030108@gmail.com>
Date: Sat, 10 Jun 2006 08:38:18 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] VT binding: Add sysfs support
References: <448933D7.6040301@gmail.com> <20060609220803.GB7636@suse.de>
In-Reply-To: <20060609220803.GB7636@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Jun 09, 2006 at 04:39:51PM +0800, Antonino A. Daplas wrote:
>> Add sysfs attributes for binding and unbinding VT console drivers. The
>> attributes are located in /sys/class/tty/console and are namely:
>>
>>     A. backend - list registered drivers in the following format:
>>
>>     "I C: Description"
> 
> No, this violates the "one value per file" issue with sysfs.  How do you
> know you will not overflow the buffer passed to you?

I was wondering about this. I just want a way to show what are the currently
loaded drivers, so it's a read-only attribute.  It's using snprintf (though
I haven't added a check for possible overflows, should be a 2-liner). Maximum
number of lines is 16, and there are examples of this rule-breakage in the
current sysfs tree.

/sys/class/usb_host/usb_hostx/device/pools

Yes, none are valid excuses.  Anyway, what would be the best way? I was
considering creating another class for vt_console, but that would entail
the creation of a new device major number just for this.

> 
>>     Where: I  = ID number of the driver
>>            C  = status of the driver which can be:
>>
>> 		S = system driver
>> 		B = bound modular driver
>> 		U = unbound modular driver
>>
>> 	   Description - text description of the driver
>>
>>     B. bind - binds a driver to the console layer
>>
>>        echo <ID> > /sys/class/tty/console/bind
>>
>>     C. unbind - unbinds a driver from the console layer
>>
>>        echo <ID> > /sys/class/tty/console/unbind
>>
>> The tty layer does nothing to these attributes except create them and punt all
>> requests to the VT layer.
> 
> Why is this needed?  What is wrong with the current scheme of binding
> ttys to the console?
> 

The binding part, maybe none, but that's still debatable.  It's the unbinding
feature that people are requesting.  Note the longish threads on "the future
of graphics subsystem".  It would also ease the life of console driver
developers, and it would stop people from pestering me on why they cannot unload
their beloved framebuffer console and drivers and go back to VGA console.

Tony
