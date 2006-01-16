Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWAPHfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWAPHfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 02:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWAPHfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 02:35:46 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:48256
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932234AbWAPHfq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 02:35:46 -0500
Message-Id: <43CB5B15.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 16 Jan 2006 08:36:37 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Andi Kleen" <ak@muc.de>, "Andrew Morton" <akpm@osdl.org>,
       "Paul Mackerras" <paulus@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CONFIG_UNWIND_INFO
References: <4370AF4A.76F0.0078.0@novell.com>  <20060114045635.1462fb9e.akpm@osdl.org> <20060114140301.GA8443@mars.ravnborg.org>
In-Reply-To: <20060114140301.GA8443@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Sam Ravnborg <sam@ravnborg.org> 14.01.06 15:03:01 >>>
>On Sat, Jan 14, 2006 at 04:56:35AM -0800, Andrew Morton wrote:
>> 
>> > Index: linux/Makefile
>> > ===================================================================
>> > --- linux.orig/Makefile
>> > +++ linux/Makefile
>> > @@ -502,6 +502,10 @@ CFLAGS		+= $(call add-align,CONFIG_CC_AL
>> >  CFLAGS		+= $(call add-align,CONFIG_CC_ALIGN_LOOPS,-loops)
>> >  CFLAGS		+= $(call add-align,CONFIG_CC_ALIGN_JUMPS,-jumps)
>> >  
>> > +ifdef CONFIG_UNWIND_INFO
>> > +CFLAGS		+= -fasynchronous-unwind-tables
>> > +endif
>Is this option available on all gcc's for all archs?
>Otherwise you have to do:
>CFLAGS		+= $(call cc-option,-fasynchronous-unwind-tables,)

Yes, it is (and it has been at least since 3.2.x). Apparently the PPC backend doesn't fully support this...

Jan

