Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262815AbVHETmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbVHETmE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 15:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbVHESNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:13:20 -0400
Received: from imap.gmx.net ([213.165.64.20]:2203 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262815AbVHESLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:11:11 -0400
X-Authenticated: #1725425
Date: Fri, 5 Aug 2005 20:09:45 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: jmorris@namei.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil
Subject: Re: preempt with selinux NULL pointer dereference
Message-Id: <20050805200945.2bc1f57e.Ballarin.Marc@gmx.de>
In-Reply-To: <1123260373.4471.8.camel@dhcp-192-168-22-217.internal>
References: <1123234785.7889.7.camel@dhcp-192-168-22-217.internal>
	<Pine.LNX.4.63.0508051024100.559@excalibur.intercode>
	<1123260373.4471.8.camel@dhcp-192-168-22-217.internal>
X-Mailer: Sylpheed version 2.0.0rc (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Aug 2005 17:46:13 +0100
Antoine Martin <antoine@nagafix.co.uk> wrote:

> > > [ 4788.218995] Pid: 19002, comm: ssh Tainted: G   M  2.6.13-rc5
> > 
> > Which of your modules is non-GPL and can you please remove them and see if 
> > there's still a problem?
> Hmm. I occasionally use out-of-tree drivers (wlan cards mainly) so I
> thought these could be the culprit, but all the above are in the source
> tree (I keep the others out):

>From Documentation/oops-tracing.txt:
'G' if all modules loaded have a GPL or compatible license, 'P' if
 any proprietary module has been loaded.
...

In other words, your kernel is tainted, but all modules are GPL.

See also the check in panic.c:
...
tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',
...

It seems that yout kernel was tainted by a machine check exception (MCE).
This should be visible in dmesg somewhere, and might indicate a hardware
problem.

Regards
