Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbUL2UOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbUL2UOH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 15:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUL2UOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 15:14:07 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:19624 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261397AbUL2UN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 15:13:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=b1mkkRlJAlRyMWoIXfMYJrJIxHmLSoD3qGo7bfHy8y5GvUEGtztbrqYs3zax3zZuFKi6xSeLJbL9h7oX1WX/xg0B2a3z0dsZBqaVpaeD8N6jv5u7U/l9VJgcndJIasbcY/iX6TZUGFEIEE8BnMeqY4h0PnJ4VhgKouGHzyxwr24=
Message-ID: <5304685704122912132e3f7f76@mail.gmail.com>
Date: Wed, 29 Dec 2004 13:13:57 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
Reply-To: Jesse Allen <the3dfxdude@gmail.com>
To: Thomas Sailer <sailer@scs.ch>
Subject: Re: ptrace single-stepping change breaks Wine
Cc: Mike Hearn <mh@codeweavers.com>, Linus Torvalds <torvalds@osdl.org>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       wine-devel <wine-devel@winehq.com>
In-Reply-To: <1104348944.5645.2.camel@kronenbourg.scs.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_732_16360802.1104351237388"
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <20041119212327.GA8121@nevyn.them.org>
	 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
	 <20041120214915.GA6100@tesore.ph.cox.net>
	 <41A251A6.2030205@wanadoo.fr>
	 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>
	 <1101161953.13273.7.camel@littlegreen>
	 <1104286459.7640.54.camel@gamecube.scs.ch>
	 <1104332559.3393.16.camel@littlegreen>
	 <1104348944.5645.2.camel@kronenbourg.scs.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_732_16360802.1104351237388
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 29 Dec 2004 20:35:44 +0100, Thomas Sailer <sailer@scs.ch> wrote:
> 
> Mike,
> 
> thanks a lot for your mail. I've just tried Jesse Allen's Patch with
> 2.6.10-ac1, but unfortunately it doesn't seem to be enough to get xst
> working again. Let me know if (and how :)) I can help gather evidence.
> 
> Tom
> 
> 


If the single-stepping changes truly broke your program, and you know
< 2.6.9-rc1 works, try this attached diff against 2.6.10 in addition
to the other one I made.  This should effectively reverse change #2,
but like I said, the current code for change #2 actually works for me
now.  But maybe this is not enough.  You can also look here at my
original report:

http://www.winehq.org/hypermail/wine-devel/2004/11/0310.html

and reverse the original patches against 2.6.9, and see if that kernel
works then. Patch links:

http://linux.bkbits.net:8080/linux-2.6/cset@1.1803.144.55
http://linux.bkbits.net:8080/linux-2.6/cset@1.1832.60.196
http://linux.bkbits.net:8080/linux-2.6/cset@1.1847

Jesse

------=_Part_732_16360802.1104351237388
Content-Type: text/x-diff; name="sigtrap-reverse.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="sigtrap-reverse.diff"

--- linux/arch/i386/kernel/signal.c=092004-12-29 12:54:59.000000000 -0700
+++ linux-mod/arch/i386/kernel/signal.c=092004-12-29 12:53:23.000000000 -07=
00
@@ -426,8 +426,8 @@
 =09 */
 =09if (regs->eflags & TF_MASK) {
 =09=09regs->eflags &=3D ~TF_MASK;
-=09=09if (current->ptrace & PT_DTRACE)
-=09=09=09ptrace_notify(SIGTRAP);
+//=09=09if (current->ptrace & PT_DTRACE)
+//=09=09=09ptrace_notify(SIGTRAP);
 =09}
=20
 #if DEBUG_SIG

------=_Part_732_16360802.1104351237388--
