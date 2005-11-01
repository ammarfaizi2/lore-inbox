Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVKALX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVKALX1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 06:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVKALX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 06:23:27 -0500
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:24208 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750748AbVKALX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 06:23:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
  b=4ZwIi3cbJhpavPzOkjXW6iU5uD9rc1dJ3Bch1F6I4AaezDufvsN665YVDGNn8MPE+CQdpruRlWGfUpVO614802G+b6onOd1Al1YCvU+zpm7aB8Y/silAXe39htrNBBXCIyxSOkUOtslhEM+syCXWrdoNNHvdT29J/jkd1pxjaLI=  ;
Date: Tue, 1 Nov 2005 12:23:21 +0100
From: Borislav Petkov <bbpetkov@yahoo.de>
To: David Brownell <david-b@pacbell.net>
Cc: Borislav Petkov <bbpetkov@yahoo.de>,
       Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: Linux 2.6.14 ehci-hcd hangs machine
Message-ID: <20051101112321.GA8691@gollum.tnic>
References: <0EF82802ABAA22479BC1CE8E2F60E8C376CE22@scl-exch2k3.phoenix.com> <20051031221541.GA31948@gollum.tnic> <200510311624.31680.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510311624.31680.david-b@pacbell.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 04:24:31PM -0800, David Brownell wrote:
> On Monday 31 October 2005 2:15 pm, Borislav Petkov wrote:
> > > >and dies. This bug is actually in there since 2.6.14-rc4 (see:
> > > >http://bugzilla.kernel.org/show_bug.cgi?id=5428) and David Brownell
> > > >supplied a patch which turned out to be useless eventually 
> > > >since _rebooting_ 
> > > >the kernel with the 'usb-handoff' (and without the patch) 
> > > >solved the problem. 
> 
> In current GIT kernels (2.6.14+) that patch is now merged, and
> also usb-handoff is the default.
Just tested 2.6.14 from the git repo of today and the machine hangs at
the same point in the boot process.
> 
> 
> > > >As it turns out, it actually solves the problem only for the 
> > > >reboot case.
> > > >My machine still hangs on an initial boot with and without 
> > > >'usb-handoff'.
> 
> Huh?  That's not what you'd reported before.  What changed?
> You're saying that _with_ that patch, and usb-handoff, it fails?
Yeah, the symptoms are really weird. Let me rehash the whole history:
First, we did some testing with 2.6.14-rc4, _with_ the patch and the
'handoff' cmd option and it worked. Then, several boots later, I noticed
that it started hanging itself again at the same position not while rebooting 
but at _initial_ boot in the morning. Then, you told me on bugzilla that
in my case the patch shouldn't be needed since i'm using 'usb-handoff'
but, unfortunately, without the patch and with usb-handoff it hangs itself too. 
2.6.14 shows the same behavior and the git kernel i compiled this morning hangs 
itself too, as i said above.

To sum up, IMHO, the patch helps partially only while rebooting. Initial
boots still remain hanging so there's got to be something else that
kills the machine. maybe some IRQs or something? The thing is that not
even sysrq is functional, I don't get any BUG() traces or anything - 
the hang is pretty tough. 2.6.13, in contrast, boots just fine. Hope
that helps,

	 Boris.

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
