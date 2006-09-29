Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWI2QQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWI2QQM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 12:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWI2QQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 12:16:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:56957 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161116AbWI2QQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 12:16:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tp/hdcbKY9P6ad1ETKaehkDkjwIWQCN5QEqPoH6We8JBgb/YaJG8us21AA1uMfoEnfWjIlU4rsEJ9CgRpDAEb4WKkgyWLxbrBwLrhlducbWV4x0y52Ri8fXrE/Xkn9EvuuMWUs5zHRZUF0I2SGjfzWgGdp5hRkrdd21ziQ8lOF8=
Message-ID: <a2ebde260609290916j3a3deb9g33434ca5d93e7a84@mail.gmail.com>
Date: Sat, 30 Sep 2006 00:16:07 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: How is Code in do_sys_settimeofday() safe in case of SMP and Nest Kernel Path?
Cc: "Andi Kleen" <ak@suse.de>, "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Paul Mackerras" <paulus@samba.org>,
       "David Howells" <dhowells@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0609290903550.23840@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a2ebde260609290733m207780f0t8601e04fcf64f0a6@mail.gmail.com>
	 <Pine.LNX.4.64.0609290903550.23840@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/9/30, Christoph Lameter <clameter@sgi.com>:
> On Fri, 29 Sep 2006, Dong Feng wrote:
>
> > For my understanding, an assignment between structs should be a
> > bit-wise copy. Such operation is not atomic, so it can not be supposed
>
> Byte or Machine word yes.
>
> > SMP-safe. And the subsequent test-and-assign operation on firsttime is
> > not atomic, either.
>
> No its not atomic on its own. Correct.
>
> > If the comments mean the subsequent code is SMP-safe and can prevent
> > nest-kernel-path, how does it achieves that?
>
> It relies on locking outside of do_sys_settimeofday(). Seems that this
> indicates locking is to be performed by the arch before calling
> do_sys_settimeofday. Looks suspicious to me. Check that this function is
> always called with the same lock.
>

Yes, that is the question. The whole invocation path is
sys_settimeofday() -> do_sys_settimeofday()

I do not find a lock embracing do_sys_settimeofday().

Moreover, seems neither write operations nor read operations on sys_tz
is protected by any locks, in sys_gettimeofday() and
sys_settimeofday() respectively.
