Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVCWK47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVCWK47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 05:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVCWK47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 05:56:59 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:62415 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261513AbVCWK4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 05:56:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=O1Zqu09KHFWRbENmDNeVG6DrPjDWEbZzQZor23ZFHw1ILL8K1aM8hTh4NM2Ko4uBCD2GfhdPDAJk+JdNLdVOVHI5uqnra51tADSU+7sc2hC0j2qD9N6s2ZsbDczuCZflZiBQmm5XHJONG/3Sc000aFJ4pVyJKd7b/nvmHIiCLJc=
Message-ID: <9cde8bff050323025663637241@mail.gmail.com>
Date: Wed, 23 Mar 2005 19:56:55 +0900
From: aq <aquynh@gmail.com>
Reply-To: aq <aquynh@gmail.com>
To: "Hikaru1@verizon.net" <Hikaru1@verizon.net>
Subject: Re: forkbombing Linux distributions
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050322125025.GA9038@roll>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
	 <20050322112628.GA18256@roll>
	 <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
	 <20050322124812.GB18256@roll> <20050322125025.GA9038@roll>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005 07:50:25 -0500, Hikaru1@verizon.net
<Hikaru1@verizon.net> wrote:
> On Tue, Mar 22, 2005 at 12:49:58PM +0100, Jan Engelhardt wrote:
> > >
> > >This will prevent it from exceeding the procs limits, but it will *not*
> > >completely stop it.
> >
> > What if the few procs that he may spawn also grab so much memory so your
> > machine disappears in swap-t(h)rashing?
> While I have figured out how it'd be possible in theory to prevent things
> from grabbing so much memory that your computer enters swap death, I haven't
> been able to figure out what reasonable defaults would be for myself or
> others. Soooo, I suggest everyone who is worried about this check the
> manpage for 'limits' which tells you how to do this. My machine runs various
> rediculously large and small programs - I'm not sure a forkbomb could be
> stopped without hindering the usage of some of the games on my desktop
> machine.
> 
> On a server or something with multiple users however, I'm sure you could
> configure each user independently with resource limits. Most servers
> don't have users that play games which take up 90% of the ram. :)
> 
> In any case, I was forced by various smarter-than-I people to come up with a
> better solution to our problem as they were able to make forkbombs that did
> a much better job of driving me crazy. :)
> 
> If you edit or create /etc/limits and set as the only line
> 
> * U250
> 
> It'll do the same thing as the sysctl hack, except root will still be able
> to run programs. Programs like ps and kill/killall.
> 
> If you've actually implemented the sysctl.conf hack I spoke of previously, I
> suggest setting it back to whatever it used to be before, or deleting the
> line from /etc/sysctl.conf altogether.
> 
> /etc/limits does a better job at stopping forkbombs.
> 
> This is an example of a program in C my friends gave me that forkbombs.
> My previous sysctl.conf hack can't stop this, but the /etc/limits solution
> enables the owner of the computer to do something about it as root.
> 
> int main() { while(1) { fork(); } }
> 

I find that this forkbomb doesnt always kill the machine. Trying a
small forkbomb, I saw that either the forkbomb process, or the parent
process (of forkbomb) will be killed after a while (by the kernel)
because of "out of memory" error. The problem is that which process
would be chosen to kill? (I have no idea on how kernel choose the
would-be-kill process).

If the kernel choose to kill the parent process, or the forkbomb
itself, damage can be afford. Otherwise, if the more important
processes are killed (like kernel threads or other daemons), things
would be much more serious.

Any idea?

Thank you,
aq
