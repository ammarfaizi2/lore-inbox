Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWA1Kjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWA1Kjx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 05:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWA1Kjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 05:39:53 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38662 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932259AbWA1Kjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 05:39:52 -0500
Date: Sat, 28 Jan 2006 11:39:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>,
       David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, keyrings@linux-nfs.org,
       LKML Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths library
Message-ID: <20060128103951.GF3777@stusta.de>
References: <20060127092817.GB24362@infradead.org> <1138312694656@2gen.com> <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com> <20060127204158.GA4754@hardeman.nu> <1138400385.8770.21.camel@lade.trondhjem.org> <8155F461-1703-476B-8C5D-B834EE49905D@mac.com> <1138419925.8770.70.camel@lade.trondhjem.org> <DEA6D91F-9925-47E3-8A93-3D0C7D7F8CDA@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEA6D91F-9925-47E3-8A93-3D0C7D7F8CDA@mac.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 02:17:49AM -0500, Kyle Moffett wrote:
> On Jan 27, 2006, at 19:22, Adrian Bunk wrote:
> >On Fri, Jan 27, 2006 at 09:41:58PM +0100, David H�rdeman wrote:
> >>The in-kernel key management also protects the key against many of  
> >>the different ways in which a user-space daemon could be attacked  
> >>(ptrace, swap-out, coredump, etc).
> >
> >If an attacker has enough privileges for attacking the daemon, he  
> >should usually also have enough privileges for attacking the kernel.
> 
> Not necessarily.  If the daemon runs as the "backup" user or similar,  
> access to it does not imply root.  We want to make an efficient way  
> to allow the _use_ of keys without implying access to the key data.   
> For example, one item under consideration is a "key handle" that  
> could be cloned, however if you revoke a given handle, all of its  
> cloned handles (and their clones), will be automatically revoked as  
> well.  This would make it possible to pass a key to a program without  
> risking the key to compromise of that program.  Say I pass my SSL key  
> to Mozilla.  With this and some of the other new security features  
> (One of the code-isolation ones I think?), you could allow Mozilla to  
> use SSL websites without risking compromise of the SSL keys because  
> of a browser security hole.


I still haven't gotten the point which part of this is technically 
impossible to implement in userspace.


> On Jan 27, 2006, at 22:45, Trond Myklebust wrote:
> >On Fri, 2006-01-27 at 18:35 -0500, Kyle Moffett wrote:
> >
> >>No, the point is not to put the backup daemon into the kernel, but  
> >>to provide a way for the backup daemon and my user process to  
> >>communicate DSA key details without completely giving the backup  
> >>daemon my key.  I may not entirely trust the backup daemon not to  
> >>get compromised, but with support for the kernel keyring system,  
> >>compromising the backup daemon would only compromise the backed up  
> >>files, not the private keys and other secure data.
> >
> >This sort of thing is implemented routinely in user space by means  
> >of proxy  tickets/certificates/credentials. What makes them  
> >insufficient for this use?
> 
> The problem is that there is no standard way to store/use the keys.   
> I can put my key in an ssh-agent to handle SSH, but that doesn't let  
> me securely auth mozilla.  To do that, I need to explore how mozilla  
> configs work.  And there are similar problems with context for  
> Kerberos, OpenAFS, encrypted filesystems, etc.  You need to have a  
> common standardized way to pass the secure information around.  This  
> provides that interface.


"There's currently no standard" doesn't sound like a compelling reason 
why a standard should be implemented in the kernel instead of userspace.


> Cheers,
> Kyle Moffett

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

