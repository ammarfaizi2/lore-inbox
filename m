Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVC3FiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVC3FiV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 00:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVC3FiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 00:38:20 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:26510 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261231AbVC3FiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 00:38:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=pCBjISvngdwaTc2obZ3T3TkS9QNt3b4BxBMlJUHYI850hND7xNwUFxNwOZqU2LNQxtJd2oZgZ1ZFZuoME6TV6Hyeg6bT5TUYrJHeSYJ+OtPHOwd88gbkHe3qTKy256aNd9brg6uAXgVCpMDgbGMLyZpszdnYbIJ2SOzX7uzF2CA=
Message-ID: <69304d110503292138620d4587@mail.gmail.com>
Date: Wed, 30 Mar 2005 07:38:10 +0200
From: Antonio Vargas <windenntw@gmail.com>
Reply-To: Antonio Vargas <windenntw@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: prefetch on ppc64
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
In-Reply-To: <16970.9005.721117.942549@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050330034034.GA1752@IBM-BWN8ZTBWA01.austin.ibm.com>
	 <16970.9005.721117.942549@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005 13:55:25 +1000, Paul Mackerras <paulus@samba.org> wrote:
> Serge E. Hallyn writes:
> 
> > While investigating the inordinate performance impact one of my patches
> > seemed to be having, we tracked it down to two hlist_for_each_entry
> > loops, and finally to the prefetch instruction in the loop.
> 
> I would be interested to know what results you get if you leave the
> loops using hlist_for_each_entry but change prefetch() and prefetchw()
> to do the dcbt or dcbtst instruction only if the address is non-zero,
> like this:
> 
> static inline void prefetch(const void *x)
> {
>         if (x)
>                 __asm__ __volatile__ ("dcbt 0,%0" : : "r" (x));
> }
> 
> static inline void prefetchw(const void *x)
> {
>         if (x)
>                 __asm__ __volatile__ ("dcbtst 0,%0" : : "r" (x));
> }
> 
> It seems that doing a prefetch on a NULL pointer, while it doesn't
> cause a fault, does waste time looking for a translation of the zero
> address.
> 
> Paul.

Don't know exactly about power5, but G5 processor is described on IBM
docs as doing automatic whole-page prefetch read-ahead when detecting
linear accesses.

-- 
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/

Las cosas no son lo que parecen, excepto cuando parecen lo que si son.
