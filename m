Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWA2V37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWA2V37 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 16:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWA2V37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 16:29:59 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:38623 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1750738AbWA2V36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 16:29:58 -0500
Date: Sun, 29 Jan 2006 22:29:15 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Dax Kelson <dax@gurulabs.com>, Christoph Hellwig <hch@infradead.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths	library
Message-ID: <20060129212915.GB20118@hardeman.nu>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Dax Kelson <dax@gurulabs.com>,
	Christoph Hellwig <hch@infradead.org>, keyrings@linux-nfs.org,
	linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
References: <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de> <20060128104611.GA4348@hardeman.nu> <1138466271.8770.77.camel@lade.trondhjem.org> <20060128165732.GA8633@hardeman.nu> <1138504829.8770.125.camel@lade.trondhjem.org> <20060129113320.GA21386@hardeman.nu> <1138552702.8711.12.camel@lade.trondhjem.org> <406-SnapperMsg827D11E1C002BEC0@[70.7.65.98]> <1138561846.8711.33.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1138561846.8711.33.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.11
X-SA-Score: -2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 02:10:46PM -0500, Trond Myklebust wrote:
>On Sun, 2006-01-29 at 11:49 -0700, Dax Kelson wrote:
>>>Has anyone tried to look for simpler signing mechanisms that make use of
>>>the crypto algorithms that are already in the kernel?
>> 
>> Maybe you meant something else, but history has shown that 'rolling your own' mechanism is a bad idea.
>> 
>> Are there even any suitable algorithms in the kernel??
>
>I'm suggesting that if the only real problem that dsa in the kernel
>solves is module signing, then perhaps one can simplify the problem.
>
>For instance, if instead of going for a general signing mechanism in the
>kernel that will take any old module and verify it, you define a
>particular binary as being trusted, and then devise a signature that the
>kernel can check (even the SHA-1 of the binary image might be
>sufficient).
>The object would be to give the kernel a trusted program that can check
>module signatures on its behalf.

Today, if a security bug is found in the kernel, you have to compile and 
install a new kernel.

With your system, the signature of a "trusted" binary is embedded in the 
kernel. Now, if a bug is found in said binary, you also get to compile 
and install a new kernel along with a new binary.

Since the application is trusted, a security hole in the binary equals a 
security hole in the kernel. In addition, you are bound to a given 
kernel <-> userspace ABI, so if it has to be changed, you get to keep 
several different trusted binaries around for different kernel versions 
(/sbin/module-validate-v1 for ABI version 1, /sbin/module-validate-v2 
for ABI version 2, etc).

Further, how is the module actually verified? If the trusted binary 
reads it and checks "something" (i.e. a signature), and then says it's 
ok, what is to say that the module is not changed on-disk between the 
time when the binary reads it and when the kernel does so (for instance 
by direct access to the disk). How do you expect the system to provide 
security if you are running with nfs-root?

In addition you must protect the user-space binary against a slew of 
attacks (you did statically link it to protect against LD_PRELOAD, right?).

What exactly is the advantage of user-space trusted binary signing?

Regards,
David

