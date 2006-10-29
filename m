Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbWJ2Nf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbWJ2Nf3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 08:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965215AbWJ2Nf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 08:35:29 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:60515 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965213AbWJ2Nf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 08:35:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=BoS7J6XK1bTb5XkB6bx3RwKfsXyKoRdAetD7C3xU9kNt1O5eK5bfIjQT7HsSPMzFDkwErZyfkfZGl5yIDp3aVZHV1aZfPiAqUW9uoUssDvAnGzjZM1yl7iCgEvRrNIa3z4Gf3BxcmHX+uz56GKva5YX4gATw1gAzEA252g0BIVw=
Date: Sun, 29 Oct 2006 22:35:51 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org, Andy Adamson <andros@citi.umich.edu>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: Re: [PATCH] auth_gss: unregister gss_domain when unloading module
Message-ID: <20061029133551.GA10072@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Andy Adamson <andros@citi.umich.edu>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Trond Myklebust <Trond.Myklebust@netapp.com>
References: <20061028185554.GM9973@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061028185554.GM9973@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2006 at 03:55:54AM +0900, Akinobu Mita wrote:
> This patch unregisters gss_domain and free it when unloading
> modules (rpcsec_gss_krb5 or rpcsec_gss_spkm3 module call
> gss_mech_unregister())

This patch was wrong. Because it didn't manipulate refcount well.
And I found another problem in linux/net/sunrpc/svcauth.c, too.

