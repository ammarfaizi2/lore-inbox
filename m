Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWEMBBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWEMBBW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 21:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWEMBBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 21:01:22 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:42557 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750754AbWEMBBW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 21:01:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rMjsxyWIXRKlqtPzSdz7FV+3O1rsbb/140AtRUDf9iNvVoh7JTNv3Ikh+f269WoMLRqU2HodApGNn+P2Igig/qplwzNej5PzygQEFE4mjvStLd27Hh2//ozyJsSxM4/v+JZAQnE08zFppdf8NMohSugIR1SA+pg7BpZgbf/Gl8A=
Message-ID: <bda6d13a0605121801s919485el4ba07fdd06394537@mail.gmail.com>
Date: Fri, 12 May 2006 18:01:21 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1 of 53] ipath - fix spinlock recursion bug
In-Reply-To: <9b9f24aab3505e192ed1.1147477366@eng-12.pathscale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <patchbomb.1147477365@eng-12.pathscale.com>
	 <9b9f24aab3505e192ed1.1147477366@eng-12.pathscale.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/06, Bryan O'Sullivan <bos@pathscale.com> wrote:
> The local loopback path for RC can lock the rkey table lock without
> blocking interrupts.  The receive interrupt path can then call
> ipath_rkey_ok() and deadlock.  Since the lock only protects a 64 bit read,
> the lock isn't needed.
Uhhh, a 64 bit read is not atomic on all architectures. Certainly not i386.

Might want to verify safety of this.
