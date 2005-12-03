Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbVLCNtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVLCNtk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 08:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVLCNtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 08:49:40 -0500
Received: from [212.76.86.206] ([212.76.86.206]:1796 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750888AbVLCNtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 08:49:39 -0500
From: Al Boldi <a1426z@gawab.com>
To: netdev@vger.kernel.org
Subject: Re: [RFC] ip / ifconfig redesign
Date: Sat, 3 Dec 2005 16:46:45 +0300
User-Agent: KMail/1.5
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200512022253.19029.a1426z@gawab.com>
In-Reply-To: <200512022253.19029.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512031646.45332.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Savola wrote:
> Al Boldi wrote:
> > Consider this new approach for better address management:
> > 1. Allow the definition of an address pool
> > 2. Relate links to addresses
> > 3. Implement to make things backward-compatible.
> >
> > The obvious benefit here, would be the transparent ability for apps to
> > bind to addresses, regardless of the link existence.
> >
> That's called 'the loopback address', right? :)

Jan-Benedict Glaw wrote:
> # echo 1 > /proc/sys/net/ipv4/ip_nonlocal_bind
>
> and/or bind to address 0 (aka 0.0.0.0) instead of a given IP address.

Ben Greear wrote:
> > Another benefit includes the ability to scale the link level
> > transparently, regardless of the application bind state.
>
> Can you do this with the current code by using scripts/whatever to move
> virtual IPs around the interfaces?

Maybe, but wouldn't that be a workaround?

linux-os \(Dick Johnson\) wrote:
> It really doesn't have anything to do with the kernel.

Maybe I shouldn't have cc'd kernel.

Marc Singer wrote:
> It might make sense to allow the address to exist without a link in
> order to allow a local port listener to continue to accept connections
> even though the network moved to another link, e.g. wireless to
> wired.  Then again, perhaps, this shouldn't matter.
>
> What does Mr. Boldi propose?

Jesper Juhl wrote:
> I'm only guessing since I'm not entirely sure what Mr. Boldi means,
> but my guess is that he's proposing that an app can bind to an IP
> address without that address being assigned to any currently available
> interface and then later if that IP does get assigned to an interface
> the app will start recieving traffic then. Also possibly allowing the
> address to be removed from one interface and then later assigned to
> another one without apps noticing.
> I don't know /if/ that is what was meant, but that's how I read it.

Yes! And much more...

One reason why linux is great is because it's flexible.  But flexibility 
sometimes leads you to fulfill requirements in a workaround fashion.  Things 
get worse when you start building on these workarounds.

GNU/OpenSource is prone to such a development.

What I propose is to stop and think always; identify the problem and provide 
for a _scalable_ solution.  Procrastinating using workarounds may make your 
development cycle seem faster, when in fact you are inhibiting it.

Here specifically, ip/ifconfig is implemented upside-down requiring a 
link/dev to exist for an address to be defined, in effect containing layer 3 
inside layer 2, when an address should be allowed to be defined w/o a 
link/dev much like an app is allowed to be defined w/o an address.

Thanks for all your comments!

--
Al

