Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbTJBS2D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 14:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263444AbTJBS2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 14:28:03 -0400
Received: from imr2.ericy.com ([198.24.6.3]:21163 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id S263426AbTJBS17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 14:27:59 -0400
Message-ID: <3F7C701A.5080505@ericsson.ca>
Date: Thu, 02 Oct 2003 14:36:10 -0400
From: Makan Pourzandi <Makan.Pourzandi@ericsson.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Radu Filip <socrate@infoiasi.ro>, viro@parcelfarce.linux.theplanet.co.uk,
       "Makan Pourzandi (QB/EMC)" <makan.pourzandi@ericsson.com>,
       Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       "Axelle Apvrille (QB/EMC)" <axelle.apvrille@ericsson.com>,
       "Vincent Roy (QB/EMC)" <Vincent.Roy@ericsson.com>,
       David Gordon <davidgordonca@yahoo.ca>
Subject: Re: [ANNOUNCE] DigSig 0.2: kernel module for digital signature ve
 rification for binaries
References: <200310020242.h922ggqd007637@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

> On Thu, 02 Oct 2003 00:55:41 +0300, Radu Filip said:
>
>
> Yes, it probably does a *very* good job of making sure that the binary
> loaded by an exec() call hasn't been tampered with.  On the other hand,
> it does *NOTHING* to tamper-proof shared libraries - 
>
I agree, one major improvement would be to extend our work to the shared 
libraries. Quite frankly, I haven't had enough free time to find out how 
to handle this one.  Our first investigations showed that there would be 
no appropraite LSM hook that could handle this. I want to put the 
emphasis on the fact that I didn't spend much time there, so we'll see 
after i spend some days bugging around the code.
 

> You're spending a lot of effort solving the problem of making sure that
> you can't exec an untrusted binary, when the problem you (presumably)
> actually want to solve is making sure that you can't run untrusted code.
>
> Note that Microsoft's literature on their Trusted Computing initiative
> seems to indicate that they made this same mistake - they fail to account
> for the fact that if you install a Palladium-aware IIS (or whatever), and
> then manage to buffer-overflow it, that code will then execute in 
> whatever
> context the IIS program has.  As such, it's more about DRM than
> about actual security.
>
Can you elaborate more in this? I don't agree that what we do has 
something to do with DMR.

I believe there is some misunderstanding, we do not assume that the 
authentication of the binary 
is done by using public keys from big industry names or any, we believe 
that this authentication must be done
using admin's public key (or user's) on the system. and this is how we 
implemented digsig. 
our approach lets free hands to the
admin (or user) to organize the system as he believes to. In our 
approach, the
code is signed by the __admin's__ private key. Then the binary is 
verified by the public key introduced by the __admin__. This means
that you could always sign __all__ binaries you wanr on your system with 
your own keys and have absolutely no problem running them. The only 
thing Digsig garantees you is that if __you__ signed a binary, nobody 
else than you (or people that you allowed) can change that binary and 
run it in your system. But nobody can forbid __you__ from running the 
binary. I see that we give more power to the admin (or user) over how 
s/he wants his system to run rather than enforcing any DMR alike 
approach. digsig approach is based on __locally__ signing all binaries, 
we don't support any kind of signature verificatin from binaries coming 
from outside (our documentation is not yet there but see bsign's 
docuementation for more details)

To simplify things, our approach is much closer to Tripwire than any 
kind of DMR alike that I heard of; AFAIK, Tripwire allows you to sign 
your files and check their integrity upon the time. to over simplify, 
this is somehow what we do but for binaries only and at run-time.
btw, even to simplify more, isn't that similar to what we do when we 
accept to verify the md5 or signature of a rpm which we download from 
red hat?

regards,
makan
 
-------------------------------------------------------
Makan Pourzandi,
Ericsson Research Canada
*This email does not represent or express the opinions of
Ericsson Inc.
-------------------------------------------------------


