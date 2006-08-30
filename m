Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWH3SUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWH3SUR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 14:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWH3SUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 14:20:17 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:19100 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751288AbWH3SUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 14:20:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HVosWp6HRCnTMBVZHWsKz5WQaDlTLyJ752p0W8ezIdTNvldWNn7SsGGilkABDH50BEeupkMbXR2zdVNvt95Os3MSy7DNNAQJRuqyOD7mw83lRGj1ADUWfrZV6PtDr+TrSjTwohDKptflnqm/h+Bw19mV9/tTer7Y4H9n8tVQv5Y=
Message-ID: <18d709710608301120i3b2b67fkecf455d842d3336d@mail.gmail.com>
Date: Wed, 30 Aug 2006 15:20:15 -0300
From: "Julio Auto" <mindvortex@gmail.com>
To: "David Wagner" <daw-usenet@taverner.cs.berkeley.edu>,
       schwidefsky@de.ibm.com
Subject: Re: [S390] cio: kernel stack overflow.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <18d709710608301052u1307139dpf6e3b2da6e7bfcbe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060830124047.GA22276@skybase>
	 <ed4gno$d29$1@taverner.cs.berkeley.edu>
	 <18d709710608301052u1307139dpf6e3b2da6e7bfcbe@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/06, Julio Auto <mindvortex@gmail.com> wrote:
> Unless, of course, the structure in question is kcalloc()'d (which is
> not the case of gdev in the beginning of the patch - I haven't had the
> time to check the other cases).

Sorry, actually gdev is kzalloc()'d (which works exactly kcalloc()
without the check for n*size integer overflows). I was looking at a
much older version of the code.

I still think, however, that memset()'ing to zero is still something
to consider, in the cases where the structure is passed to the routine
(as opposed to when it's _created by_ the routine). The code shouldn't
rely on the awareness of future developers when adding other calls to
these functions.
