Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbVJDTwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbVJDTwr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 15:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVJDTwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 15:52:47 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:46603 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964944AbVJDTwq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 15:52:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k2UNAUfLDHUz0g1uN4ERL14sABhoClQt//4fazhS1wi5YsC6YHnITCiAh5zWWu+vd/DBeZ8wnH5XOT6U1RKJhYj9lZ4dPs1cJ+7j9oaJTnA8smAT/Bw8K9mXFyPty6Hvtkdmf2S2rNbhSR7YO9Itw1ag82KzUfItAFPaoqWtNDc=
Message-ID: <3e1162e60510041252u286cb069jcfd589b9a0320232@mail.gmail.com>
Date: Tue, 4 Oct 2005 12:52:45 -0700
From: David Leimbach <leimy2k@gmail.com>
Reply-To: David Leimbach <leimy2k@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, David Leimbach <leimy2k@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: /etc/mtab and per-process namespaces
In-Reply-To: <20051004191818.GA31328@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3e1162e60510021508r6ef8e802p9f01f40fcf62faae@mail.gmail.com>
	 <3e1162e60510041214t3afd803re27b742705d27900@mail.gmail.com>
	 <20051004191818.GA31328@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/05, Christoph Hellwig <hch@infradead.org> wrote:
> I suspect not one cares about /etc/mtab.  It's a pretty horrible
> interface.  Use /proc/self/mounts if your care about the mount table
> for your current namespace, it's guranteed uptodate.
>
>

Hmmm that works pretty well, but it's lacking in some ways.

/dev/hdc3 /root/slash reiserfs rw 0 0
/dev/hdc3 /home/dave/blah resierfs rw 0 0

The above is not very descriptive.

/etc/mtab has:
/ /root/slash none rw,bind 0 0
/home/dave/public_html /home/dave/blah none rw,bind 0 0

Which tells me more about what I care about for 'bind' mounts.

However it does violate the "privacy" of the namespace by telling
everyone on the system how I have my stuff mounted :).

/proc/self/mounts does a much better job respecting this privacy but
doesn't give the information I really care about.

I think I'm looking for something like "ns" on Plan 9 or Inferno that
dumps out how my current namespace is constructed.  Each process with
a private namespace should get different results for "ns".

Dave
