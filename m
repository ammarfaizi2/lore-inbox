Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVAZNcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVAZNcH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 08:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVAZNcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 08:32:07 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:22104 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262282AbVAZNcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 08:32:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=RuSZIshv7Nb/DvdW4M6e0zPw+d5aPEW6C2mav1IWA2kmDR8xnfLlOc/FSmLrsRBeKDoRlPTkPZOLO9jqPvedl2HV1g+nzJZ/JZwqC9Y8QFOz9z3Vgc7X8Rl5VOk2yy0FssHkvSH1T3SmURdEGnF7JkxnivcKD4nVCPp6aB70ADw=
Message-ID: <d120d50005012605323111927a@mail.gmail.com>
Date: Wed, 26 Jan 2005 08:32:02 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: johnpol@2ka.mipt.ru
Subject: Re: 2.6.11-rc2-mm1
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <1106728267.5257.116.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050125125323.GA19055@infradead.org>
	 <1106662284.5257.53.camel@uganda>
	 <20050125142356.GA20206@infradead.org>
	 <1106666690.5257.97.camel@uganda>
	 <20050125224247.GA29849@infradead.org>
	 <1106728267.5257.116.camel@uganda>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005 11:31:07 +0300, Evgeniy Polyakov
<johnpol@2ka.mipt.ru> wrote:
> On Tue, 2005-01-25 at 22:42 +0000, Christoph Hellwig wrote:
> > > Yes, and it is better than removing module whose structures are in use.
> > > SuperIO core is asynchronous in it's nature, one can use logical device
> > > through superio core and remove it's module on other CPU, above loop
> > > will
> > > wait untill all reference counters are dropped.
> >
> > General rule is: increment module reference count while the hardware
> > is actually in use, and let device structures be allocated by the
> > bus core so drivers can be freed with them still allocated.  That's
> > how the driver model and thus about every other subsystem works.
> 
> It is not general rule - network stack does not have such mechanism,
> which is
> very good, I doubt each block device module increment it's module
> reference
> when it catch a request...
> It is internal structure that has reference counter, not module itself,
> and this
> structure may be in use, when module is unloaded, thus unloading must
> wait,
> untill all it's structures are freed.
> 

No, it does not necessarily has to wait. You can unload driver at any
time if you care to mark all its devices as "dead" and you have
generic release function in a separate module that does not get
unloaded until last registered device has been destroyed. Look for
example at serio code. I think USB is about the same.

-- 
Dmitry
