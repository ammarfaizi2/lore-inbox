Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbVIDIrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVIDIrn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 04:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVIDIrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 04:47:43 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:11626 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751306AbVIDIrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 04:47:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=o90kKTJg0kDSr4CaiK2liJSZV0i21p5FZAAvJp7A/DV/DSz0D0fW6NovXFrA8xXLMP1+tUapwfj4Zb8fc12erkq9A2IFkvHvliHCcnGDn+ZHX+y+t9ClabeAvdUtjE1nB1Pw/uuF5Dj/z089Tq/Z/AaAcgrf3kFgArySlE5sWRM=
Date: Sun, 4 Sep 2005 17:47:32 +0900
From: Tejun Heo <htejun@gmail.com>
To: Andreas Hartmann <andihartmann@01019freenet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: forbid to strace a program
Message-ID: <20050904084732.GA30256@htj.dyndns.org>
References: <4IOGw-1DU-11@gated-at.bofh.it> <4IOGw-1DU-13@gated-at.bofh.it> <4IOGw-1DU-9@gated-at.bofh.it> <4IOQc-1Pk-23@gated-at.bofh.it> <dfe7ui$14q$1@pD9F874C0.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfe7ui$14q$1@pD9F874C0.dip0.t-ipconnect.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 09:32:34AM +0200, Andreas Hartmann wrote:
> Chase Venters wrote:
> >> Is there another way to do this? If the password is crypted, I need a
> >> passphrase or something other to decrypt it again. Not really a solution
> >> of the problem.
> >>
> >> Therefore, it would be best, to hide it by preventing stracing of the
> >> application to all users and root.
> >>
> >> Ok, root could search for the password directly in the memory, but this
> >> would be not as easy as a strace.
> > 
> > Obfuscation isn't really valid security. Making something 'harder' to break 
> > isn't a solution unless you're making it hard enough that current technology 
> > can't break it (eg... you always have the brute force option, but good crypto 
> > intends to make such an option impossible without expending zillions of clock 
> > cycles). 
> 
> You're right. If I would have a solution, which could do this, I would
> prefer it.
> 
> > 
> > Can I ask why you want to hide the database password from root?
> 
> It's easy: for security reasons. There could always be some bugs in some
> software, which makes it possible for some other user, to gain root
> privileges. Now, they could easily strace for information, they shouldn't
> could do it. The password they could see, isn't just used for the DB, but
> for some other applications, too. That's the disadvantage of general
> (single sign on) passwords.
> 

 I'm no security expert, but if root privileges are compromised,
there's no way to plug anything.  A kernel module can be loaded to do
just about anything.  Signals can be sent to obtain core dumps.
Binaries can be switched.  Network traffics can be sniffed.  Kernel
image can be replaced and rebooted while no one is watching without
leaving any record.

 If security is important for your application, move the application
into a separate machine in a physically protected place and use very
restrictive firewall.  Plugging strace() will make little (if any)
change w.r.t. security.

-- 
tejun
