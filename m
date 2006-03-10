Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751983AbWCJSsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbWCJSsS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 13:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbWCJSsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 13:48:17 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:37241 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751983AbWCJSsR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 13:48:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qoI6mrsT4py49QZvRuG8iiNygOPiisNDpZ7yo333DbPJVHa2faP8w7SOwyq7hWh25zOpnTzM8dNSL3/J4M0cVMlf/WabpKXhsuedS46g5o92P8hKBnTv7yr6bZ7ieOg5UUArndZwyYLEj6Gf0nfOe+xhYztE5AUb7OxKF8+EXUI=
Message-ID: <b6c5339f0603101048l1c362582xc4d2570bc9d569b@mail.gmail.com>
Date: Fri, 10 Mar 2006 13:48:15 -0500
From: "Bob Copeland" <email@bobcopeland.com>
To: "Paul Fulghum" <paulkf@microgate.com>
Subject: Re: 2.6.16-rc5 pppd oops on disconnects
Cc: paulus@samba.org, "Linux Kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <1142011340.3220.4.camel@amdx2.microgate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b6c5339f0603100625k3410897fy3515d93fa1918c9@mail.gmail.com>
	 <1142011340.3220.4.camel@amdx2.microgate.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Call Trace:
> >  [<c017592e>] sysfs_hash_and_remove+0x34/0x10a
> >  [<c01e756e>] class_device_del+0xa0/0x11c
> >  [<c01e75f5>] class_device_unregister+0xb/0x16
> >  [<d01f81f3>] acm_tty_unregister+0x1d/0x63 [cdc_acm]
>
> This looks more like
> http://bugzilla.kernel.org/show_bug.cgi?id=5876

Hmm... it looks different from that bug - in that case the root cause
was sysfs_make_dirent failing, presumably when the sysfs node for the
device was being set up, by unplugging and re-plugging the device a
lot.  Here it's oopsing when the node is being removed, after it's
been in use a while and unplugged only once.  But yes ppp may not have
anything to do with it.  I'll try it on an older kernel to see if I
can reproduce there...

-Bob
