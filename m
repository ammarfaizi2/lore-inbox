Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbVHRN4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVHRN4E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 09:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbVHRN4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 09:56:04 -0400
Received: from dvhart.com ([64.146.134.43]:21633 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932231AbVHRN4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 09:56:03 -0400
Date: Sun, 14 Aug 2005 07:50:22 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference	between /dev/kmem and /dev/mem)
Message-ID: <130440000.1124031022@[10.10.2.4]>
In-Reply-To: <1123951810.3187.20.camel@laptopd505.fenrus.org>
References: <1123796188.17269.127.camel@localhost.localdomain> <1123809302.17269.139.camel@localhost.localdomain> <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org> <1123951810.3187.20.camel@laptopd505.fenrus.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Arjan van de Ven <arjan@infradead.org> wrote (on Saturday, August 13, 2005 18:50:10 +0200):

> On Fri, 2005-08-12 at 09:35 -0700, Linus Torvalds wrote:
>> 
>> On Thu, 11 Aug 2005, Steven Rostedt wrote:
>> > 
>> > Found the problem.  It is a bug with mmap_kmem.  The order of checks is
>> > wrong, so here's the patch.  Attached is a little program that reads the
>> > System map looking for the variable modprobe_path.  If it finds it, then
>> > it opens /dev/kmem for read only and mmaping it to read the contents of
>> > modprobe_path.
>> 
>> I'm actually more inclined to try to deprecate /dev/kmem.. I don't think 
>> anybody has ever really used it except for some rootkits. It only exists 
>> in the first place because it's historical.
>> 
>> We do need to support /dev/mem for X, but even that might go away some 
>> day. 
>> 
>> So I'd be perfectly happy to fix this, but I'd be even happier if we made 
>> the whole kmem thing a config variable (maybe even default it to "off").
> 
> attached is a simple patch that does exactly this...

Whilst there's no normal legitimite usage for it, it is useful for debugging.
One thing I often do is create a circular log buffer, then fish it back 
out by mmaping /dev/mem or /dev/kmem, and going by system.map offsets.
No, nobody could claim it was clean or elegant, but it *is* useful.
M.

