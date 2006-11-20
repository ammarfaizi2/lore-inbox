Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966604AbWKTT6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966604AbWKTT6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966606AbWKTT6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:58:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:38949 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S966604AbWKTT6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:58:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=I/RjDpRhotn99Dxf4unB8Wlqzknie2PK+scC23+kYET/b75q28IpNI6wrIA19IIFn1D/RVqR4Ta767Xm4bVPzKRRR31nd3nP/LGV87T/qQWXjVCEy0JyjbwWeN0Q2nqon5AG+dkoUGBYrhAv2cZIoPlm1lIjQLPzZ0YfzIxSK64=
Date: Tue, 21 Nov 2006 04:52:08 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Don Mullis <dwm@meer.net>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm <akpm@osdl.org>
Subject: Re: [PATCH -mm] fault-injection: reject-failure-if-any-caller-lies-within-specified range
Message-ID: <20061120195208.GA18077@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Don Mullis <dwm@meer.net>, linux-kernel@vger.kernel.org, ak@suse.de,
	akpm <akpm@osdl.org>
References: <455217df.719dec4f.2c80.ffffb500@mx.google.com> <1163991847.2912.15.camel@localhost.localdomain> <20061120105735.GA9795@APFDCB5C> <1164050662.2912.55.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164050662.2912.55.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 11:24:22AM -0800, Don Mullis wrote:
> > This test is a little intentional.
> > (Normal I/O may fail, but journal commit I/O doesn't fail)
> 
> I'm not sure in what sense the test could be called "intentional".

Because make_fault_request just injects failures randomly. there is no
difference between normal I/O and journal commit I/O.

The problem is the make_fault_request doesn't have clever setting such as
md/faulty module can simulate broken sectors.

> The patch raises the default stacktrace-depth from 10 to 32, and
> although there is indeed no guarantee this is enough, in practice I
> found the filesystem became hopelessly scrambled before ever hitting one
> of the kjournald cases again.

You can set /debug/fail_make_request/times smaller value so that
you can see what happened in filesystem before kjournald hits failure.

