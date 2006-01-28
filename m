Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWA1RKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWA1RKT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 12:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWA1RKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 12:10:19 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:14030 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S964804AbWA1RKR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 12:10:17 -0500
Date: Sat, 28 Jan 2006 18:09:04 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, keyrings@linux-nfs.org
Subject: Re: [PATCH 01/04] Add multi-precision-integer maths library
Message-ID: <20060128170904.GB8633@hardeman.nu>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	David Howells <dhowells@redhat.com>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	keyrings@linux-nfs.org
References: <20060127092817.GB24362@infradead.org> <1138312694656@2gen.com> <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com> <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de> <20060128104611.GA4348@hardeman.nu> <20060128130316.GH3777@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
In-Reply-To: <20060128130316.GH3777@stusta.de>
User-Agent: Mutt/1.5.11
Content-Transfer-Encoding: 8BIT
X-SA-Score: -2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 02:03:16PM +0100, Adrian Bunk wrote:
>On Sat, Jan 28, 2006 at 11:46:11AM +0100, David Härdeman wrote:
>> On Sat, Jan 28, 2006 at 01:22:41AM +0100, Adrian Bunk wrote:
>>...
>> >If an attacker has enough privileges for attacking the daemon, he should 
>> >usually also have enough privileges for attacking the kernel.
>> 
>> Not necessarily, if you have your ssh-keys in ssh-agent, a compromise of 
>> your account (forgot to lock the screen while going to the bathroom? 
>> did the OOM-condition occur which killed the program which locks the
>> screen? remote compromise of the system? local compromise?) means that a 
>> large array of attacks are possible against the daemon.
>> 
>> In addition, as stated before, the "backup" account, or whatever user the 
>> daemon which wants to sign stuff with your key is running as, might be 
>> compromised.
>> 
>> Currently, if you want to give the daemon access to the keys via 
>> ssh-agent (or something similar), you have to change the permissions on 
>> the ssh-agent socket to be much less restricted (especially since it's 
>> unlikely that you have permission to change the uid or gid of the socket 
>> to that of the daemon). Alternatively you can provide the backup daemon 
>> with the key directly (via fs, or loaded somehow at startup...etc), but 
>> then a compromise of the daemon means that the attacker has the private 
>> key.
>> 
>> Finally, the in-kernel system also provides a mechanism for the daemon 
>> to request the key when it is needed should it realize that the proper 
>> key is missing/has changed/whatever.
>
>
>I'm sorry, but I'm still not getting the point:
>
>Which part of this task is technically impossible to implement through a 
>userspace daemon?

See my latest reply to Trond...putting the keys in the kernel makes them 
as secure as they can be without having specialized hardware (e.g. 
smartcards).

>> >The number of different attacks might be lower, but you haven't 
>> >completely solved any problem.
>> 
>> Many of the problems are unsolveable without having specialized hardware 
>> (i.e. a smartcard). The fact that the dsa patch is not a panacea does 
>> not mean that it can't, or that we shouldn't strive to, improve upon the 
>> current situation
>
>I'm still not understanding the big improvements when doing it in the 
>kernel instead of doing it in a userspace daemon.

You said it yourself above...the number of different attacks is lower

>> >>In addition, the dsa key code can be used to implement signed binaries 
>> >>and signed modules.
>> >>...
>> >
>> >Checking signatures on modules sounds like a job for module-init-tools
>> >(if there's any real benefit in signing GPL'ed modules).
>> 
>> No, not really, take a look at http://lwn.net/Articles/92617/ for 
>> details of how signed modules could work (public key is merged into 
>> kernel at build time, private key is used to build modules with embedded 
>> signature, kernel checks module sigs at load-time using the embedded public 
>> key, so checks can't be in module-init-tools).
>
>
>The only point in this lwn article that is not solvable outside of the 
>kernel is if distributions want to prevent loading of modules they 
>haven't authorized.

Ehh...how do you provide the features of signed modules in user-space?

>The lwn article outlines how distributions can use this for demanding 
>money from module vendors. Distributions can do this if they want to, 
>but this is nothing we should add a single byte of code for.

There are already distributions with the patch in their kernel (Fedora), 
so why would they care if signed modules patches are added to the 
vanilla kernel or not?

On the other hand, it does add functionality which is useful to some 
users even if it is not useful to all.

Regards,
David

