Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751726AbWG0PdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbWG0PdR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 11:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbWG0PdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 11:33:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:26268 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751723AbWG0PdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 11:33:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=VapDLBWicIP+3BayPtPoFq6aAishrdG7X+YKYa7MuTxv2lFA3Ezxpfbo4iLx6sgDnOjlf7aG09YvCBJdHMYHGDxtnzJ+Bjrj0OhrcvkvXnQIr7VaxGy/qtrQSf6SCxtYskRnsJURnduD8/VwiyQOT8aTDYgyTC6PfpOJOqymH+c=
Message-ID: <84144f020607270833v4c981d00w8e3e643406aea7a@mail.gmail.com>
Date: Thu, 27 Jul 2006 18:33:14 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Re: [RFC/PATCH] revoke/frevoke system calls V2
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@zeniv.linux.org.uk, tytso@mit.edu, tigran@veritas.com
In-Reply-To: <1154012822.13509.52.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <1154012822.13509.52.camel@localhost.localdomain>
X-Google-Sender-Auth: cf80c0454a286539
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> That should be three I think. frevoke and revoke should not return until
> all the existing outstanding is dead. For devices that means we need to
> wake up the device where possible and really suggests we need a device
> ->revoke method. TTY devices need this to allow us to re-implement
> vhangup in terms of revoke. Other devices devices are not all
> sufficiently secure without this check. Some may also want to use this
> hook to ensure that any security context is dead (eg cached crypto
> keys).

Don't device drivers already do that for f_ops->flush (filp_close) and
vm_ops->close (munmap)? What revoke and frevoke do is basically
unmap/fsync/close on all the open file descriptors.

                                    Pekka
