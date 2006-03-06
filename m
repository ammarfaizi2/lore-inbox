Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWCFH4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWCFH4Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 02:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbWCFH4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 02:56:24 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:25710 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751305AbWCFH4X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 02:56:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gx3ctHVJEJwklCEZBMZPFtNmOeKHEHlXJ0+NK44s+OYf+YWCoBOs28JA4x4TiFXHs+41tSkACJAPkRM62LUeAdJmrRVdJ+sYQ8AnVABHqs+/Omh4OPNso43AYahJOYZFpYvnRg34K/Xv7LLoVJTa+FddTzDBPnUYKaTsiU6PR2k=
Message-ID: <84144f020603052356r321bc78dp66263fbfc73517c6@mail.gmail.com>
Date: Mon, 6 Mar 2006 09:56:22 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Dave Jones" <davej@redhat.com>, "Al Viro" <viro@ftp.linux.org.uk>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       ericvh@gmail.com, rminnich@lanl.gov
Subject: Re: 9pfs double kfree
In-Reply-To: <20060306072823.GF21445@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060306070456.GA16478@redhat.com>
	 <20060305.230711.06026976.davem@davemloft.net>
	 <20060306072346.GF27946@ftp.linux.org.uk>
	 <20060306072823.GF21445@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Dave Jones <davej@redhat.com> wrote:
> I wonder if we could get away with something as simple as..
>
> #define kfree(foo) \
>         __kfree(foo); \
>         foo = KFREE_POISON;
>
> ?

It's legal to call kfree() twice for NULL pointer. The above poisons
foo unconditionally which makes that case break I think.

                                Pekka
