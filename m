Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751729AbWG0Qld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbWG0Qld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 12:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbWG0Qld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 12:41:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:35942 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751564AbWG0Qlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 12:41:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A5EDvTaGeBzULUrU8lnQYby+K6S1aQsoypbO7cZkoHrtF6Pxb529qt3rFe3NAz7OGKRrMsA8qkeMoI7izdaPj2+sTVfrDYWzHbwSpYxUI7rZ6vYfAtF40vLnErgibw4nCHlP/cm5mQwqLTJm0w6QiFAIKkjxW1K8YSgXYVyFUm0=
Message-ID: <a36005b50607270941n187e8b06ga9b1b6454cf2e548@mail.gmail.com>
Date: Thu, 27 Jul 2006 09:41:30 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Pekka J Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@zeniv.linux.org.uk, alan@lxorguk.ukuu.org.uk, tytso@mit.edu,
       tigran@veritas.com
In-Reply-To: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, Pekka J Enberg <penberg@cs.helsinki.fi> wrote:
> +asmlinkage int sys_revoke(const char __user *filename)

Could we just plainly avoid adding any new syscalls which take a
filename without extending the interface like the *at functions?
I.e., add a file descriptor parameter, handle AT_FDCWD, etc.  The
additional effort is really minimal.  Even if, as in this case, the
function is propably not used in situations where the filename use is
racy there are still those people to consider who want to implement a
virtual per-thread current working directory.
