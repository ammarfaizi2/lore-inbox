Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422726AbWA1AWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422726AbWA1AWo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 19:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422730AbWA1AWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 19:22:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19987 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422728AbWA1AWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 19:22:42 -0500
Date: Sat, 28 Jan 2006 01:22:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, keyrings@linux-nfs.org
Subject: Re: [PATCH 01/04] Add multi-precision-integer maths library
Message-ID: <20060128002241.GD3777@stusta.de>
References: <20060127092817.GB24362@infradead.org> <1138312694656@2gen.com> <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com> <20060127204158.GA4754@hardeman.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060127204158.GA4754@hardeman.nu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 09:41:58PM +0100, David Härdeman wrote:
> On Fri, Jan 27, 2006 at 08:07:50PM +0000, David Howells wrote:
>...
> >Well... I'd like to revisit module signing at some point, though I imagine
> >it'll cause the LKML to melt again by those who think that I shouldn't have
> >the right to sign my modules because they imagine it impinges on their
> >rights:-) But I suspect the reason David wants this is so that he can 
> >encrypt
> >something with keys that he's not actually permitted to retrieve
> >directly. David?
> 
> The reason that I wanted DSA-keys supported by the in-kernel key stuff 
> is that it allows for some cool stuff which is either impossible or very 
> hard to do otherwise.
> 
> For example, a backup daemon which wishes to store the backup on another 
> host using ssh. Usually this is solved by storing an unencrypted key in 
> the fs or by providing a connection to a ssh-agent which has been 
> preloaded with the proper key(s). Both are quite inelegant solutions. 
> With the in-kernel support, the daemon can request the key using the 
> request_key call, and (provided proper scripts are written), the user 
> who controls the relevant key can supply it. This in turn means that the 
> backup daemon can sign using the key and read its public parts but not 
> the private key.

What exactly is the unsolvable problem with doing this in userspace?

> So yes, that is one example of doing "something" with keys that the 
> process is not allowed to retrieve directly (the key itself could be 
> supplied from removable storage or something and given a few minutes of 
> time-to-live).
> 
> It also means that users would not have to run ssh-agent and would not 
> have to bother with making sure that only one instance of ssh-agent is 
> running even if they are logged in multiple times.
> 
> The in-kernel key management also protects the key against many of the 
> different ways in which a user-space daemon could be attacked (ptrace, 
> swap-out, coredump, etc).

If an attacker has enough privileges for attacking the daemon, he should 
usually also have enough privileges for attacking the kernel.

The number of different attacks might be lower, but you haven't 
completely solved any problem.

> In addition, the dsa key code can be used to implement signed binaries 
> and signed modules.
>...

Checking signatures on modules sounds like a job for module-init-tools
(if there's any real benefit in signing GPL'ed modules).

> Regards,
> David

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

