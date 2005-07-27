Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVG0X1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVG0X1Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 19:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVG0XZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 19:25:21 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:27306 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261238AbVG0XXk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 19:23:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WukZzhyYjnKbgfuu69/AfoQGHxSYXKasgMxy50BtPnRizy8Onv6ZL/CGfD/ZijFp5DKxfFBhOOT1dbQm/6trJD5Xif64SURDotWAxjP4WhtzhYrhGGlyKRCGEio7DjEVO2L5Naehn2G6xgGk+5H0oclywonRyE00HHLXg4Tz+Lc=
Message-ID: <ed5aea4305072716233491f7f8@mail.gmail.com>
Date: Wed, 27 Jul 2005 16:23:37 -0700
From: david mosberger <dmosberger@gmail.com>
Reply-To: David.Mosberger@acm.org
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Add prefetch switch stack hook in scheduler function
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
In-Reply-To: <20050727161316.0593d762.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507272207.j6RM7fg18695@unix-os.sc.intel.com>
	 <20050727161316.0593d762.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also, should this be called prefetch_stack() or perhaps even just
prefetch_task()?  Not every architecture defines a switch_stack
structure.

  --david

-- 
Mosberger Consulting LLC, voice/fax: 510-744-9372,
http://www.mosberger-consulting.com/
35706 Runckel Lane, Fremont, CA 94536

On 7/27/05, Andrew Morton <akpm@osdl.org> wrote:
> "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
> >
> > +#ifdef ARCH_HAS_PREFETCH_SWITCH_STACK
> >  +extern void prefetch_switch_stack(struct task_struct*);
> >  +#else
> >  +#define prefetch_switch_stack(task) do { } while (0)
> >  +#endif
> 
> It is better to use
> 
> static inline void prefetch_switch_stack(struct task_struct *t) { }
> 
> in the second case, rather than a macro.  It provides typechecking.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
