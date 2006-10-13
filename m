Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751728AbWJMQXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbWJMQXj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbWJMQXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:23:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:7202 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751677AbWJMQXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:23:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=tH0ljR+CPZs0bShySHWqPEuzUgY59+kArDMlHSO9gnlqvqgj71BTjnTFJG8h6zEJsEvNyrg7jwYZdpKwaWVyBtb8ltiMMhjPoZ8q/b4O7WOPYoF1zGwJhEC+gcyytBjUkUlt2vrksH8jvxBxNspS8TxVAMaSNRKYlwgJ4fCmNMs=
Message-ID: <84144f020610130923q28d816ddl388484421e23ba91@mail.gmail.com>
Date: Fri, 13 Oct 2006 19:23:36 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Erez Zadok" <ezk@cs.sunysb.edu>
Subject: Re: Re: [RFC/PATCH 1/2] stackfs: generic functions for obtaining hidden object
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       jsipek@cs.sunysb.edu, mhalcrow@us.ibm.com, phillip@hellewell.homeip.net
In-Reply-To: <200610131543.k9DFh05m016578@agora.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0610131615370.563@sbz-30.cs.Helsinki.FI>
	 <200610131543.k9DFh05m016578@agora.fsl.cs.sunysb.edu>
X-Google-Sender-Auth: 323640c264d1b135
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/06, Erez Zadok <ezk@cs.sunysb.edu> wrote:
> I think we should do it right the first time (i.e., now :-)

I would much rather merge it now (assuming I didn't break ecryptfs)
and have you unionfs developers fix it later :-).

On 10/13/06, Erez Zadok <ezk@cs.sunysb.edu> wrote:
> Why not make it something more dynamic, such as a mount-time option per sb?
> Even at 8, you waste most of that space for non-fan-out stackable file
> systems such as ecryptfs; and those unionfs users who want more, will have
> to _recompile_ the code.

Yes, we discussed this with Jeff already. For unionfs, we must make it
more dynamic. However, using slab unconditionally makes it totally
unacceptable for ecryptfs. Therefore, we need a small static array
that should satisfy most user (I think we can drop the static array
size to three):

struct stackfs_inode_info {
    struct inode **hidden_inodes;
    struct inode *static_inodes[3];
};

Initially, hidden_inodes can point to static_inodes which we can the
replace with a dynamic array if required. Btw, we probably want to do
krealloc() for that in the slab allocator.

                           Pekka
