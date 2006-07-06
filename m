Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbWGFPoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWGFPoY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 11:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbWGFPoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 11:44:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:45748 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030349AbWGFPoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 11:44:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p2kUGiMzzy5c0ZicLhhuPrHQbLVHs65Canko5e5FUPEYa189uOhYqh16Y2NM9uRAUiAwRqQRVFkqnrZCxazU8TvNcuexeU7FoOaxpFdzWTKT+6NwfflWrlffny4k4vooY1d4bD5Qyf445Co4PJ/1QLLyBr4XtbAhXlS1AJmDwbQ=
Message-ID: <a36005b50607060844s6c19fb3fp6e91eb1dc86dfbec@mail.gmail.com>
Date: Thu, 6 Jul 2006 08:44:20 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] Fix poll() nfds check.
Cc: "Vadim Lobanov" <vlobanov@speakeasy.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20060705203959.53e128ef.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.58.0607051949460.6604@shell3.speakeasy.net>
	 <20060705203959.53e128ef.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/06, Andrew Morton <akpm@osdl.org> wrote:
> [EINVAL]
>     The nfds argument is greater than {OPEN_MAX}, or ...

This requirement must be treated the same way as the EMFILE error in
open(): ignore the OPEN_MAX limit if ulimit says so.  The question is
what to do if the ulimit < OPEN_MAX.  POSIX does not require OPEN_MAX
to be the exact limit.

So, I think removing the OPEN_MAX comparison is the correct way to do
this here.  If somebody wants strict POSIX compliance they have to set
ulimit -n to 256.
