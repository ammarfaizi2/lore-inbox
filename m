Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422637AbWGNQqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbWGNQqi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422638AbWGNQqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:46:38 -0400
Received: from web81212.mail.mud.yahoo.com ([68.142.199.116]:3180 "HELO
	web81212.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422637AbWGNQqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:46:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=bZrJYjhQAvu3t2y4oAqvCj2LsoGbOS3g9klOm+Qz3hlw9LYhl24ZeKBAVWe2JWJleqmjLVwun6is4i4N0+SJE20dFb2gJ8LY3b/v/UBX1LfyaEv3gRw9WocWGB7a3ehmpXr5HmtXQhl+x9etfDOZDERfc90Sy//Wl3/oQEXO3rs=  ;
Message-ID: <20060714164637.79842.qmail@web81212.mail.mud.yahoo.com>
Date: Fri, 14 Jul 2006 09:46:36 -0700 (PDT)
From: Aleksey Gorelov <dared1st@yahoo.com>
Subject: Re: [PATCH] Properly unregister reboot notifier in case of failure in ehci hcd
To: Andrew Morton <akpm@osdl.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       gregkh@suse.de, david-b@pacbell.net, stern@rowland.harvard.edu
In-Reply-To: <20060713191559.53ba7726.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@osdl.org> wrote:

> On Tue, 11 Jul 2006 23:38:41 -0700 (PDT)
> Aleksey Gorelov <dared1st@yahoo.com> wrote:
> 
> >   If some problem occurs during ehci startup, for instance, request_irq fails, echi hcd driver
> > tries it best to cleanup, but fails to unregister reboot notifier, which in turn leads to
> crash on
> > reboot/poweroff. Below is the patch against current git to fix this.
> >   I did not check if the same problem existed for uhci/ohci host drivers.
> 
> This patch causes hangs at reboot/shutdown/suspend time.  See
> http://www.zip.com.au/~akpm/linux/patches/stuff/dsc03597.jpg
> 
Oops, I did not test it with suspend/resume stuff, sorry. The problem is that ehci_run is called
from resume without its counterpart ehci_stop in suspend, so notifier ends up registered twice.

David, Alan,

Do you think it is Ok to unregister reboot notifier in ehci_run before registering one to make
sure there is no 'double registering' of notifier, or is it better to move register/unregister
reboot notifier from ehci_run/ehci_stop completely to some other place ?

Aleks.

