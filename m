Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWA2WyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWA2WyO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 17:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWA2WyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 17:54:14 -0500
Received: from smtpout.mac.com ([17.250.248.44]:34004 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751202AbWA2WyN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 17:54:13 -0500
In-Reply-To: <1138572311.8711.84.camel@lade.trondhjem.org>
References: <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de> <20060128104611.GA4348@hardeman.nu> <1138466271.8770.77.camel@lade.trondhjem.org> <20060128165732.GA8633@hardeman.nu> <1138504829.8770.125.camel@lade.trondhjem.org> <20060129113320.GA21386@hardeman.nu> <1138552702.8711.12.camel@lade.trondhjem.org> <20060129211310.GA20118@hardeman.nu> <1138570100.8711.63.camel@lade.trondhjem.org> <20060129220217.GA21832@hardeman.nu> <1138572311.8711.84.camel@lade.trondhjem.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <1BE90924-C4BF-4123-AF20-88655772C8BF@mac.com>
Cc: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths library
Date: Sun, 29 Jan 2006 17:54:00 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 29, 2006, at 17:05, Trond Myklebust wrote:
> On Sun, 2006-01-29 at 23:02 +0100, David Härdeman wrote:
>> On Sun, Jan 29, 2006 at 04:28:20PM -0500, Trond Myklebust wrote:
>>> On Sun, 2006-01-29 at 22:13 +0100, David Härdeman wrote:
>>>> How do you use a "time-limited proxy in the daemon" for your own  
>>>> keys/cerificates (e.g. ssh keys)?
>>>
>>> I don't have to. Why are you apparently insisting on this weird  
>>> fallacy that a keyring can only hold one certificate at a time?
>>
>> I'm talking about ssh keys, not kerberos tickets.
>
> As I said previously, the lack of support for proxies would appear  
> to be a bug in ssh, not the kernel.

You keep mentioning proxy certificates.  So you are saying that when  
I pass the key to some daemon to which I do not want it to have  
permanent access, I should create a proxy certificate to pass  
instead?  This _vastly_ increases the amount of math that needs to be  
done.  Instead of just using my private key to encrypt data, I would  
need to generate a new private key with the required encryption  
strength, generate a proxy certificate, sign the proxy certificate  
with the old private key, keep track of revocation lists somehow (how  
do I reliably expire a proxy certificate on-demand everywhere it  
might be without a web-server hosting the CRLs?), _then_ I can  
finally encrypt my data with the proxy certificate.  I think this  
qualifies as a serious performance problem, especially if I'm opening  
and closing lots of SSH tunnels, like running remote commands on  
every system in a cluster.

If we use this proposed in-kernel system, then I can give my  
certificate/pubkey to the kernel code, and then my web browser, SSH,  
and anything else can automatically use it to decrypt and sign data  
without being able to directly access (and thus compromise) the key.   
If I later notice what I think might be a rogue process, I can  
instantly and globally revoke all access to that keypair.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/E/U d- s++: a18 C++++>$ ULBX*++++(+++)>$ P++++(+++)>$ L++++ 
(+++)>$ !E- W+++(++) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP 
+ t+(+++) 5 X R? !tv-(--) b++++(++) DI+(++) D+++ G e>++++$ h*(+)>++$ r 
%(--)  !y?-(--)
------END GEEK CODE BLOCK------



