Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWFJRBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWFJRBx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 13:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWFJRBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 13:01:53 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:49221 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932255AbWFJRBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 13:01:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ANrvmQz4jJqSGyzjgpUBlWli0yyiYQqx+JPPL8S6WLlV5+gmr0pQRFFF2cJspqd8+KpsLNB9+w8cFs1VT4N7YbzkMKo3alETRAqLc5dlA2OhtJJNj6pGFVqKZxdH+xItY0WDhZ1+zqNfJvIVuY0752eOBhdByT0KHP5y3qUIevM=
Message-ID: <9e4733910606101001j1a10eb9x89d4c2b200fe5ba8@mail.gmail.com>
Date: Sat, 10 Jun 2006 13:01:52 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file describing the feature
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       "Greg KH" <greg@kroah.com>
In-Reply-To: <9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44893407.4020507@gmail.com>
	 <9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>
	 <448AC8BE.7090202@gmail.com>
	 <9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> The problem with the previous system was that bind(register) and open
> were combined into a single operation when they should be separate. I
> should be able to load four console drivers and then pick the one I
> want to switch to without automatically having the console jump to
> each device as the drivers are loaded.

I should clarify this, take_over_console() combines the registration
and open operations. If I loaded four console drivers using
take_over_console() my console would bounce from device to device as
the drivers are loaded. The real problem with the take_over_console()
implementation was that it effectively made loading console drivers
into a stack operation instead of a set operation.

take_over_console() is not incompatible with the scheme I described in
the previous mail if the implementation is changed inside console.
The new implementation would just call the register and open
operations as described earlier. When loading four consoles using
take_over_console() you would still bounce through the four consoles
but once loaded the console drivers would act as a set. You could use
sysfs to switch to any of the registered consoles. If a console driver
is not open it could be unloaded in any order.

Long term I think take_over_console() should be deprecated in favor of
a register(bind) call from the console driver and an explicit sysfs
action to move the console.

-- 
Jon Smirl
jonsmirl@gmail.com
