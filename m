Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbWA1Q6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbWA1Q6I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 11:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWA1Q6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 11:58:07 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:47765 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S932411AbWA1Q6G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 11:58:06 -0500
Date: Sat, 28 Jan 2006 17:57:32 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Adrian Bunk <bunk@stusta.de>, Christoph Hellwig <hch@infradead.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths library
Message-ID: <20060128165732.GA8633@hardeman.nu>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Adrian Bunk <bunk@stusta.de>, Christoph Hellwig <hch@infradead.org>,
	keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
References: <20060127092817.GB24362@infradead.org> <1138312694656@2gen.com> <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com> <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de> <20060128104611.GA4348@hardeman.nu> <1138466271.8770.77.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
In-Reply-To: <1138466271.8770.77.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.11
Content-Transfer-Encoding: 8BIT
X-SA-Score: -2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 11:37:51AM -0500, Trond Myklebust wrote:
>On Sat, 2006-01-28 at 11:46 +0100, David Härdeman wrote:
>> Not necessarily, if you have your ssh-keys in ssh-agent, a compromise of 
>> your account (forgot to lock the screen while going to the bathroom? 
>> did the OOM-condition occur which killed the program which locks the
>> screen? remote compromise of the system? local compromise?) means that a large 
>> array of attacks are possible against the daemon.
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
>Then fix ssh, not the kernel. As I said before, this is a problem that
>has been solved entirely in userspace by means of proxy certificates:
>they allow the user to issue time-limited certificates that are signed
>by the original certificate (hence can be authenticated as such), and
>that authorise a service to do a specific thing.

What about the first paragraph of what I wrote? You are going to want to 
keep often-used keys around somehow, proxy certificates is not a 
solution for your own use of your personal keys and with the exception 
of hardware solutions such as smart cards, the keys will be safer in the 
kernel than in a user-space daemon...

Further, the mpi and dsa code can also be used for supporting signed 
modules and binaries...the "store dsa-keys in kernel" part adds 376 
lines of code (counted with wc so comments and includes etc are also 
counted)...

Regards,
David
