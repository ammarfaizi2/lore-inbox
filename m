Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbVHAHKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbVHAHKa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 03:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbVHAHK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 03:10:29 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:61273 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262408AbVHAHJx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 03:09:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jRXqNla7XcDc78l/Gc/rwQKKKtgf/1Mbj8q5Owjn0rGI9xKMORDaDtGj8U1mErzkIaFJ02A+/9B5pdG49Bel/6PodF8LFFNQiKGbinjbvTVbi1vIGH/YL80jMt5biHIjSh9iSnjGY/WzCsXtRpE8t3YTAVpRKFVnBUIUX1Fcbqc=
Message-ID: <a36005b50508010009453fdfb7@mail.gmail.com>
Date: Mon, 1 Aug 2005 00:09:53 -0700
From: Ulrich Drepper <drepper@gmail.com>
Reply-To: Ulrich Drepper <drepper@gmail.com>
To: Roland McGrath <roland@redhat.com>
Subject: Re: Fw: sigwait() breaks when straced
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050801000120.1D00F180EC0@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050730170049.6df9e39f.akpm@osdl.org>
	 <20050801000120.1D00F180EC0@magilla.sf.frob.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/05, Roland McGrath <roland@redhat.com> wrote:
> However, there is in fact no bug here.  The test program is just wrong.
> sigwait returns zero or an error number, as POSIX specifies.

No question, no error is detected incorrectly.

But sigwait is not a function specified with an EINTR error number. 
As I said before, this does not mean that EINTR cannot be returned. 
But it will create havoc among programs and it causes undefined
behavior wrt to SA_RESTART.  I think it is best to not have any
function for which EINTR is not a defined error to fail this way. 
This causes the least amount of surprises and unnecessary loops around
the userlevel call sites.
