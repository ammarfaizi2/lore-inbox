Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030435AbWD1P0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbWD1P0b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 11:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbWD1P0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 11:26:31 -0400
Received: from wproxy.gmail.com ([64.233.184.224]:60371 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030433AbWD1P0a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 11:26:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ga536IOopMIf6i2u3LlwFgTvXRYGtAeWM6WoqIj2TH0C3NMj8eTTQT6FoYnhzbQ0UJWM8SBzxhgD/qB+e9mizqPGFlOggrAExLyVmYZtqsD5tIw8v3JQhgfRJfZJy2o3WC3BYn/qs7m+O5XTpC5pnELHNE4YjlsObUD98XhaK4k=
Message-ID: <a36005b50604280826p2b2f8eabm72875eb825a4434@mail.gmail.com>
Date: Fri, 28 Apr 2006 08:26:29 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: Nix <nix@esperi.org.uk>
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-time authentication of binaries
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Makan Pourzandi" <Makan.Pourzandi@ericsson.com>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       "Serue Hallyen" <serue@us.ibm.com>,
       "Axelle Apvrille" <axelle_apvrille@rc1.vip.ukl.yahoo.com>,
       "disec-devel@lists.sourceforge.net" 
	<disec-devel@lists.sourceforge.net>
In-Reply-To: <87psj6pvqo.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4448AC62.6090303@ericsson.com>
	 <1145794712.3131.10.camel@laptopd505.fenrus.org>
	 <a36005b50604230938k2f52186ek477850b3e3a7192@mail.gmail.com>
	 <87psj6pvqo.fsf@hades.wkstn.nix>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/06, Nix <nix@esperi.org.uk> wrote:
> > But preventing every type of code loading or generation at userlevel
> > cannot be prevented this way.
>
> Oh, indeed not. It's just a stopgap that blocks some (large) percentage
> of script kiddy attacks that involve downloading binaries and then
> executing them, or even compiling them on the spot (not that those are
> as common these days).

Script kiddies don't write the exploit code themselves.  And for those
who write the code it is no problem to circumvent the signature
testing.


> Yeah. I'll admit I've found signed binaries principally useful on
> stripped-down firewalls and firewall UML instances. These boxes don't
> tend to run, say, CLISP or SBCL or OpenOffice (at least if they do the
> firewall maintainer needs shooting).

But they have Perl, Python, etc.  Those are sufficient.  Heck, I can
cause havor with bash.


> Combine it with SELinux, exec-shield, FORTIFY_SOURCE, -fstack-protector
> and, say, a COWed filesystem read off a CD and reset with every boot,
> and you start to get a bit less insecure than you would otherwise be.

Take signed binaries off of this list and you don't lose anything.


> It's another hurdle for the bad guys to leap, and many will fall at the
> wayside.

It is a little one-time effort.  This approach differs in that it
simply shifts the way binaries are introduced.  I can write a dynamic
loader in Perl.  and after that I don't load ELF binaries through the
kernel ever again.  If such a loader doesn't exist today it could very
well exist in a few months and after that this "protection" is
completely useless.  Every script kiddy will have it.

This is the big difference to techniques like randomization which
might be circumventent with a certain probability but never fully can
be removed.  Stacking those kind of protections is a good idea
because, if they are not fully correlated, the stacking provides
additional protection.  Signed binaries do not.
