Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWA2Stj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWA2Stj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 13:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWA2Stj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 13:49:39 -0500
Received: from mail.gurulabs.com ([67.137.148.7]:64925 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S1751107AbWA2Sti convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 13:49:38 -0500
Mime-Version: 1.0
X-Mailer: SnapperMail 2.3.2.01  by Snapperfish
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>,
       =?ISO-8859-1?Q?_=22David_H=E4rdeman=22?= <david@2gen.com>
Cc: "Christoph Hellwig" <hch@infradead.org>, <keyrings@linux-nfs.org>,
       <linux-kernel@vger.kernel.org>, "Adrian Bunk" <bunk@stusta.de>
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer 
 maths	library
Message-ID: <406-SnapperMsg827D11E1C002BEC0@[70.7.65.98]>
In-Reply-To: <1138552702.8711.12.camel@lade.trondhjem.org>
References: <20060127092817.GB24362@infradead.org> 
 <1138312694656@2gen.com>
	<1138312695665@2gen.com> 
 <6403.1138392470@warthog.cambridge.redhat.com>
	<20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de>
	<20060128104611.GA4348@hardeman.nu>
	<1138466271.8770.77.camel@lade.trondhjem.org>
	<20060128165732.GA8633@hardeman.nu>
	<1138504829.8770.125.camel@lade.trondhjem.org>
	<20060129113320.GA21386@hardeman.nu> <1138552702.8711.12.camel@lade.trondhjem.org>
From: Dax Kelson <dax@gurulabs.com>
Date: Sun, 29 Jan 2006 11:49:24 -0700
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 ..... Original Message .......
On Sun, 29 Jan 2006 11:38:22 -0500 "Trond Myklebust" <trond.myklebust@fys.uio.no> wrote:
>On Sun, 2006-01-29 at 12:33 +0100, David Härdeman wrote:
>
>> >Why would you want to use proxy certificates for you own use? Use your
>> >own certificate for your own processes, and issue one or more proxy
>> >certificates to any daemon that you want to authorise to do some limited
>> >task.
>> 
>> I meant that you can't use proxy certs for your own use, so you still need 
>> to store your own cert/key somehow...and I still believe that the kernel 
>> keyring is the best place...
>
>Agreed. Now, reread what I said above, and tell me why this is an
>argument for doing dsa in the kernel?
>
>> >...and what does this statement about "keys being safer in the kernel"
>> >mean?
>> 
>> swap-out to disk, ptrace, coredump all become non-issues. And in 
>> combination with some other security features (such as disallowing 
>> modules, read/write of /dev/mem + /dev/kmem, limited permissions via
>> SELinux, etc), it becomes pretty hard for the attacker to get your 
>> private key even if he/she manages to get access to the root account.
>
>Turning off coredump is trivial. All the features that LSM provide apply
>to userland too (including security_ptrace()), so the SELinux policies
>are not an argument for putting stuff in the kernel.
>
>Only the swap-out to disk is an issue, and that is less of a worry if
>you use a time-limited proxy in the daemon.

I seem to remember a feature in the kernel that allows each uid to mlock a small number of memory pages specifically intended to be used by daemons that cache keys. It is possible this was a Fedora kernel patch and not in the mainline kernel.

>> >> Further, the mpi and dsa code can also be used for supporting signed 
>> >> modules and binaries...the "store dsa-keys in kernel" part adds 376 
>> >> lines of code (counted with wc so comments and includes etc are also 
>> >> counted)...
>> >
>> >Signed modules sounds like a better motivation, but is a full dsa
>> >implementation in the kernel really necessary to achieve this?
>> 
>> How would you do it otherwise?
>
>Has anyone tried to look for simpler signing mechanisms that make use of
>the crypto algorithms that are already in the kernel?

Maybe you meant something else, but history has shown that 'rolling your own' mechanism is a bad idea.

Are there even any suitable algorithms in the kernel??

___
Dax Kelson
Sent with my Treo
