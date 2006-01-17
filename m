Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWAQKWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWAQKWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 05:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWAQKWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 05:22:12 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:2500 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932384AbWAQKWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 05:22:12 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@osdl.org>
cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mita@miraclelinux.com
Subject: Re: [patch 2.6.15-current] i386: multi-column stack backtraces 
In-reply-to: Your message of "Mon, 16 Jan 2006 22:42:34 -0800."
             <20060116224234.5a7ca488.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Jan 2006 21:22:09 +1100
Message-ID: <9554.1137493329@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton (on Mon, 16 Jan 2006 22:42:34 -0800) wrote:
>Chuck Ebbert <76306.1226@compuserve.com> wrote:
>>
>> Print stack backtraces in multiple columns, saving screen space.
>> Number of columns is configurable and defaults to one so 
>> behavior is backwards-compatible.
>> 
>> Also removes the brackets around addresses when printing more
>> that one entry per line so they print as:
>>     <address>
>> instead of:
>>     [<address>]
>> This helps multiple entries fit better on one line.
>> 
>> Original idea by Dave Jones, taken from x86_64.
>> 
>
>Presumably this is going to bust ksymoops.  Also the various other custom
>oops-parsers which people have written themselves.

Should not be a problem for ksymoops.  Most entries use this regex,
where [ ] is optional.

#define BRACKETED_ADDRESS       "\\[*<([0-9a-fA-F]{4,})>\\]* *"

Printing multiple addresses (with our without [ ]) plus their symbols
on the same line will stop ksymoops processing at the first symbol
name, but who cares?  If you can print a symbol then you already have
kallsyms and you do not need ksymoops.  If you do not have kallsyms
then the output is just multiple addresses on one line, which ksymoops
already handles.

