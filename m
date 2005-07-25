Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVGYO2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVGYO2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 10:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVGYO2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 10:28:35 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:62026 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261233AbVGYO23 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 10:28:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B1ct+Egwr8vemPAse62Y5IAJriu/P768+O8d6X8HDWzTGR9w8045gr8cPuLMkRMrVbBgVf87ljKKlkgAbkITL309KPwoyw2F+NfCbV28SfmNnNZWZP6UlF3vAxHL0eEgwvWPJSsHD16oA9Zublm27EcIzDWuxxk2VuTtGIYXuwM=
Message-ID: <9e4733910507250728a7882d4@mail.gmail.com>
Date: Mon, 25 Jul 2005 10:28:27 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
In-Reply-To: <200507242358.12597.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e47339105072421095af5d37a@mail.gmail.com>
	 <200507242358.12597.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> On Sunday 24 July 2005 23:09, Jon Smirl wrote:
> > I just pulled from GIT to test bind/unbind. I couldn't get it to work;
> > it isn't taking into account the CR on the end of the input value of
> > the sysfs attribute.  This patch will fix it but I'm sure there is a
> > cleaner solution.
> >
> 
> "echo -n" should take care of this problem I think.

That will work around it but I think we should fix it.  Changing to
strncmp() fixes most cases.

-       if (strcmp(name, dev->bus_id) == 0)
+       if (strncmp(name, dev->bus_id, strlen(dev->bus_id)) == 0)

I work in this area and I couldn't figure out why it was silently not
working. I had to add the printk to the source before I could figure
it out. I suspect most people are going to have this trouble.

This has also made me realize that I have created other places in the
kernel where my sysfs attribute code is not going to work correctly.
Maybe we should adjust the sysfs driver to strip leading and trailing
white space before passing the string on.

-- 
Jon Smirl
jonsmirl@gmail.com
